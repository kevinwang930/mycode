$compilerPath = "D:\Program Files\LLVM\bin"
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Where-Object { $_ -notlike "*LLVM*" } 

$userPath = $userPath | Where-Object { -not [string]::IsNullOrEmpty($_) }    
$userPath+=$compilerPath   
$newPath = $userPath -join ';'  #add element in front
write-host $newPath
[Environment]::SetEnvironmentVariable("Path", $newPath, 'User')
