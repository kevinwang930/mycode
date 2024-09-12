// arrays example
#include <iostream>
using namespace std;


void changeArray (int arg[], int length) {
  arg[0] =1;
}

int main ()
{
  int firstarray[] = {5, 10, 15};
  changeArray (firstarray,3);
  cout << firstarray[0] << endl;
  cout << "last array element " << firstarray[2] << endl;

  // multi-dimension array
  int marray[3][3] = { {0},{1},{2}};
  cout << "first " <<marray[2][0] << " second " << marray[2][1]<< endl;

  return 0;
}