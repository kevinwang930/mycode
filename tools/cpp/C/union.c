#include <stdio.h>
#include <string.h>

union Data
{
    int i;
    float f;
    char str[20];
};

int main()
{

    union Data data;

    printf("Memory size occupied by data : %llu\n", sizeof(data));

    data.i = 1;
    printf("union integer %d\n",data.i);
    data.f = 1.5;
    printf("union float %.1f\n", data.f);

    return 0;
}