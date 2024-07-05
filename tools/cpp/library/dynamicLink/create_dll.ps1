if (-not (Test-Path result)) {

    mkdir result
}else {
    remove-item ./result/* 
}
Set-Location result
clang   -shared  -o message.dll ../message.c
$lib_file = "message.lib"
clang  ../main.c  -l"$lib_file" -o  testProg.exe
./testProg
