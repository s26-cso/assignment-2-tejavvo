#include <stdio.h>
#include <dlfcn.h>

int main() {
    char op[8];
    int a, b;
    while (scanf("%s %d %d", op, &a, &b) == 3) {
        char lib[16];
        sprintf(lib, "./lib%s.so", op);
        void *h = dlopen(lib, RTLD_NOW);

        if (!h) continue;

        int (*f)(int, int) = dlsym(h, op);
        if (f) printf("%d\n", f(a, b));

        dlclose(h);
    }
    return 0;
}
