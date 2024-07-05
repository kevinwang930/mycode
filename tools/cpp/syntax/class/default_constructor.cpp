#include <iostream>

using namespace std;
class A
{
public:
    int x;
    A() {}
};

class B
{
public:
    int x;
    B() = default;
};

int main()
{
    int x = 5;
    new (&x) A(); // Call for empty constructor, which does nothing
    cout << x << endl;
    new (&x) B; // Call for default constructor
    cout << x << endl;
    new (&x) B(); // Call for default constructor + Value initialization
    cout << x << endl;
    return 0;
}