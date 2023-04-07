# Get-SaAnchor 関数の取り込み
. .\Get-SaAnchor.ps1

# 変数名を以下のルールにしておきます。
# FPL: markdown の Reference-style Links の First Part of the Link 。インラインに記載する "[linkname]" のこと。
# SPL: markdown の Reference-style Links の Second Part of the Link 。任意の場所に記載する "[linkname]: https://hoge.com" のこと。

# キーが検索パターンにマッチした文字列で値がマッチしたインデックスの連想配列を取得する
# @param $SplitedContent 入力オブジェクト
# @param $Pattern 検索パターン
function Select-SaString{
	param(
		[string[]]$SplitedContent,
		[string[]]$Pattern
	)
	$DataSet=@{}
	$Index=0
	$SplitedContent | Select-String -AllMatches -Pattern $Pattern | ForEach-Object{$_.Matches} | ForEach-Object{$DataSet[$_.Groups[1].Value]=$Index;$Index++}
	$DataSet
}

# HeadingIDs ファイルに記載されている SPL の使用中の Index 配列の取得
# @param $SPLHeadingIDs HeadingIDs ファイルに記載されている SPL 。この中を検索する。
# @param $FPLUsing 使用されている FPL 。この中にあるものを検索する。
# @param $SPLLocalDefined ローカルに記載されている SPL 。 $SPLHeadingIDs の中になく、この中にもない場合は警告を表示する。
# @param $FPLHeadings ファイル内のヘッダーから作った FPL 。この中にあるものは出力しない。
function Get-SaIndexOfSPL{
	param(
		[string[]]$SPLHeadingIDs,
		[string[]]$FPLUsing,
		[string[]]$SPLLocalDefined,
		[string[]]$FPLHeadings
	)
	$dic=Select-SaString -SplitedContent $SPLHeadingIDs -Pattern '^(\[[^\]]{2,}\]): +(.+)$'
	$FPLUsing | ForEach-Object{if($FPLHeadings.Contains($_)){}else{if($dic.ContainsKey($_)){$dic[$_]}else{if($SPLLocalDefined.Contains($_)){}else{Write-Warning -Message "$_ is not found."}}}}
}

# 参照している SPL を join した文字列を取得する
# @param $SPLHeadingIDs HeadingIDs ファイルに記載されている SPL
# @param $FPLUsing 使用されている FPL
# @param $SPLLocalDefined ローカルに記載されている SPL
# @param $FPLHeadings ファイル内のヘッダーから作った FPL
function Get-SaJoinedSPLReferencing{
	param(
		[string[]]$SPLHeadingIDs,
		[string[]]$FPLUsing,
		[string[]]$SPLLocalDefined,
		[string[]]$FPLHeadings
	)
	$IndexOfSPL=Get-SaIndexOfSPL -FPLUsing $FPLUsing -SPLLocalDefined $SPLLocalDefined -FPLHeadings $FPLHeadings -SPLHeadingIDs $SPLHeadingIDs
	(($IndexOfSPL | Sort-Object | ForEach-Object{$SPLHeadingIDs[$_]}) -join "`n")+"`n"
}

