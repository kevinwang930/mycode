#include <iostream>
#include<string>
using namespace std;
int main() {
    char *str1 = "Werld";
    char *str11 = "Wello";
    // str1[0] = 'c';
    string str2 = "hello";
    string* str3 = new string(str2);
    // str3[0] = 'c';

    cout << str1 <<endl;
    cout << str2 <<endl;
    cout << *str3 << endl;
    cout << strcmp(str1,str11)<< endl;
    cout << "W int\t" << int('W') <<"\tw int\t" << int('w') << endl;
    cout << "z int\t" << int('z') << "\te int\t" << int('e') << endl;
}