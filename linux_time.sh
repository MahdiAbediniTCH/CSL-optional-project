#!/bin/bash
gcc c_matrix_mul.c -o matrix_linux.obj -c 
gcc matrix_linux.obj timer.c -o timer_linux.o 
./timer_linux.o results_gcc_O0.bin