#include<iostream>
using namespace std;
int main() {
    int a = 0;
    {
        int a = 1;
        cout << a << endl;
    }
    cout << a << endl;
}