#include<iostream>
#include"other.h"

class base: public StaticBase {

};

int main() {
    base c;
    c.staticMember = 1;
    std::cout << c.staticMember << std::endl;
}