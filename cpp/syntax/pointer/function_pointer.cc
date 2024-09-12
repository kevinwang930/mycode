#include <iostream>
using namespace std;

char foo(int a) // code starts at memory address 0x002717f0
{
    return char(a);
}

template <typename Return, typename... Args>
class GeneratedCode
{
public:
    using Signature = Return(Args...);
    Signature *fn_ptr_;
    GeneratedCode(Signature *fn_ptr)
        : fn_ptr_(fn_ptr) {}
    Return Call(Args... args) {
        return fn_ptr_(args...);
    }
};

int main()
    {
        std::cout << foo << '\n'; // we meant to call foo(), but instead we're printing foo itself!
        using signature = char (int a);
        signature *ptr = reinterpret_cast<signature*>(&foo);
        char (*fcnPtr)(int a){foo};
        cout << fcnPtr(97) << endl;
        cout << ptr(97) << endl;

        return 0;
    }