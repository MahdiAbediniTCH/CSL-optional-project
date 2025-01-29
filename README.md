# SIMD matrix multiplication analysis
Computer Structure and Language optional assembly project

Project No.3: Using SIMD in x86_64 assembly to optimize matrix multiplication
# Usage
* Each shell script takes a specific type of file (either C code or asm) which includes ```matrix_mul``` function as an input and compiles it and links it with ```timer.c```

* ```timer.c``` will run the linked function multiple times according to defined constants and outputs the results as binary in ```results_*.bin```

* ```plot.py``` will read the results from the files specified in the code and plots them accordingly.

* To run and give input to files, go to ```runnable_code``` and simply either compile the C code or use ```run-asm.sh [filename]```  to compile and run the assembly codes.

Links:
  [GitHub](https://github.com/MahdiAbediniTCH/SIMD-matrix-multiplication-analysis)
  [Latex](https://latex.sharif.edu/read/nbtrgsfptbss)
