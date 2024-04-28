// pointers to base class
#include <iostream>
using namespace std;

class Polygon {
  protected:
    int width, height;
  public:
    void set_values (int a, int b)
      { width=a; height=b; }
    
    int area() 
    {
        return 0;
    };

    void printarea()
      { cout <<"area output"<< this->area() << '\n'; }
};

class Rectangle: public Polygon {
  public:
    Rectangle() {}
    Rectangle(int a,int b)
    {
      width = a;
      height =b;
    }

    int area()
      { return width*height; }
};

class Triangle: public Polygon {
  public:
    int area()
      { return width*height/2; }
};

int main () {
  Rectangle rect{4,5};
  Triangle trgl;
  Polygon poly;
  Polygon * ppoly1 {&rect};
  Polygon * ppoly2 = &trgl;
//   ppoly1->set_values (4,5);
  ppoly2->set_values (4,5);
  poly.set_values(1,2);
  cout << rect.area() << '\n';
  cout << trgl.area() << '\n';
  cout <<ppoly1->area()<<endl;
  cout << rect.area()<<endl;
  rect.printarea();
  return 0;
}