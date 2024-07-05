#include<libloaderapi.h>

int main() {
    LPWSTR lpFilename[256];
    GetModuleFileNameW(NULL, lpFilename,256);
    printf("%s\n",lpFilename);
}