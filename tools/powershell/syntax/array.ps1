$depotToolPath = "D:\tools\depot_tools"
$systemPath = [Environment]::GetEnvironmentVariable('Path', 'Machine') -split ';' | Where-Object { $_ -notlike "*depot_tools*" } 

$systemPath = $systemPath | Where-Object { -not [string]::IsNullOrEmpty($_) }

# add element in front
$newPath = (,$depotToolPath + $systemPath) -join ';'
write-host $newPath