$fileDir = Join-Path -Path $env:USERPROFILE -ChildPath "Documents\PowerShell"
$fileDir
If (!(test-path $fileDir)) {
    New-Item -ItemType Directory -Force -Path $fileDir
}

$filePath = Join-Path -Path $PSScriptRoot -ChildPath "profile.ps1"
$desitinationPath = Join-Path -Path $fileDir -ChildPath "profile.ps1"
Copy-Item -Path $filePath -Destination $desitinationPath
