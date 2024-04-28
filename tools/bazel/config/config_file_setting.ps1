$fileDir = $env:ProgramData
If (!(test-path $fileDir)) {
    New-Item -ItemType Directory -Force -Path $fileDir
}

$filePath = Join-Path -Path $PSScriptRoot -ChildPath "bazel.bazelrc"
$desitinationPath = Join-Path -Path $fileDir -ChildPath "bazel.bazelrc"
Copy-Item -Path $filePath -Destination $desitinationPath
