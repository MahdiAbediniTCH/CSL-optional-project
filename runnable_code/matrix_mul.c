#include <stdio.h>
#include <stdlib.h>

#define IND(i, j) ((i)*n + (j))

void matrix_mul(int* m1, int* m2, int* dest, int n) {
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            dest[IND(i, j)] = 0;
            for (int k = 0; k < n; k++)
            {
                dest[IND(i, j)] += m1[IND(i, k)] * m2[IND(k, j)];
            }
        }
    }
    return;
}
void print_matrix(int* m, int n) {
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            printf("%d ", m[IND(i, j)]);
        }
        puts("");
    }
    return;
}

int main() {
    int n;
    scanf("%d", &n);
    int* m1 = malloc(n * n * sizeof(int));
    int* m2 = malloc(n * n * sizeof(int));
    int* m3 = malloc(n * n * sizeof(int));
    for (int i = 0; i < n * n; i++)
        scanf("%d", m1 + i);
    for (int i = 0; i < n * n; i++)
        scanf("%d", m2 + i);
    matrix_mul(m1, m2, m3, n);
    print_matrix(m3, n);
}