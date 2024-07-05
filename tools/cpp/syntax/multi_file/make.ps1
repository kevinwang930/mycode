# clang base.cc -c -o base.obj
# clang main.cc -c -o main.obj
. "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
clang-cl -c base.cc main.cc base.h
lld-link base.obj main.obj
# clang base.cc main.cc base.h