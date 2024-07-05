#include <stdio.h>
#include <assert.h>

#define _add1(a) (assert(a!=0),a = a+1)
#define test(type) { type ## t a; a = 1; printf("%d\n",(a));}



int main() {
    int a = (1,5);
    _add1(a);
    printf("%d\n",a);

    test(in);


}