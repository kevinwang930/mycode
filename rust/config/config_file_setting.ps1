$fileDir = Join-Path -Path $HOME -ChildPath ".cargo"
$fileDir
If (!(test-path $fileDir)) {
    New-Item -ItemType Directory -Force -Path $fileDir
}

$filePath = Join-Path -Path $PSScriptRoot -ChildPath "config"
$desitinationPath = Join-Path -Path $fileDir -ChildPath "config"
Copy-Item -Path $filePath -Destination $desitinationPath

# function copyFile {
#     # Parameter help description
#     param ($filePath,$desitinationPath)
    
# }