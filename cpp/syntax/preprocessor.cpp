// function macro
#include <iostream>
using namespace std;

#define getmax(a,b) ((a)>(b)?(a):(b))
#define str(x) #x
#define glue(a,b) a ## b



int main()
{
  int x=5, y;
  y= getmax(x,2);
  cout << y << endl;
  cout << getmax(7,x) << endl;

  cout << str(test) << endl;
  glue(c,out) << "test";
  return 0;
}