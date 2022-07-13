# ps1 の実行の際は事前に以下のようなコマンドで、 ps1ファイルのブロック解除と powershell の実行ポリシーを変更しておく必要があります。
# Unblock-File CreateHeadingIDs.ps1
# Set-ExecutionPolicy RemoteSigned -Scope Process

# /docs/CodeRefs 以下の md ファイルから見出しを取得し、 HeadingID をファイルに出力する。
# HeadingIDsForCodeRefs.md は /docs/CodeRefs 以下に置かれたファイルで使用するためのもの。
# HeadingIDsForRoot.md は /docs に置かれたファイルで使用するためのもの。
function Set-SaAllHeadingIDs{
	$myTargets = @{"HeadingIDsForCodeRefs.md" = "../..";"HeadingIDsForRoot.md" = "CodeRefs"}

	$myArray = Get-ChildItem -Recurse -Include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$RelativePath=$_.RelativePath($PWD) -replace '\\','/';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();@{"LinkName"=$LinkName; "RelativePath"=$RelativePath; "Anchor"=$Anchor} }

	foreach($myTarget in $myTargets.GetEnumerator()){
		$myOutputFilename=$myTarget.Key
		$myAnchorPath=$myTarget.Value
		$myOut = (($myArray | ForEach-Object{$LinkName=$_['LinkName'];$RelativePath=$_['RelativePath'];$Anchor=$_['Anchor'];"[$LinkName]: $myAnchorPath/$RelativePath#$Anchor"}) -join "`n") + "`n"
		$myOutputFullName = "$PSScriptRoot\..\tmp\$myOutputFilename"
		[System.IO.File]::WriteAllText($myOutputFullName, $myOut)
	}
}

Push-Location "$PSScriptRoot\..\..\docs\CodeRefs"
Set-SaAllHeadingIDs
Pop-Location
