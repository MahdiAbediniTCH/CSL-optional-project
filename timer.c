#include <stdio.h>
#if defined(_WIN32) || defined(_WIN64)
#include <windows.h>
#else
#include <time.h>
#endif


void matrix_mul(int*, int*, int*, int);

void time_once(int* m1, int* m2, int* m3, int n) {
    #if defined(_WIN32) || defined(_WIN64)
    // Windows-specific timing code
    LARGE_INTEGER start, end, frequency;
    double time_taken;

    QueryPerformanceFrequency(&frequency);
    QueryPerformanceCounter(&start);

    matrix_mul(m1, m2, m3, n);

    QueryPerformanceCounter(&end);
    time_taken = (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart;

    printf("Time taken (Windows): %.9lf seconds\n", time_taken);
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

    printf("Function execution time: %ld ns\n", nanoseconds);
    printf("Function execution time: %.9f s\n", elapsed);
    #endif
    return 0;
}
int main() {
    int n = 3;
    int m1[3][3] = {{1,1,1},{1,1,1},{1,1,1}};
    int m2[3][3] = {{1,2,3},{1,2,3},{1,2,3}};
    int m3[3][3];
    
    time_once(m1, m2, m3, n);

    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            printf("%d ", m3[i][j]);
        }
        puts("");
    }
}
    
// void time_general() {
//     int m1[3][3] = {{1,1,1},{1,1,1},{1,1,1}};
//     int m2[3][3] = {{1,2,3},{1,2,3},{1,2,3}};
//     int m3[3][3];
//     clock_t start, end;
//     double cpu_time_used;

//     start = clock();
//     matrix_mul(m1, m2, m3, 3); // Call the function you want to time
//     end = clock();

//     cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
//     printf("Function execution time: %.9lf seconds\n", cpu_time_used);

// }
// void time_windows() {
//     int m1[3][3] = {{1,1,1},{1,1,1},{1,1,1}};
//     int m2[3][3] = {{1,2,3},{1,2,3},{1,2,3}};
//     int m3[3][3];
//     LARGE_INTEGER frequency, start, end;
//     double elapsed;

//     QueryPerformanceFrequency(&frequency);
//     QueryPerformanceCounter(&start);
//     matrix_mul(m1, m2, m3, 3); // Call the function you want to time
//     QueryPerformanceCounter(&end);

//     elapsed = (double)(end.QuadPart - start.QuadPart) / frequency.QuadPart;

//     printf("Function execution time: %.9lf seconds\n", elapsed);

// }