// classes example
#include <iostream>
using namespace std;

class Rectangle
{
    

public:
    int width, height,other;
    Rectangle():width(5),height(5),other(5) {};
    Rectangle(int, int);

    int area() { return width * height; }
    void* operator new (size_t a, void* ptr) {
        cout << "this is new overload"<< endl;
        cout << "a is "<< a<< endl;

        return ptr;
    }
};

int main () {

    size_t a = 4;
    void * test;
    int * test2;
    void *buffer = malloc(12);
    Rectangle * s = new (buffer) Rectangle{};

    cout << "address of buffer " << buffer << endl;
    cout << "size of test pointer " << sizeof(test) << endl;
    cout << "size of int pointer " << sizeof(test2) << endl;
    cout << "size of int " << sizeof(int) << endl;
    cout << "size of buffer " << sizeof(buffer) << endl;
    cout << "size of s is " << sizeof(s) << endl;
    cout << "address of s " << s << endl;

    std::free(buffer);
}