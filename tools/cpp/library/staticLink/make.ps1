if (-not (Test-Path result)) {

    mkdir result
}else {
    remove-item ./result/*
}
Set-Location result
clang  -o test_dll.obj -c ../test_dll.c
llvm-ar qc test_dll.lib test_dll.obj
clang ../main.c  test_dll.lib -o  testProg.exe
./testProg