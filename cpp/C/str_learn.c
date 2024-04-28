#include<stdio.h>
#include<wchar.h>

int main() {
    wchar_t t = L"";
    printf("0 in character %c\n","\0");
    printf("%c\n", L"/?");
    printf("%llu\n",sizeof(char));
    printf("%llu\n", sizeof(unsigned short));

    if (t == '\0') {
        printf("null character equal \0");
    }

    wchar_t w1 = L"test";
    wchar_t w2 = L"test1";
    printf("compare result %d\n",wcscmp(&w1,&w2));
}