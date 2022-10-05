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

# 使用中の HeadingID の Index 配列の取得
# @param $HeadingIDs HeadingID が記述されたファイル名
# @param $UsingIDs 使用されている HeadingID
# @param $HeadingIDsLocal ローカルで指定されている HeadingIDs
# @param $SplitedHeadingIDs 入力オブジェクト
function Get-SaUsingHeadingIDsIndexes{
	param(
		[string]$HeadingIDs,
		[string[]]$UsingIDs,
		[hashtable]$HeadingIDsLocal,
		[string[]]$SplitedHeadingIDs
	)
	$dic=Select-SaString -SplitedContent $SplitedHeadingIDs -Pattern '^(\[[^\]]{2,}\]): +(.+)$'
	$UsingIDs | ForEach-Object{if($dic.ContainsKey($_)){$dic[$_]}else{if($HeadingIDsLocal.ContainsKey($_)){}else{Write-Warning -Message "$_ is not found."}}}
}

# 使用中の HeadingID の取得
# @param $HeadingIDs HeadingID が記述されたファイル名
# @param $UsingIDs 使用されている HeadingID
# @param $HeadingIDsLocal ローカルで指定されている HeadingIDs
function Get-SaUsingHeadingIDs{
	param(
		[string]$HeadingIDs,
		[string[]]$UsingIDs,
		[hashtable]$HeadingIDsLocal
	)
	$SplitedHeadingIDs=$HeadingIDs -split "`n"
	$UsingHeadingIDsIndexes=Get-SaUsingHeadingIDsIndexes -HeadingIDs $HeadingIDs -UsingIDs $UsingIDs -HeadingIDsLocal $HeadingIDsLocal -SplitedHeadingIDs $SplitedHeadingIDs
	(($UsingHeadingIDsIndexes | Sort-Object | ForEach-Object{$SplitedHeadingIDs[$_]}) -join "`n")+"`n"
}

# 更新後のコンテンツの取得
# @param $HeadingIDs HeadingID が記述されたファイル名
# @param $Content 元となるコンテンツ
function Get-SaUpdatedContent{
	param(
		[string]$HeadingIDs,
		[string]$Content
	)
	$UsingIDs=@()
	$HeadingIDsLocal=@{}
	if($true){
		$SplitedContent=$Content -split "`n"
		$UsingIDsSet=Select-SaString -SplitedContent $SplitedContent -Pattern '(\[[^\]]{2,}\])([^:(]|$)'
		$HeadingIDsLocal=Select-SaString -SplitedContent $SplitedContent -Pattern '^(\[[^\]]{2,}\]): +(.+)$'
		$UsingIDs=$UsingIDsSet.Keys
	}

	$UsingHeadingIDs=Get-SaUsingHeadingIDs -HeadingIDs $HeadingIDs -UsingIDs $UsingIDs -HeadingIDsLocal $HeadingIDsLocal
	$Content+$UsingHeadingIDs
}
# .md ファイルの HeadingID の更新処理
# @param $HeadingIDsFullName 利用する HeadingIDs のファイル名
# @param $Keyword 書き換えを行う目印
# @param $Path Get-ChildItem 用
# @param $Include Get-ChildItem 用
# @param $Recurse Get-ChildItem 用
# @param $Exclude Get-ChildItem 用
function Set-SaMdHeadingIDs{
	param(
		[string[]]$HeadingIDsFullNames,
		$Keyword,
		[string[]]$Path,
		[string[]]$Include,
		[string[]]$Exclude,
		[switch]$Recurse
	)
	# HeadingID の内容を取得しておく
	$HeadingIDs=($HeadingIDsFullNames | ForEach-Object{[System.IO.File]::ReadAllText($_)}) -join ""

	# Keyword 以降を $HeadingIDs の内容で上書き
	Get-ChildItem -Path:$Path -Include:$Include -Exclude:$Exclude -Recurse:$Recurse | ForEach-Object {$OriginalContent=((Get-Content $_.FullName -Encoding UTF8) -join "`n")+"`n";$KeywordIndex=$OriginalContent.IndexOf($Keyword);if($KeywordIndex -ge 0){$OutputContent=Get-SaUpdatedContent -HeadingIDs $HeadingIDs -Content $OriginalContent.Substring(0,$KeywordIndex+$Keyword.Length+1);[System.IO.File]::WriteAllText($_.FullName,$OutputContent)}}
#	Get-ChildItem -Path:$Path -Include:$Include -Exclude:$Exclude -Recurse:$Recurse | ForEach-Object {$OriginalContent=((Get-Content $_.FullName -Encoding UTF8) -join "`n")+"`n";$KeywordIndex=$OriginalContent.IndexOf($Keyword);if($KeywordIndex -ge 0){Get-SaUpdatedContent -HeadingIDs $HeadingIDs -Content $OriginalContent.Substring(0,$KeywordIndex+$Keyword.Length+1)}}
}

# .md ファイルの HeadingID の更新処理
function Set-SaAllMdHeadingIDs{
	# /docs/CodeRefs 以下の .md ファイルの HeadingID の更新処理
	Set-SaMdHeadingIDs -Path:"$PSScriptRoot\..\..\docs\CodeRefs\*" -Include:*.md -Recurse -HeadingIDsFullNames:"$PSScriptRoot\..\tmp\HeadingIDsToCodeRefsForCodeRefs.md","$PSScriptRoot\..\tmp\HeadingIDsToExternal.md" -Keyword:'<!--- generated --->'
	
	# /docs の .md ファイルの HeadingID の更新処理
	Set-SaMdHeadingIDs -Path:"$PSScriptRoot\..\..\docs\*" -Include:*.md -Exclude:index.md -HeadingIDsFullNames:"$PSScriptRoot\..\tmp\HeadingIDsToRoot.md","$PSScriptRoot\..\tmp\HeadingIDsToCodeRefsForRoot.md","$PSScriptRoot\..\tmp\HeadingIDsToExternal.md" -Keyword:'<!--- generated --->'
}

Set-SaAllMdHeadingIDs
