// class templates
// template < parameter-list >
#include <iostream>
using namespace std;

template <class T,class U>
class container {
    T a;
    U b;
  public:
    container (T first, U second)
      {a=first; b=second;}
    T getmax ();
};

template <class T,class U>
T container<T,U>::getmax ()
{
  T retval;
  retval = a>b? a : b;
  return retval;
}

template class container<int,int>;

// class template:
template <class T>
class mycontainer {
    T element;
  public:
    mycontainer (T arg) {element=arg;}
    T increase () {return ++element;}
};



// class template specialization:
template <>
class mycontainer <char> {
    char element;
  public:
    mycontainer (char arg) {element=arg;}
    char uppercase ()
    {
      if ((element>='a')&&(element<='z'))
      element+='A'-'a';
      return element;
    }
};

int main () {
  container <int,int> myobject (100, 75);
  cout << myobject.getmax()<<endl;
  mycontainer<int> myint (7);
  mycontainer<char> mychar ('j');
  cout << myint.increase() << endl;
  cout << mychar.uppercase() << endl;
  return 0;
}