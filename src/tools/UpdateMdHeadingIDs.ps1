# ps1 の実行の際は事前に以下のようなコマンドで、 ps1ファイルのブロック解除と powershell の実行ポリシーを変更しておく必要があります。
# Unblock-File UpdateMdHeadingIDs.ps1
# Set-ExecutionPolicy RemoteSigned -Scope Process

$tempPath = $PSScriptRoot + '\..\..\docs\CodeRefs'
Push-Location $tempPath

# /docs/CodeRefs 以下の .md ファイルの HeadingID の更新処理(2 steps)

# step1: md ファイルから <!--- CodeRefs ---> という文字列を探し、それより前の行までを .md.tmp ファイルに出力する
# $myHeadingIDs=Get-Content ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding UTF8;Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile=$myMdFilename + '.tmp';Set-Content $myTmpFile $myContent,$myHeadingIDs -Encoding UTF8} 

# step2: step1 で出力した .md.tmp ファイルを .md ファイルに上書きする(実際は .md ファイルを削除後にリネームしている)
# Get-ChildItem -Recurse -include *.md.tmp | ForEach-Object{ $myDstFilename=$_.FullName.TrimEnd('.tmp');Remove-Item $myDstFilename;$_.MoveTo($myDstFilename) }

Get-ChildItem -Recurse -include *.md | $myMd=Get-Content; Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->'


Pop-Location
