Clear-Host
$workspace = $args[0]
$dir = $args[1]
$file = $args[2]
$fileName = $args[3]
Set-Location $workspace
Write-Host "PS "$workspace">  " -NoNewline
Write-Host "clang" $fileName "-o" "a.exe" -ForegroundColor Green
clang $file -o $dir\a.exe
. $dir\a.exe

