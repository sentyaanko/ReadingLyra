# ps1 の実行の際は事前に以下のようなコマンドで、 ps1ファイルのブロック解除と powershell の実行ポリシーを変更しておく必要があります。
# Unblock-File UpdateMdHeadingIDs.ps1
# Set-ExecutionPolicy RemoteSigned -Scope Process

$tempPath = $PSScriptRoot + '\..\..\docs\CodeRefs'
Push-Location $tempPath

# 改行コードを LF に
#Get-ChildItem -Recurse -include *.md | ForEach-Object {$myMd=((Get-Content $_.FullName -Encoding UTF8) -join "`n")+"`n";[System.IO.File]::WriteAllText($_.FullName,$myMd)}


# /docs/CodeRefs 以下の .md ファイルの HeadingID の更新処理(2 steps)

# HeadingID の内容を取得しておく
##$myHeadingIDs=Get-Content ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding UTF8
$myHeadingIDsFilename = "HeadingIDsForCodeRefs.md"
$myHeadingIDsFullName = "$PSScriptRoot\..\tmp\$myHeadingIDsFilename"
$myHeadingIDs = [System.IO.File]::ReadAllText($myHeadingIDsFullName)

# step1: md ファイルから <!--- CodeRefs ---> という文字列を探し、それより前の行までを .md.tmp ファイルに出力する
# $myHeadingIDs=Get-Content ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding UTF8;Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile=$myMdFilename + '.tmp';Set-Content $myTmpFile $myContent,$myHeadingIDs -Encoding UTF8} 

# step2: step1 で出力した .md.tmp ファイルを .md ファイルに上書きする(実際は .md ファイルを削除後にリネームしている)
# Get-ChildItem -Recurse -include *.md.tmp | ForEach-Object{ $myDstFilename=$_.FullName.TrimEnd('.tmp');Remove-Item $myDstFilename;$_.MoveTo($myDstFilename) }

#Get-ChildItem -Recurse -include *.md | $myMd=Get-Content; Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->'
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName;$mySelect=Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->';ForEach-Object{$myEndLine=$_.LineNumber-1;$myContent=$myMd[0..$myEndLine];} -InputObject $mySelect}
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName;$mySelect=Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->';if($mySelect){Get-Member -InputObject $mySelect}}
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName;$mySelect=Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->';if($mySelect){$mySelect.Matches[-1].Index}}
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName;$mySelect=Select-String -InputObject $myMd -Pattern '<!--- CodeRefs --->';if($mySelect){Get-Member -InputObject $mySelect.Matches[-1]}}
#Get-ChildItem -Recurse -include *.md | ForEach-Object{$myMdName=$_.FullName;$myMd=Get-Content $myMdName -;$mySelect=Select-String -InputObject $myMd. -Pattern '<!--- CodeRefs --->';if($mySelect){$mySelect.LineNumber}}
##Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile="${PWD}\${myMdFilename}.tmp";$myAllContent= $myContent,$myHeadingIDs;[System.IO.File]::WriteAllText($myTmpFile, $myAllContent);Get-Member -InputObject $myAllContent;Get-Member -InputObject $myContent;Get-Member -InputObject $myHeadingIDs}
#$myHeadingIDs=Get-Content ..\..\src\tmp\HeadingIDsForCodeRefs.md -Encoding UTF8;Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile=$myMdFilename + '.tmp';$myAllContent= $myContent,$myHeadingIDs;$PWD;$myTmpFile}

#Get-ChildItem -Recurse -include *.md | Select-String '<!--- CodeRefs --->' | ForEach-Object {$myEndLine=$_.LineNumber-1;$myMdFilename=$_.RelativePath($PWD);$myContent=(Get-Content $myMdFilename -Encoding UTF8)[0..$myEndLine];$myTmpFile="${PWD}\${myMdFilename}.tmp";$myAllContent= $myContent,$myHeadingIDs;[System.IO.File]::WriteAllText($myTmpFile, $myAllContent);Get-Member -InputObject $myAllContent;Get-Member -InputObject $myContent;Get-Member -InputObject $myHeadingIDs}
#Get-ChildItem -Recurse -include *.md.tmp2 | ForEach-Object {$myMd=Get-Content $_.FullName; }

$myKeyword='<!--- CodeRefs --->'
Get-ChildItem -Recurse -include *.md | ForEach-Object {$myMd=((Get-Content $_.FullName -Encoding UTF8) -join "`n")+"`n";$myIndex=$myMd.IndexOf($myKeyword);if($myIndex -ge 0){$myOut=$myMd.Substring(0,$myIndex+$myKeyword.Length+1)+$myHeadingIDs;[System.IO.File]::WriteAllText($_.FullName,$myOut)}}




Pop-Location
