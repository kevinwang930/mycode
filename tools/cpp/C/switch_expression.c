#include<stdio.h>

int main() {

    int a = 4;
    switch (a)
    {
        case 4:
            a = a +1;
        case 3:
            a = a -1;
        case 2:
            a = a  -1;
        case 1:
            a = a - 1;
            break;
    }
    printf("a after switch value is %d\n",a);
}