global main
extern printf
extern scanf
extern malloc



section .text


main:
    sub rsp, 8
    mov rdi, n_input
    mov rsi, n

    call scanf


    
    mov rax, [n]
    mul rax
    mov rbx, rax
    shl rax, 2
    mov rdi, rax
    call malloc

    mov r12, rax ; First Matrix
    xor r14, r14
    getting_first_matrix:
        lea rsi, [r12 + 4 * r14]
        mov rdi, n_input
        call scanf
        inc r14
        dec rbx
        cmp qword rbx, 0
        jne getting_first_matrix 
    
    mov rax, [n]
    mul rax
    mov rbx, rax
    shl rax,  2
    mov rdi, rax
    call malloc

    mov r13, rax ; Second Matrxi
    xor r14, r14

    getting_second_matrix:
        lea rsi, [r13 + 4 * r14]
        mov rdi, n_input
        call scanf
        inc r14
        dec rbx
        cmp qword rbx, 0
        jne getting_second_matrix 

    mov rax, [n]
    mul rax
    shl rax,  2
    mov rdi, rax
    call malloc
    mov r14, rax


    mov rdi, r12
    mov rsi, r13
    mov rdx, r14
    mov rcx, [n]

    call matrix_mul


    mov rax, [n]
    mul rax
    mov r15, rax
    mov r12, 0

    for_i: 
        inc r12

        mov rsi, [r14]
        mov rdi, out
        call printf
        add r14, 4
        dec r15
        cmp r12, qword[n]
        jne next
        xor r12, r12
        mov rdi, out2
        call printf
        next:
        cmp r15, qword 0
        jne for_i

    add rsp, 8

    xor rax, rax
    ret

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
    ;;;;;;;;;;;;;;;;;;;;


section .data

n_input: db "%d", 0
out: db "%d ", 0
out2: db 10, 0
n: dq  100

