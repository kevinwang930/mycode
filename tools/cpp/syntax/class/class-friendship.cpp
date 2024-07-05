// friend functions
#include <iostream>
using namespace std;

class Square;
class Rectangle {
    int width, height;
  public:
    Rectangle() {}
    Rectangle (int x, int y) : width(x), height(y) {}
    Rectangle(const Rectangle& x)   // copy constructor
    {
        width = x.width;
        height = x.height;
    }

    

    int area() {return width * height;}

    void operator= (Rectangle& x)  //copy assignment
    {
        width = x.width;
        height = x.height;
    }

    void operator= (Rectangle&& x)  //move assignment
    {
        width = x.width ;
        height = x.height;
    }
    friend Rectangle duplicate (const Rectangle&);

    void convert(Square& a);
    
};

class Square {
  friend class Rectangle;
  private:
    int side;
  public:
    Square (int a) : side(a) {}
};

Rectangle duplicate (const Rectangle& param)
{
  Rectangle res;
  res.width = param.width;
  res.height = param.height;
  return res;
}

void Rectangle::convert(Square& a)
{
      width = a.side;
      height = a.side;
    }

int main () {
  Rectangle bar (2,3);
  Rectangle foo;
  foo =  Rectangle(2,3);
  cout << &foo <<endl;
  foo = bar;
  foo = duplicate (bar);
  cout << &foo <<endl;
  cout << foo.area() << '\n';

  Square a {4};
  Rectangle rect;
  rect.convert(a);
  cout <<rect.area();
  return 0;
}