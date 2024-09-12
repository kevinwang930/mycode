#include<iostream>
using namespace std;
template <typename T>
struct B
{

    int var;
};

template <typename T>
struct D : B<T>
{
    D()
    {
        // var = 1;    // error: 'var' was not declared in this scope
        this->var = 1; // ok
    }
};

int main() {

    D<int> s;
    cout << s.var << endl;
}