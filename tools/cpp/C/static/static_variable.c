#include<stdio.h>

void test_func(void) 
{
    static int a = 1;
    printf("value of a is %d\n",a++);
}
int main() 
{
    test_func();
    test_func();
}