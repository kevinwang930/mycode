$msvc_x64_lib = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.28.29333\lib\x64"
$win10_sdk_lib = "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\um\x64"
$libPath = $msvc_x64_lib,$win10_sdk_lib
$libPath = $libPath -join ";"
write-host $libPath
[Environment]::SetEnvironmentVariable("LIB", $libPath, 'User')