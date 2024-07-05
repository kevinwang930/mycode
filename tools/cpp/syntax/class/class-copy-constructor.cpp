// copy constructor: deep copy
#include <iostream>
#include <string>
using namespace std;

class Example5 {
    
  public:
    string *ptr;
    Example5 (const string& str) : ptr(new string(str)) {}
    ~Example5 () {delete ptr;}
    // copy constructor:
    // Example5 (const Example5& x) : ptr(x.ptr) {}
    // access content:
    string& content() const {return *ptr;}

    // copy assignment
    Example5& operator= (const Example5& x)  = default;
    // {
    //     delete ptr;                      // delete currently pointed string
    //     ptr = new string (x.content());  // allocate space for new string, and copy
    //     return *this;
    // }

    Example5  (Example5 & x) = default;

    Example5 &operator=(Example5 &&x)
    {
      delete ptr;
      ptr = x.ptr;
      x.ptr = nullptr;
      return *this;
    }
};

int main () {
  Example5 foo ("Example");
  Example5 bar  {foo};    //copy constructor
  cout <<"foo bar string address\t" << foo.ptr << "\t" << bar.ptr << endl;
  foo.ptr =new string("content changed");
  cout << "foo's content: " << foo.content() << '\n';
  cout << "bar's content: " << bar.content() << '\n';
  foo = bar;        // copy assignment
  cout << "After copy assignment" << endl;
  cout << "foo bar string address\t" << foo.ptr << "\t" << bar.ptr << endl;
  foo.ptr = new string("content changed");
  cout << "foo's content: " << foo.content() << '\n';
  cout << "bar's content: " << bar.content() << '\n';

  foo = std::move(bar); // move assignment
  cout << "After move assignment" << endl;
  cout << "foo bar string address\t" << foo.ptr << "\t" << bar.ptr << endl;
 
  cout << "foo's content: " << foo.content() << '\n';
  cout << "bar's content: " << bar.content() << '\n';
}