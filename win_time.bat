@echo off
gcc matrix.c -o matrix_win.obj -c 2> nul
gcc matrix_win.obj timer.c -o timer_win.exe 2> nul
timer_win.exe