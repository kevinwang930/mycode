// my first pointer
#include <iostream>
using namespace std;

void increment_all (int* start, int* stop)
{
  int * current = start;
  while (current != stop) {
    ++(*current);  // increment value pointed
    ++current;     // increment pointer
  }
}

void referenceCall(int & a) {
  a = 100;
}

void print_all (const int* start, const int* stop)
{
  const int * current = start;
  while (current != stop) {
    cout << *current << '\n';
    ++current;     // increment pointer
  }
}

int addition (int a, int b)
{ return (a+b); }

int subtraction (int a, int b)
{ return (a-b); }

int operation (int x, int y, int (*functocall)(int,int))
{
  int g;
  g = (*functocall)(x,y);
  return (g);
}

int main ()
{
  int * p1, *p2;
  int a ;

  p1 = p2;
  p2 = &a;
  int& b(*p2);
  *p2 = 10;
  cout << "p1 p2 pointer value "<< p1 << "\t"<< p2 << endl;
  cout << b << endl;
  referenceCall(a);
  cout << a << endl;
  return 0;
}