$a = "kevin;wang;hello"
$b = $a -split ";"
write-host $b.GetType()
$b = $b + 'welcome'
$c = $b -join ";"
write-host $c.GetType()
Write-Host $c

$depotToolPath = "D:\tools\depot_tools"
$systemPath = [Environment]::GetEnvironmentVariable('Path', 'Machine') -split ';' | Where-Object { $_ -notlike "*depot_tools*" } 

$systemPath = $systemPath | Where-Object { -not [string]::IsNullOrEmpty($_) }
$newPath = [System.Collections.Generic.List[string]]$systemPath
$newPath.Add($depotToolPath)
$newPath = $newPath -join ';'
Write-Host($newPath)

