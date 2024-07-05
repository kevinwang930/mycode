#include<iostream>
using namespace std;


int main() {
    int base = 3;
    auto a = [=](int a,int b) {
        return a+b+base;
    };
    cout << a(1,2) << endl;
}