#include <stdio.h>
#include <stdlib.h>
#if defined(_WIN32) || defined(_WIN64)
#include <windows.h>
#else
#include <time.h>
#endif

#define IND(i, j) ((i)*n + (j))



void matrix_mul(int*, int*, int*, int);

int* generate_matrix(int n) {
    int* m = malloc(sizeof(int) * n * n);
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            m[IND(i, (j + i) % n)] = j + 1;
        }
    }
    return m;
}
void print_matrix(int* m, int n) {
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            printf("%d\t", m[IND(i, j)]);
        }
        puts("");
    }
    return;
}
double time_once(int* m1, int* m2, int* m3, int n) {
    #if defined(_WIN32) || defined(_WIN64)
    // Windows-specific timing code
    LARGE_INTEGER start, end, frequency;
    double time_taken;

    QueryPerformanceFrequency(&frequency);
    QueryPerformanceCounter(&start);

    matrix_mul(m1, m2, m3, n);

    QueryPerformanceCounter(&end);
    time_taken = (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart;

    // printf("Time taken (Windows): %.9lf seconds\n", time_taken);
    return time_taken;
    #else
    // Linux-specific timing code
    struct timespec start, end;
    double time_taken;

    clock_gettime(CLOCK_MONOTONIC, &start);

    matrix_mul(m1, m2, m3, n);

    clock_gettime(CLOCK_MONOTONIC, &end);
    long seconds = end.tv_sec - start.tv_sec;
    long nanoseconds = end.tv_nsec - start.tv_nsec;
    double elapsed = seconds + nanoseconds*1e-9;

    // printf("Function execution time: %ld ns\n", nanoseconds);
    // printf("Function execution time: %.9f s\n", elapsed);
    return elapsed;
    #endif
    return 0;
}
// MIN_N Must be a multiple of 4
#define MIN_N 4
#define MAX_N 1024
#define N_RESULTS ((MAX_N - MIN_N) / 4 + 1)
#define N_SAMPLES 5

int main(int argc, char* argv[]) {
    char* filename = argv[1];
    if (argc != 2) {
        fprintf(stderr, "Need output file name.\n");
        return 1;
    }

    double results[N_RESULTS];
    // loop for each size
    for (int n = MIN_N; n <= MAX_N; n += 4) {
        // average of 5 for accuracy
        int ind = n / 4 - 1;
        results[ind] = 0;

        int* m1 = generate_matrix(n);
        int* m2 = generate_matrix(n);
        int* m3 = malloc(n * n * sizeof(int));

        for (int j = 0; j < N_SAMPLES; j++) {
            double t = time_once(m1, m2, m3, n);
            results[ind] += t;
        }
        results[ind] /= N_SAMPLES;
        printf("%d: %.9lf\n", n, results[ind]);
        // debug:        
        // if (n < 20)
        //     print_matrix(m3, n);
        free(m1); free(m2); free(m3);
    }
    // store results binary:
    FILE *file = fopen(filename, "wb");
    if (!file) {
        perror("Failed to open file");
        return 1;
    }
    size_t elements_written = fwrite(results, sizeof(double), N_RESULTS, file);
    if (elements_written != N_RESULTS) {
        perror("Failed to write data to file");
        fclose(file);
        return 1;
    }
    fclose(file);
    
}