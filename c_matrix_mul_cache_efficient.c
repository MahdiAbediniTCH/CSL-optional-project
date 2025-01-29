#define IND(i, j) ((i)*n + (j))

void matrix_mul(int* m1, int* m2, int* dest, int n) {
    for(int i = 0; i < n ; i++)
        for(int j = 0 ; j < n ; j++)
            dest[IND(i, j)] = 0;

    for (int i = 0; i < n; i++)
    {
        for (int k = 0; k < n; k++)
        {
            for (int j = 0; j < n; j++)
            {
                dest[IND(i, j)] += m1[IND(i, k)] * m2[IND(k, j)];
            }
        }
    }
    return;
}
