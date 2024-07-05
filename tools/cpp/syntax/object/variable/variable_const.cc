#include<iostream>
using namespace std;
enum class OperandSize : uint8_t
{
    kNone = 0,
    kByte = 1,
    kShort = 2,
    kQuad = 4,
    kLast = kQuad
};
int main() {
    const OperandSize a[3];

}