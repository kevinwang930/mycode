// classes example
#include <iostream>
using namespace std;

class Rectangle
{
    int width, height;
public:
    static int si;
    Rectangle();
    Rectangle(int, int);

    int area() { return width * height; }
};
Rectangle::Rectangle(int a, int b)
{
    width = a;
    height = b;
}
Rectangle::Rectangle()
{
    width = 5;
    height = 10;
}
int Rectangle::si;
int main()
{
    
    Rectangle rect{3, 4}, recta(3, 5), rectb{};
    //   rect.set_values (3,4);
    //   rectb.set_values (5,6);
    cout << "rect area: " << rect.area() << endl;
    cout << "rect area: " << recta.area() << endl;
    cout << "rectb area: " << rectb.area() << endl;
    Rectangle::si = 10;
    cout << rect.si << endl;
    return 0;
}