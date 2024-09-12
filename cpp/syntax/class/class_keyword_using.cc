#include <iostream>
struct B
{
    virtual void virtualf(int) { std::cout << "B::f\n"; }
    void g(char c) { std::cout << "B::g " <<c<<std::endl; }
    void h(int) { std::cout << "B::h\n"; }

protected:
    int m; // B::m is protected
    typedef int value_type;
};

struct D : public B
{
    using B::m;          // D::m  make a protected member public
    // using B::value_type; // D::value_type is public

    // using B::f;
    void virtualf(int) { std::cout << "D::f\n"; } // D::f(int) overrides B::f(int)
    using B::g;
    void  g(int a) { std::cout << "D::g " << a <<std::endl; } // both g(int) and g(char) are visible
                                           // as members of D
    // using B::h;
    void h(int) { std::cout << "D::h\n"; } // D::h(int) hides B::h(int)
};

int main()
{
    D d;
    B &b = d;

    //    b.m = 2; // error, B::m is protected
    d.m = 1;  // protected B::m is accessible as public D::m
    b.virtualf(1);   // calls derived f()
    d.virtualf(1);   // calls derived f()
    d.g(1);   // calls derived g(int)
    char c = 'a';
    d.g(c); // calls base g(char)
    b.h(1);   // calls base h()
    d.h(1);   // calls derived h()
}