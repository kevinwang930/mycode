// overloading functions
#include <iostream>
using namespace std;

int operate (int a, int b)
{
  return (a*b);
}

double operate (double a, double b)
{
  return (a/b);
}

template <class SomeType>
SomeType sum (SomeType a, SomeType b)
{
  return a+b;
}

template <class T>
T fixed_multiply (T val,int N)
{
  return val * N;
}

int main ()
{
  int x=5,y=2;
  double n=5.0,m=2.0;
  cout << operate (x,y) << '\n';
  cout << operate (n,m) << '\n';

  cout<<sum<int>(10,20)<<endl;
  std::cout << fixed_multiply<int>(10,2) << '\n';
  std::cout << fixed_multiply<double>(10.5,3) << '\n';
  return 0;
}