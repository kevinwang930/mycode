#include <iostream>
using namespace std;
int num = 7;
int main()
{
    int num = 3;
    cout << "Value of local variable num is: " << num;
    cout << "\nValue of global variable num is: " << ::num<<endl;  //global namespace
    ::std::cout<<"namespace is special object"<<endl;
    return 0;
}