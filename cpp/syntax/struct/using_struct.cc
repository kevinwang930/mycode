#include<iostream>

struct base {
    int a;
    int b;
    int c;
};

int main() {
    base b;
    using signature = unsigned int(int a,int b,int c);
    signature *p = reinterpret_cast<signature *>(&b);
    p->a = 1;
    
}