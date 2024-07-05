// move constructor/assignment
#include <iostream>
#include <string>
using namespace std;

class Example6 {
    string* ptr;
  public:
    Example6 (const string& str) : ptr(new string(str)) {}
    ~Example6 () {delete ptr;}
    // move constructor
    Example6 (Example6&& x) : ptr(x.ptr) {}
    // move assignment
    Example6& operator= (Example6&& x) {
      delete ptr; 
      ptr = x.ptr;
      x.ptr=nullptr;
      return *this;
    }
    // access content:
    const string& content() const {return *ptr;}
    // addition:
    Example6 operator+(const Example6& rhs) {

      return Example6(content()+rhs.content());
    }
    void setFirstChar(char c) {
      ((char*)ptr)[0] =c;
    } 
};


int main () {
  Example6 foo ("first");
  cout << "foo's content: " << foo.content() << '\n';
  
  Example6 baz = std::move(foo);  //move assignment
  baz.setFirstChar('e');
  cout << "foo's content: " << foo.content() << '\n';
  cout << "baz's content: " << baz.content() << '\n';
  
  return 0;
}