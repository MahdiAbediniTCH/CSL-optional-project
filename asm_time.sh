#!/bin/bash
nasm -F dwarf -f elf64 $1 -o asmobj.o && gcc timer.c asmobj.o && ./a.out results_${1}.bin