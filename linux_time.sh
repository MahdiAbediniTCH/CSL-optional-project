#!/bin/bash
gcc matrix.c -o matrix_linux.obj -c 
gcc matrix_linux.obj timer.c -o timer_linux.o 
./timer_linux.o