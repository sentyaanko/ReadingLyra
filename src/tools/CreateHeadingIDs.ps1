# /docs/CodeRefs 以下の md ファイルから見出しを取得し、 HeadingID をファイルに出力する。
# HeadingIDsForCodeRefs.md は /docs/CodeRefs 以下に置かれたファイルで使用するためのもの。
# HeadingIDsForRoot.md は /docs に置かれたファイルで使用するためのもの。
function Set-SaAllHeadingIDs{
	$Targets = @(
		@{Filename ="HeadingIDsForCodeRefs.md"; AnchorPath="../.."},
		@{Filename ="HeadingIDsForRoot.md"; AnchorPath="CodeRefs"}
	)

	$MdFiles = Get-ChildItem -Recurse -Include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$RelativePath=$_.RelativePath($PWD) -replace '\\','/';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();@{LinkName=$LinkName; RelativePath=$RelativePath; Anchor=$Anchor} }

	foreach($Target in $Targets.GetEnumerator()){
		$myOut = (($MdFiles | ForEach-Object{"[$($_.LinkName)]: $($Target.AnchorPath)/$($_.RelativePath)#$($_.Anchor)"}) -join "`n") + "`n"
		$myOutputFullName = "$PSScriptRoot\..\tmp\$($Target.Filename)"
		[System.IO.File]::WriteAllText($myOutputFullName, $myOut)
	}
}

Push-Location "$PSScriptRoot\..\..\docs\CodeRefs"
Set-SaAllHeadingIDs
Pop-Location
