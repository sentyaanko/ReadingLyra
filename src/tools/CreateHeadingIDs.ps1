# ps1 の実行の際は事前に以下のようなコマンドで、 ps1ファイルのブロック解除と powershell の実行ポリシーを変更しておく必要があります。
# Unblock-File CreateHeadingIDs.ps1
# Set-ExecutionPolicy RemoteSigned -Scope Process

$tempPath = $PSScriptRoot + '\..\..\docs\CodeRefs'
Push-Location $tempPath

# /docs/CodeRefs 以下の md ファイルから見出しを取得し、 HeadingID をファイルに出力する。
# HeadingIDsForCodeRefs.md は /docs/CodeRefs 以下に置かれたファイルで使用するためのもの。
# HeadingIDsForTops.md は /docs に置かれたファイルで使用するためのもの。

#$myArray = @()
#Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';$myArray += "[$LinkName]: ../../$RelativePath#$Anchor" }
#$myOut = $myArray -join "`n"
#[System.IO.File]::WriteAllLines("${PSScriptRoot}\..\tmp\HeadingIDsForCodeRefs.md", $myOut)

#Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';Write-Output "[$LinkName]: ../../$RelativePath#$Anchor`n" } | Out-File ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding utf8 -NoNewline
#Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';Write-Output "[$LinkName]: CodeRefs/$RelativePath#$Anchor`n" } | Out-File ..\..\src\tmp\HeadingIDsForTops.md -Encoding utf8 -NoNewline

$myTargets = @{"HeadingIDsForCodeRefs.md" = "../..";"HeadingIDsForTops.md" = "CodeRefs"}

$myArray = @()
Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$RelativePath=$_.RelativePath($PWD) -replace '\\','/';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$myArray += @{"LinkName"=$LinkName; "RelativePath"=$RelativePath; "Anchor"=$Anchor} }

foreach($myTarget in $myTargets.GetEnumerator()){
	$myOutputFilename=$myTarget.Key
	$myAnchorPath=$myTarget.Value
	$myOut = ""
	foreach($myLine in $myArray){
		$LinkName=$myLine['LinkName']
		$RelativePath=$myLine['RelativePath']
		$Anchor=$myLine['Anchor']
		$myOut += "[$LinkName]: $myAnchorPath/$RelativePath#$Anchor`n"
	}
	$myOutputFullName = "$PSScriptRoot\..\tmp\$myOutputFilename"
	[System.IO.File]::WriteAllText($myOutputFullName, $myOut)
}

Pop-Location
