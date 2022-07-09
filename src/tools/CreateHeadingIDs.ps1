# ps1 の実行の際は事前に以下のようなコマンドで、 ps1ファイルのブロック解除と powershell の実行ポリシーを変更しておく必要があります。
# Unblock-File CreateHeadingIDs.ps1
# Set-ExecutionPolicy RemoteSigned -Scope Process

$tempPath = $PSScriptRoot + '\..\..\docs\CodeRefs'
Push-Location $tempPath

# /docs/CodeRefs 以下の md ファイルから見出しを取得し、 HeadingID をファイルに出力する。
# HeadingIDsForCodeRefs.md は /docs/CodeRefs 以下に置かれたファイルで使用するためのもの。
# HeadingIDsForTops.md は /docs に置かれたファイルで使用するためのもの。
Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';Write-Output "[$LinkName]: ../../$RelativePath#$Anchor" } | Out-File ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding utf8
Get-ChildItem -Recurse -include *.md | Select-String '^#' | ForEach-Object {$LinkName=$_.Line -replace '^#+\s','';$Anchor=($LinkName -replace '[:\(\)]','').ToLower();$RelativePath=$_.RelativePath($PWD) -replace '\\','/';Write-Output "[$LinkName]: CodeRefs/$RelativePath#$Anchor" } | Out-File ..\..\src\tmp\HeadingIDsForTops.md -Encoding utf8

Pop-Location
