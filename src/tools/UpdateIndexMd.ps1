# 指定されたファイルの指定されたキーワード移行を指定されたコンテンツに書き換える
# @param $Filename 更新するファイル名
# @param $Keyword 検索するキーワード。見つからない場合は更新しない。
# @param $Content 置き換えるコンテンツ。
function Update-SaFile{
	param($Filename, $Keyword, $Content)
	$OriginalContent=((Get-Content $Filename -Encoding UTF8) -join "`n")+"`n";
	$KeywordIndex=$OriginalContent.IndexOf($Keyword);
	if($KeywordIndex -ge 0){
		$OutputContent=$OriginalContent.Substring(0,$KeywordIndex+$Keyword.Length+1)+$Content;
		[System.IO.File]::WriteAllText($Filename,$OutputContent)
	}
}

# markdown のリストを出力する
# @param $ListItems `/` で区切られたリストの内容。
# @param $Indent デフォルトの字下げの数。
function Get-SaMarkdownLists{
	param(
		[string[]]$ListItems,
		$Indent = 0
	)
	$PreIndentedListItems=@()
	$IsOutput=$true
	$OutputString=""
	foreach($ListItem in $ListItems){
		$CurrentIndentedListItems=$ListItem -split '/'
		$CurrentOutputString=""
		
		for($counter=0; $counter -lt $CurrentIndentedListItems.Length; $counter++){
			$myMdPath = $CurrentIndentedListItems[$counter];
			if(-not $IsOutput){
				if($counter -lt $PreIndentedListItems.Length){
					if($myMdPath -ne $PreIndentedListItems[$counter]){
						$IsOutput=$true
					}
				}else {
					$IsOutput=$true
				}
			}
			if($IsOutput){
				$CurrentOutputString+=("`t" * ($counter + $Indent)) +  "- $myMdPath`n"
			}
		}
		$OutputString+=$CurrentOutputString
		$PreIndentedListItems=$CurrentIndentedListItems
		$IsOutput=$false
	}
	$OutputString
}

# index.md の更新を行う。
function Update-SaIndexMd{
	# Root の md ファイル名と見出しの一覧を作成
	$RootMdFiles = Get-ChildItem *.md -Exclude index.md | ForEach-Object {$Heading=(Get-Content $_.FullName -TotalCount 1 -Encoding utf8) -replace '^# (.+) \<\!-- omit in toc --\>', '$1';$RelativePath=(Resolve-Path $_ -Relative) -replace '\\','/';@{Heading=$Heading; RelativePath=$RelativePath}}

	# Root の md ファイル名と見出しの一覧 を元に見出しのリストの作成
	$RootLists = ($RootMdFiles | ForEach-Object{"`t- [$($_.Heading)]"}) -join "`n"
	
	# Root の md ファイル名と見出しの一覧 を元に HeadingIDs の作成
	$HeadingIDsForRoot = ($RootMdFiles | ForEach-Object{"[$($_.Heading)]: $($_.RelativePath)"}) -join "`n"

	#これを変更してtmp/HeadingIDsForRoot2.md を作る
	# Root の md ファイル名と見出しの一覧 を元に HeadingIDs の作成
	$HeadingIDsForRootToRoot = (($RootMdFiles | ForEach-Object{"[ReadingLyra > $($_.Heading)]: $($_.RelativePath)"}) -join "`n")+"`n"
	[System.IO.File]::WriteAllText("$PSScriptRoot\..\tmp\HeadingIDsForRootToRoot.md", $HeadingIDsForRootToRoot)

	# CodeRefs 以下の md ファイル名の一覧を作成
	$CodeRefsMdFilenames = Get-ChildItem CodeRefs -Include *.md -Recurse | ForEach-Object{((Resolve-Path $_ -Relative) -replace '\\','/')}

	# CodeRefs 以下の md ファイル名の一覧 を元に見出しのリストの作成
	$MdListItems = $CodeRefsMdFilenames | ForEach-Object{($_ -replace './CodeRefs/', '') -replace '/(\w+)\.md', '/[$1]'}
	$CodeRefsLists = Get-SaMarkdownLists -ListItems $MdListItems -Indent 1

	# CodeRefs 以下の md ファイル名の一覧 を元に HeadingIDs の作成
	$HeadingIDsForCodeRefs = ($CodeRefsMdFilenames | ForEach-Object{$_ -replace '(.+)/(\w+)\.md', '[$2]: $1/$2.md'}) -join "`n"

	$myContent="- 実装解説`n"+$RootLists+"`n- クラス解説`n"+$CodeRefsLists+"`n<!--- HedaingIDs --->`n"+$HeadingIDsForRoot+"`n"+$HeadingIDsForCodeRefs+"`n"
	Update-SaFile -Filename "$PSScriptRoot\..\..\docs\index.md" -Keyword '<!--- generatede --->' -Content $myContent
}

Push-Location "$PSScriptRoot\..\..\docs"
Update-SaIndexMd
Pop-Location
