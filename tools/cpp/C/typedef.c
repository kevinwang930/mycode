#include <stdio.h>
#include <string.h>





typedef struct _book
{
    char title[50];
    char author[50];
    char subject[100];
    int book_id;
}Book;

typedef struct _book *book_p;
typedef int *pointer_i;

typedef void (*pointer_func)(int);

    void print_n(int n)
{
    printf("%d\n", n);
}

int main()
{
    int a = 1;
    pointer_i p = &a;
    pointer_func fp = &print_n;
    fp(5);
    printf("%d\n",*p);
    
   Book boo1;
   book_p bp = &boo1;
   strcpy_s(boo1.title,sizeof(boo1.title),"c language");
   printf("%s\n",(*bp).title);

   printf("size of Book is %llu\n",sizeof(Book));
   
    return 0;
}