# 更新後のコンテンツの取得
# @param $SPLHeadingIDs HeadingIDs ファイルに記載されている SPL
# @param $Content 元となるコンテンツ
function Get-SaUpdatedContent{
	param(
		[string[]]$SPLHeadingIDs,
		[string]$Content
	)
	# Content を行分割する
	$SplitedContent=$Content -split "`n"

	# Content から # で始まる行を探し、 heading と anchor のペアの配列を作る
	$HeadingToAnchorDic=$SplitedContent | Select-String '^#' | ForEach-Object {$LinkName=($_.Line -replace '^#+\s','') -replace '\s+\<\!-- omit in toc --\>', '';$Anchor=Get-SaAnchor -Heading $LinkName;@{LinkName=$LinkName;Anchor=$Anchor}}
	# Joined SPL を作る
	#$JoinedSPLHeadingAnchors=(($HeadingToAnchorDic | ForEach-Object{"[$($_.LinkName)]: #$($_.Anchor)"}) -join "`n") + "`n"
	[string[]]$SPLHeadingAnchors=$HeadingToAnchorDic | ForEach-Object{"[$($_.LinkName)]: #$($_.Anchor)"}
	#$JoinedSPLHeadingAnchors=($SPLHeadingAnchors -join "`n") + "`n"
	# anchor のみを取り出して FPL を作る
	#$FPLHeadings=$HeadingToAnchorDic | ForEach-Object{"[$($_.LinkName)]"}
	$FPLHeadings=@()

	$FPLUsing=(Select-SaString -SplitedContent $SplitedContent -Pattern '(\[[^\]]{2,}\])([^:(]|$)').Keys
	$SPLLocalDefined=(Select-SaString -SplitedContent $SplitedContent -Pattern '^(\[[^\]]{2,}\]): +(.+)$').Keys

	$SPLAll = $SPLHeadingAnchors + $SPLHeadingIDs
#	$SPLAll = $SPLHeadingAnchors 
#	$SPLAll += $SPLHeadingIDs
#	$SPLAll = $SPLHeadingIDs
	$JoinedSPLReferencing=Get-SaJoinedSPLReferencing -SPLHeadingIDs $SPLAll -FPLUsing $FPLUsing -SPLLocalDefined $SPLLocalDefined -FPLHeadings $FPLHeadings
	$Content+$JoinedSPLReferencing
	#$JoinedSPLReferencing=Get-SaJoinedSPLReferencing -SPLHeadingIDs $SPLHeadingIDs -FPLUsing $FPLUsing -SPLLocalDefined $SPLLocalDefined -FPLHeadings $FPLHeadings
	#$Content+$JoinedSPLHeadingAnchors+"`n"+$JoinedSPLReferencing
}
# .md ファイルの SPL の更新処理
# @param $HeadingIDsFullName 利用する HeadingIDs のファイル名
# @param $Keyword 書き換えを行う目印
# @param $Path Get-ChildItem 用
# @param $Include Get-ChildItem 用
# @param $Recurse Get-ChildItem 用
# @param $Exclude Get-ChildItem 用
function Set-MdReferenceStyleLinks{
	param(
		[string[]]$HeadingIDsFullNames,
		[string]$Keyword,
		[string[]]$Path,
		[string[]]$Include,
		[string[]]$Exclude,
		[switch]$Recurse
	)
	# HeadingID の内容を取得しておく
	$ContentHeadingIDs=($HeadingIDsFullNames | ForEach-Object{[System.IO.File]::ReadAllText($_)}) -join ""
	# 行ごとに分割する
	$SPLHeadingIDs=$ContentHeadingIDs -split "`n"

	# Keyword 以降を Second Part of the Link で上書き
	Get-ChildItem -Path:$Path -Include:$Include -Exclude:$Exclude -Recurse:$Recurse | ForEach-Object {$OriginalContent=((Get-Content $_.FullName -Encoding UTF8) -join "`n")+"`n";$KeywordIndex=$OriginalContent.IndexOf($Keyword);if($KeywordIndex -ge 0){$OutputContent=Get-SaUpdatedContent -SPLHeadingIDs $SPLHeadingIDs -Content $OriginalContent.Substring(0,$KeywordIndex+$Keyword.Length+1);[System.IO.File]::WriteAllText($_.FullName,$OutputContent)}}
}

# 全 .md ファイルの SPL の更新処理
function Set-SaAllMdReferenceStyleLinks{
	# /docs/CodeRefs 以下の .md ファイルの Second Part of the Link の更新処理
	Set-MdReferenceStyleLinks -Path:"$PSScriptRoot\..\..\docs\CodeRefs\*" -Include:*.md -Recurse -HeadingIDsFullNames:"$PSScriptRoot\..\tmp\HeadingIDsToCodeRefsForCodeRefs.md","$PSScriptRoot\..\tmp\HeadingIDsToExternal.md" -Keyword:'<!--- generated --->'
	
	# /docs の .md ファイルの Second Part of the Link の更新処理
	Set-MdReferenceStyleLinks -Path:"$PSScriptRoot\..\..\docs\*" -Include:*.md -Exclude:index.md -HeadingIDsFullNames:"$PSScriptRoot\..\tmp\HeadingIDsToRoot.md","$PSScriptRoot\..\tmp\HeadingIDsToCodeRefsForRoot.md","$PSScriptRoot\..\tmp\HeadingIDsToExternal.md" -Keyword:'<!--- generated --->'
}

Set-SaAllMdReferenceStyleLinks
