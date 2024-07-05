#include<iostream>
using namespace std;

void arg_reference_test(int& a) {  // pass by reference
    a+=1;
    cout <<a << endl;
}

void arg_value_test(int a)
{
    a += 1;
    cout << a << endl;
}

void arg_pointer_test(int *a)  // pass address similar with pass by reference
{
    *a += 1;
    cout << *a << endl;
}

int main() {

    int a = int{};
    
    arg_reference_test(a);
    cout << a << std::endl;
    a = 0;
    arg_value_test(a);
    cout << a << std::endl;
    a = 0;
    arg_pointer_test(&a);
    cout << a << std::endl;
}