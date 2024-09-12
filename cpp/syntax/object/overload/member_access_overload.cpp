#include<iostream>
using namespace std;

struct client
{
    int a;
};

struct proxy
{
    client *target;
    client *operator->() const
    {
        return target;
    }
};

struct proxy2
{
    proxy *target;
    proxy &operator->() const
    {
        return *target;
    }
};

int main()
{
    client x = {3};
    proxy y = {&x};
    proxy2 z = {&y};

    std::cout << x.a <<endl<< y->a <<endl<< z->a; // print "333"
}