#include<stdio.h>

int x;
int a;
unsigned char b;
unsigned char *p;
char letter;
float the_float;


int main() {

    printf("%llu\n",sizeof(a));
    printf("%llu\n", sizeof(b));
    printf("%llu\n", sizeof(unsigned char *));
    printf("%llu\n", sizeof(int *));
    if (a == NULL)
    {
        printf("a is null not initialized\n");
    }
    
}