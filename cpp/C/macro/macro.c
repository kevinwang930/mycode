#include<stdio.h>


#define TEST
#ifdef TEST 
#define TESTDEFINED 1
#endif

int main() {

#ifdef TEST
printf("%s\n","test defined");
#else
printf("%s\n","test not defined");
#endif

}