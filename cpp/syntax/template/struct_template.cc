#include<iostream>
using namespace std;

struct s {
    template <bool,class type>
    struct helper {
        static const type kSize = 0;
    };
    template <class type>
    struct helper<false,type>
    {
        static const type kSize = 1;
    };

    template <class type>
    struct helper<true,type>
    {
        static const type kSize = 1;
    };
};

int main () {
    cout << s::helper<true,int>::kSize << endl;
}

