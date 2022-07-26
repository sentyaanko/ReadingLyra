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
# @param $IndentString 字下げの文字。
# @param $Indent デフォルトの字下げの数。
# @param $Path ルートパス
function Get-SaYml{
	param(
		[string[]]$ListItems,
		$IndentString = "  ",
		$Indent = 0,
		$Path ='./CodeRefs/'
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
				$CurrentOutputString+=($IndentString * ($counter + $Indent)) +  "- ${myMdPath}:`n"
			}
		}
		
		$OutputString+=$CurrentOutputString.TrimEnd("`n")+" $Path$ListItem`n"
		$PreIndentedListItems=$CurrentIndentedListItems
		$IsOutput=$false
	}
	$OutputString
}

# navis.yml の更新を行う。
function Update-SaNavisYml{
	# Root の md ファイル名と見出しの一覧を作成
	$RootMdFiles = Get-ChildItem *.md -Exclude index.md | ForEach-Object {$Heading=(Get-Content $_.FullName -TotalCount 1 -Encoding utf8) -replace '^# (.+) \<\!-- omit in toc --\>', '$1';$RelativePath=((Resolve-Path $_ -Relative) -replace '\\','/') -replace '/(\w+)\.md', '/$1';@{Heading=$Heading; RelativePath=$RelativePath}}

	# Root の md ファイル名と見出しの一覧 を元に yml 配列の作成
	$RootYml = ($RootMdFiles | ForEach-Object{"    - $($_.Heading): $($_.RelativePath)"}) -join "`n"

	# CodeRefs 以下の md ファイル名の一覧を作成
	$CodeRefsMdFilenames = Get-ChildItem CodeRefs -Include *.md -Recurse | ForEach-Object{((Resolve-Path $_ -Relative) -replace '\\','/')}

	# CodeRefs 以下の md ファイル名の一覧 を元に yml 配列の作成
	$MdListItems = $CodeRefsMdFilenames | ForEach-Object{($_ -replace './CodeRefs/', '') -replace '/(\w+)\.md', '/$1'}
	$CodeRefsYml = Get-SaYml -ListItems $MdListItems -Indent 2 -IndentString "  " -Path './CodeRefs/'

	$myContent="nav:`n  - 実装解説:`n"+$RootYml+"`n  - クラス解説:`n"+$CodeRefsYml+"`n"
	Update-SaFile -Filename "$PSScriptRoot\..\..\docs\_data\navis.yml" -Keyword '# generated' -Content $myContent
}

Push-Location "$PSScriptRoot\..\..\docs"
Update-SaNavisYml
Pop-Location
