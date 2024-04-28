#include <iostream>
#include <bitset>

using namespace std;

int main(void)
{

    bitset<4> b("0001");

    auto result = b << 1;
    auto result2 = (1 << b);

    cout << result << endl;
    cout <<b<<endl;

    return 0;
}