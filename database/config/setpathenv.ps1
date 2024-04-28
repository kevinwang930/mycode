
$addPath = "D:\Program Files\MariaDB 10.5\bin"
$arrPath = [Environment]::GetEnvironmentVariable('Path', 'User') -split ';'| Where-Object { $_ -notlike    "*MariaDB*" } 

$arrPath = $arrPath | Where-Object {-not [string]::IsNullOrEmpty($_)}


$newPath = ($arrPath + $addPath) -join ';'
# $env:Path = $arrPath
# $env:Path = $arrPath -join ';'
[Environment]::SetEnvironmentVariable("Path", $newPath, 'User')