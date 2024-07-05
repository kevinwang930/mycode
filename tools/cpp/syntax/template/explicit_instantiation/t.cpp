//t.cpp
#include "t.h"
template <class T>
void fun(T n)
{
    cout << "T " << n << endl;
}
template void fun<int>(int);
//end t.cpp