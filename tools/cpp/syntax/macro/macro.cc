#include<iostream>


namespace base {
    int test = 10;
}

using namespace std;
#define F(a,b) a##b
#define F1(a,b) int a##_b = 1

#define P(a,b) a, a##End = 1,  // token parsing
#define BASE(a) base::a
#define M(a) #a    // stringizing
#define C(a)  #@a // charizing

struct s {
    int a,b;
};

int main()  {
    F1(test,test);
    cout << "a##b macro " << F(1,2) << endl;
    cout << "a##_b macro " << test_b << endl;
    cout << "::macro test  " << BASE(test) << endl;
    cout << "stringizing macro test " << M(a##a) << endl;
    cout << "Charizing macro test " << C(x) << endl;
}