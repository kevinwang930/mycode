#include<iostream>
using namespace std;
template <typename T, size_t N>
    char (&ArraySizeHelper(T (&array)[N]))[N];
int main() {
    int * p[3];
    int * p1;
    cout << "3 array pointer size " << sizeof(p) << endl;
    cout << "Single array pointer size " << sizeof(p1) << endl;
    cout << sizeof(ArraySizeHelper(p)) << endl;
    cout << "single pointer value " << p1 << endl;
    cout << "single pointer & value " << (&p1) << endl;
    cout << "array pointer value " << p << endl;
    cout << "array pointer & value " << (&p) << endl;

}