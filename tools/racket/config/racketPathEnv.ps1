$addPath = "D:\Program Files\Racket"
$arrPath = [Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Where-Object { $_ -notlike "*racket*" } 

$arrPath = $arrPath | Where-Object { -not [string]::IsNullOrEmpty($_) }


$newPath = ($arrPath + $addPath) -join ';'
# $env:Path = $arrPath
# $env:Path = $arrPath -join ';'
[Environment]::SetEnvironmentVariable("Path", $newPath, 'User')