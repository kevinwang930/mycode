$targetPath = "D:\chocoProgram"
$targetVariable = "ChocolateyBinRoot"
[Environment]::SetEnvironmentVariable($targetVariable, $targetPath, 'User')