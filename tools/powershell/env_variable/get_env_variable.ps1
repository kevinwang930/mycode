$systemPath = [Environment]::GetEnvironmentVariable('Path', 'Machine') -split ';' | Where-Object { $_ -notlike "*depot_tools*" } 
Write-Host $systemPath