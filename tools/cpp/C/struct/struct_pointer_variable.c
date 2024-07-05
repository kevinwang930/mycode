#include <stdio.h>
typedef struct base
{
    int a;
    char b;
} sname;

sname test()
{
    return (sname){.a = 1, .b = 'k'};
}

int main()
{
    struct base s,s1;
    s.a = 1;
    s.b = 'n';
    s1 = s;
    printf("value in struct %d\t%c\n", s1.a, s1.b);
    s.a = 10;
    printf("value in struct %d\t%c\n", s1.a, s1.b);
    sname s2;
    s2 = test();

    
    printf("value in struct %d\t%c\n", s2.a, s2.b);
}