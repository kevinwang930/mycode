#include<iostream>

using namespace std;

class base
{
public:
    base ():a(10) {}
    int a;
    void print() {cout << "print: base" << endl;}
};

class other
{
public:
    int b;
    int c;
    int a;
    
    void print() { cout << "print: other" << endl; }
};

int main()
{
    int *a = new int(5);
    void *b = static_cast<void *>(a);
    int *c = static_cast<int *>(b);
    cout << "static case\n"
            << a << endl
            << b << endl
            << c << endl;

    void *rb = reinterpret_cast<void *>(a);
    int *rc = reinterpret_cast<int *>(rb);
    cout << "reinterpret case\n"
            << a << endl
            << rb << endl
            << rc << endl;

    base * cptr1 = new base {};
    cptr1->print();
    other * cptr2 = reinterpret_cast<other*>(cptr1);
    cptr2->print();
    cptr2->b = 50;
    cout << "cast to other check value b "
         << " " <<cptr2->b << endl;
    base * cptr3 = reinterpret_cast<base*>(cptr2);
    cout << "cast back to base check value of a " <<cptr3->a << endl;
    cptr3->a = 10;
    other *cptr4 = reinterpret_cast<other *>(cptr3);
    cout << "cast to other again check if value of b exist " << cptr4->b << endl;
}
