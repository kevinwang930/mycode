#include <stdio.h>
#include <stdlib.h>

typedef struct books
{
    char title[50];
    char author[50];
    int book_id;
}Book;
void print_n(int * n)
{
    *n = (*n)+1;
}

void print_size(Book *p)
{
    strcpy_s(p->author,sizeof(p->author), "long author very long very long");
    printf("%llu\n", sizeof(*p));
    printf("author is %s\n",p->author);
    printf("book id is %d\n",p->book_id);
}


int main()  {
    Book b = {"Book title","author",1};
    Book c;
    Book *d = &b;
    int a = 1;
    print_n(&a);
    printf("a = %d\n",a);
    print_size(&b);
    printf("%llu\n",sizeof(c));
    printf("%llu\n", sizeof(b));
    printf("%llu\n", sizeof(d));
}