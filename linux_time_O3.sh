#!/bin/bash
gcc -O3 $1 -o matrix_linux.obj -c && gcc -O3 matrix_linux.obj timer.c -o timer_linux.o && ./timer_linux.o results_gcc_O3.bin