// using
#include <iostream>
#include "namespace1.h"
#include "namespace2.h"
using namespace std;
namespace test {
  int z = x;
}


int main () {

    
  cout << test::x << '\n';
  cout << test::y << '\n';
  cout << ::test::z << '\n';
  return 0;
}