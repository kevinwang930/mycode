#include <iostream>
struct Base
{
    virtual void v()
    {
        std::cout << "base\n";
    }
    void nv() {
        std::cout << "base\n";
    }
};
struct Derived : Base
{
    void v() override
    { // 'override' is optional
        std::cout << "derived\n";
    }
    void nv()
    {
        std::cout << "derived\n";
    }
};
int main()
{
    Base b;
    Derived d;


    // virtual function call through reference
    Base &dr = d; // the type of dr is Base& as well
    dr.v();       // prints "derived"
    dr.nv();

    // virtual function call through pointer
    Base *dp = &d; // the type of dp is Base* as well
    dp->v();       // prints "derived"
    dp->nv();

    // non-virtual function call
    dr.Base::v(); // prints "base"
}