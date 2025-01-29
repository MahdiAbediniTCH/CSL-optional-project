global matrix_mul
section .text
matrix_mul:
    mov r15, rcx
    mov r12, rdi
    mov r13, rsi
    mov r14, rdx

    xor rbx, rbx ; i
    mov r10, r15
    shl r10, 2


    push r14
    for_i_in_range1:

        xor r9, r9
        xor r11, r11
        for_j_in_range2:

            xor rdx, rdx

            for_k_in_rangeMul:
                mov eax, dword[4 * r9 + r13]
                imul eax, dword[4 * r11 + r12]

                mov ecx, dword[4 * rdx + r14]
                add ecx, eax
                mov dword[4 * rdx + r14], ecx

                inc r9
                inc rdx
                cmp rdx, qword r15
                jne for_k_in_rangeMul

            inc r11
            cmp r11, r15
            jne for_j_in_range2

        inc rbx
        add r14, r10
        add r12, r10
        cmp rbx, r15
        jne for_i_in_range1
    pop r14
    ret