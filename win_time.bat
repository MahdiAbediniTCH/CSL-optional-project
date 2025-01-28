@echo off
gcc c_matrix_mul.c -o matrix_win.obj -c 2> nul
gcc -O3 matrix_win.obj timer.c -o timer_win.exe 2> nul
timer_win.exe results_gcc_O0_win.bin