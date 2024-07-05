// derived classes
#include <iostream>
using namespace std;

class Polygon {

  public:
  Polygon(int a, int b) : width(a), height(b) {}

protected:
  int width, height;

private:
  void set_values(int a, int b)
  {
    width = a;
    height = b;}
    friend class Rectangle;
 };

class Rectangle: public Polygon {
  public:
    Rectangle(int a, int b) : Polygon(a, b) {}
    int area ()
      { return width * height; }
    void public_set_values(int a, int b) {
      set_values(a,b);
    }
  private:
    
    friend class Rectangle;
 };

class Triangle: public Polygon {
  public:
    int area ()
      { return width * height / 2; }
  };
  
int main () {
  Rectangle rect {1,2};
  // Triangle trgl{4,5};
  rect.public_set_values (4,5);
  // trgl.set_values (4,5);
  cout << rect.area() << '\n';
  // cout << trgl.area() << '\n';
  return 0;
}