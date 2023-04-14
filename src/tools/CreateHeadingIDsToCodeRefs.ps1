# Get-SaAnchor 関数の取り込み
. .\Get-SaAnchor.ps1

# /docs/CodeRefs 以下の md ファイルから見出しを取得し、 HeadingID をファイルに出力する。
# HeadingIDsToCodeRefsForCodeRefs.md は /docs/CodeRefs 以下に置かれたファイルで使用するためのもの。
# HeadingIDsToCodeRefsForRoot.md は /docs に置かれたファイルで使用するためのもの。
function Set-SaAllHeadingIDs{
	$Targets = @(
		@{Filename ="HeadingIDsToCodeRefsForCodeRefs.md"; AnchorPath="../.."},
		@{Filename ="HeadingIDsToCodeRefsForRoot.md"; AnchorPath="CodeRefs"}
	)

	$MdFiles = Get-ChildItem -Recurse -Path CodeRefs -Include *.md | Select-String '^#' | ForEach-Object {$FileBase=[System.IO.Path]::GetFileNameWithoutExtension($_.Path);$Heading=$_.Line -replace '^#+\s','';$LinkName=if($Heading.IndexOf($FileBase) -eq -1){"$FileBase::$Heading"}else{"$Heading"};$RelativePath=$_.RelativePath("${PWD}\CodeRefs") -replace '\\','/';$Anchor=Get-SaAnchor -Heading $LinkName;@{LinkName=$LinkName; RelativePath=$RelativePath; Anchor=$Anchor} }

	foreach($Target in $Targets.GetEnumerator()){
		$myOut = (($MdFiles | ForEach-Object{"[$($_.LinkName)]: $($Target.AnchorPath)/$($_.RelativePath)#$($_.Anchor)"}) -join "`n") + "`n"
		$myOutputFullName = "$PSScriptRoot\..\tmp\$($Target.Filename)"
		[System.IO.File]::WriteAllText($myOutputFullName, $myOut)
	}
}

Push-Location "$PSScriptRoot\..\..\docs"
Set-SaAllHeadingIDs
Pop-Location
