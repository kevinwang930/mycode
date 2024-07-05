#include<iostream>
#include<string>

using namespace std;

template <typename T>
T adder(T v)
{
    cout << "call single adder" << endl;
    // cout << "result is " << v << endl;
    return v;
}

template <typename T, typename... Args>
T adder(T first, Args... args)
{
    cout << "call multiple args adder" << endl;
    return first + adder(args...);
}
int main () {
    long sum = adder(1, 2, 3, 'a', 7);
    cout << "result is " << sum << endl;

    // std::string s1 = "x", s2 = "aa", s3 = "bb", s4 = "yy";
    // std::string ssum = adder(s1, s2, s3, s4);
    // cout << ssum << endl;
}
