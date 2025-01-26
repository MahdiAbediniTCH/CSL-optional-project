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
        ret
    ;;;;;;;;;;;;;;;;;;;;


section .data

n_input: db "%d", 0
out: db "%d ", 0
out2: db 10, 0
n: dq  100

