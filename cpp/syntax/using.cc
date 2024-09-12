#include <iostream>

using i = int;

int main() {

    i a{1};
    a = (1,2,3);

    std::cout << a << std::endl;
}