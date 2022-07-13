# ps1 の実行の際は事前に以下のようなコマンドで、 ps1ファイルのブロック解除と powershell の実行ポリシーを変更しておく必要があります。
# Unblock-File UpdateMdHeadingIDs.ps1
# Set-ExecutionPolicy RemoteSigned -Scope Process

# .md ファイルの HeadingID の更新処理
# @param $HeadingIDsFullName 利用する HeadingIDs のファイル名
# @param $Keyword 書き換えを行う目印
# @param $Path Get-ChildItem 用
# @param $Include Get-ChildItem 用
# @param $Recurse Get-ChildItem 用
# @param $Exclude Get-ChildItem 用
function Set-SaMdHeadingIDs{
	param(
		$HeadingIDsFullName,
		$Keyword,
		[string[]]$Path,
		[string[]]$Include,
		[string[]]$Exclude,
		[switch]$Recurse
	)
	# HeadingID の内容を取得しておく
	$HeadingIDs = [System.IO.File]::ReadAllText($HeadingIDsFullName)

	# Keyword 以降を $HeadingIDs の内容で上書き
	Get-ChildItem -Path:$Path -Include:$Include -Exclude:$Exclude -Recurse:$Recurse | ForEach-Object {$OriginalContent=((Get-Content $_.FullName -Encoding UTF8) -join "`n")+"`n";$KeywordIndex=$OriginalContent.IndexOf($Keyword);if($KeywordIndex -ge 0){$OutputContent=$OriginalContent.Substring(0,$KeywordIndex+$Keyword.Length+1)+$HeadingIDs;[System.IO.File]::WriteAllText($_.FullName,$OutputContent)}}
}

# .md ファイルの HeadingID の更新処理
function Set-SaAllMdHeadingIDs{
	# /docs/CodeRefs 以下の .md ファイルの HeadingID の更新処理
	Set-SaMdHeadingIDs -Path:"$PSScriptRoot\..\..\docs\CodeRefs\*" -Include:*.md -Recurse -HeadingIDsFullName:"$PSScriptRoot\..\tmp\HeadingIDsForCodeRefs.md" -Keyword:'<!--- CodeRefs --->'
	
	# /docs の .md ファイルの HeadingID の更新処理
	Set-SaMdHeadingIDs -Path:"$PSScriptRoot\..\..\docs\*" -Include:*.md -Exclude:index.md -HeadingIDsFullName:"$PSScriptRoot\..\tmp\HeadingIDsForRoot.md" -Keyword:'<!--- CodeRefs --->'
}

Set-SaAllMdHeadingIDs
