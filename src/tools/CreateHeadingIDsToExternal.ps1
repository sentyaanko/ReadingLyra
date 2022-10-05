# /docs 以下の md ファイルから外部リンクの見出しを取得し、 HeadingID を HeadingIDsToExternal.md ファイルに出力する。
function Set-SaAllExternalHeadingIDs{
	$dic =@{}
	Get-ChildItem -Recurse -Include *.md -Exclude index.md | Select-String -Pattern '^\[([^\]]{2,})\]: +(http.+)$' | ForEach-Object{$heading=$_.Matches.Groups[1].Value;$url=$_.Matches.Groups[2].Value;$dic[$heading]=$url}
	$sortedEnumerator=$dic.GetEnumerator() | Sort-Object -Property key
	$output =""
	foreach($it in $sortedEnumerator){
		$key=$it.key
		$Value=$it.Value
		$output+="[$key]: $Value`n"
	}
	[System.IO.File]::WriteAllText("$PSScriptRoot\..\tmp\HeadingIDsToExternal.md", $output)
}

Push-Location "$PSScriptRoot\..\..\docs"
Set-SaAllExternalHeadingIDs
Pop-Location
