global matrix_mul
section .text
matrix_mul:
    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15


    mov r15, rcx
    mov r12, rdi
    mov r13, rsi
    mov r14, rdx

    mov rbx, r15 ; i

    push r14
    for_i_in_range1:

        xor rcx, rcx
        for_j_in_range2:
            mov r10, r12

            lea r11, [r13 + 4 * rcx]
            mov rdx, r15 ; k
            xor rax, rax
            xor r9, r9
            for_k_in_rangeMul:
                mov eax, dword[r10]
                imul eax, dword[r11]

                add r9, rax
                add r10, 4

                lea r11, [r11 + 4 * r15]

                dec rdx

                cmp rdx, qword 0
                jne for_k_in_rangeMul



            mov [r14], r9
            add r14, 4
            inc rcx
            cmp rcx, r15
            jne for_j_in_range2

        dec rbx
        lea r12, [r12 + 4 * r15]
        cmp rbx, qword 0
        jne for_i_in_range1
    pop r14
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret