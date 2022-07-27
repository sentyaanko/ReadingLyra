Push-Location "$PSScriptRoot"
.\CreateHeadingIDsToExternal.ps1
.\UpdateMdHeadingIDs.ps1
.\UpdateIndexMd.ps1
.\UpdateNavisYml.ps1
Pop-Location
