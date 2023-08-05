# markdown の heading から anchor を取得する(同名の連番非対応)
function Get-SaAnchor{
	param([string]$Heading)
	# ($Heading -replace '[:\(\)]','').ToLower()
	# ((($Heading -replace '[<>,\.:\(\)]','') -replace ' ','-') -replace '-{2}','-').ToLower()
	#(($Heading -replace '[<>,\.:\(\)]','') -replace ' ','-').ToLower()
	# for github page
	$ret=(($Heading -replace '[^a-zA-Z0-9 ]','') -replace ' ','-').ToLower()
	if($ret){$ret}else{"section"}
	# for github by vscode all in one markdown
	## https://github.com/yzhang-gh/vscode-markdown/blob/master/src/util/slugify.ts#L15
	## /[^\p{L}\p{M}\p{Nd}\p{Nl}\p{Pc}\- ]/gu
	#$ret=(($Heading -replace '[^\p{L}\p{M}\p{Nd}\p{Nl}\p{Pc}\- ]','').ToLower() -replace ' ','-')
	#if($ret){$ret}else{"section"}
}
