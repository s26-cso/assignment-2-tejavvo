#include <stdio.h>
#include <stdlib.h>
 
struct Node {
    int val;
    struct Node* left;
    struct Node* right;
};
 
extern struct Node* make_node(int val);
extern struct Node* insert(struct Node* root, int val);
extern struct Node* get(struct Node* root, int val);
extern int getAtMost(int val, struct Node* root);
 
int main() {
    struct Node* root = NULL;
    int vals[] = {50, 30, 70, 20, 40, 60, 80};
    for (int i = 0; i < 7; i++)
        root = insert(root, vals[i]);
 
    printf("get(50): %s\n", get(root, 50) ? "found" : "NULL");
    printf("get(40): %s\n", get(root, 40) ? "found" : "NULL");
    printf("get(99): %s\n", get(root, 99) ? "found" : "NULL");
 
    // getAtMost tests
    printf("getAtMost(45): %d (expect 40)\n", getAtMost(45, root));
    printf("getAtMost(60): %d (expect 60)\n", getAtMost(60, root));
    printf("getAtMost(10): %d (expect -1)\n", getAtMost(10, root));
    printf("getAtMost(100): %d (expect 80)\n", getAtMost(100, root));
    return 0;
}
 
