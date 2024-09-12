
typedef struct s{

    int a;
    char b;
} types;

int main() {
    int a = 1;
    void * ptr = (void *)a;
    printf("%p\n",ptr);

    types ts = {1,"c"};
    void * ptr2 = (void *)ts;
    printf("%p\n", ptr2);
}
