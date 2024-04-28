// constructor on const object
#include <iostream>
using namespace std;

class MyClass {
  public:
    int x;
    MyClass(int val) : x(val) {}
    int& get() {return x;}
    const int& get() const {return x;}
};

void print (const MyClass& arg) {
  cout << arg.get() << '\n';
}

int main() {
    int* p;
  MyClass foo(10);
  foo.get() =20;
  p = &(foo.get());
// foo.x = 20;            // not valid: x cannot be modified
  cout << foo.x << '\n';  // ok: data member x can be read
  cout <<*p<<endl;
//   cout <<foo.get()<<endl;

print(foo);
  return 0;
}