#include <iostream>
using namespace std;

int & referenceTest(int & a) {
    ++a;
    return a;
}

int main()
{
    int a{0};
    int & b = referenceTest(a);

    cout << a << endl;
    ++b;
    cout << a << endl;
}