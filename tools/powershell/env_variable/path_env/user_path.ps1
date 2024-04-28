$addPath = "E:\git\google-v8\v8\out\x64_msvc"
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User') -split ';' | Where-Object { $_ -notlike "*v8*" } 

$userPath = $userPath | Where-Object { -not [string]::IsNullOrEmpty($_) } 
if ($userPath -is [System.String]) {
    $userPath = $userPath,$addPath
} else {
    $userPath += $addPath
}
      
$newPath = $userPath -join ';'  #add element at last
write-host $newPath
[Environment]::SetEnvironmentVariable("Path", $newPath, 'User')
