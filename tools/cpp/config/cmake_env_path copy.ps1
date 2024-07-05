$newPath = "C:\Program Files\CMake\bin"
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Where-Object { $_ -notlike "*CMake*" } 

$userPath = $userPath | Where-Object { -not [string]::IsNullOrEmpty($_) }    
$userPath+=$newPath   
$userPath = $userPath -join ';'  #add element in front
write-host $userPath
[Environment]::SetEnvironmentVariable("Path", $userPath, 'User')
