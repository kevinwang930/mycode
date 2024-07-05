#include<stdio.h>
typedef struct base {
    int a;
    char b;
}sname;

sname test() {
    return (sname){.a=1,.b='k'};
}

int main() {
    struct base s;
    s.a = 1;
    s.b = 'n';
    sname s1;
    s1.a = 1;
    s1.b = 'k';
    sname s2;
    s2 = test();
    printf("value in struct %d\t%c\n",s.a,s.b);
    printf("value in struct %d\t%c\n", s1.a, s1.b);
    printf("value in struct %d\t%c\n", s2.a, s2.b);
}