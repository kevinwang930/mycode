#include<iostream>
using namespace std;

class Rectangle
{
public:
    int width, height;
    Rectangle() {};
    Rectangle(int a, int b) :width(a), height(b) {};

    int area() { return width * height; }

    void testThis() {
        cout << this << endl;
    }
    Rectangle* operator->() {
        width++;
        return this;};
};

int main () {
    Rectangle a {1,2};
    a.testThis();
    cout << a->width << endl;
}
