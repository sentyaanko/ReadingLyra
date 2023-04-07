# markdown の heading から anchor を取得する(同名の連番非対応)
function Get-SaAnchor{
	param([string]$Heading)
	# ($Heading -replace '[:\(\)]','').ToLower()
	# ((($Heading -replace '[<>,\.:\(\)]','') -replace ' ','-') -replace '-{2}','-').ToLower()
	#(($Heading -replace '[<>,\.:\(\)]','') -replace ' ','-').ToLower()
	$ret=(($Heading -replace '[^a-zA-Z0-9 ]','') -replace ' ','-').ToLower()
	if($ret){$ret}else{"section"}
}
