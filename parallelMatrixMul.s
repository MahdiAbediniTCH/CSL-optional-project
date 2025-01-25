global main
extern printf
extern scanf
extern malloc


%macro dot 2
    xorps xmm0, xmm0
    xor r15 , r15

    next_four:

        movdqu xmm1, [%1]

        movdqu xmm2, [%2]

        pmaddwd xmm1, xmm2

        addps xmm0, xmm1


        add r15, 4 ; n
        add %1, 16 ; 2 
        add %2, 16 ; 1
        cmp r15, qword [n]

        jne next_four

    pxor xmm1, xmm1
    summing:
        phaddd xmm0, xmm1
        phaddd xmm0, xmm1


        movd r15d, xmm0
%endmacro
%macro transpose 2
    mov rbx, %1
    xor rcx, rcx ; j
    xor r11, r11 ; k
    xor r10, r10
    mov rax, [n]
    mul rax
    mov r9, [n]
    shl r9, 2
    macrofor:

        cmp r10, qword[n]
        jne ifisnt
        xor r10, r10
        xor rcx , rcx
        add rbx, 4


        ifisnt:
        mov r8, [rcx + rbx]
        mov [%2 + 4 * r11], r8

        inc r11
        inc r10
        add rcx, r9
        cmp r11, rax
        jne macrofor
    mov %1, %2
%endmacro



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

    mov rax, [n]
    mul rax
    shl rax,  2
    mov rdi, rax
    call malloc
    mov r15, rax

    call matrix_mul

    mov rax, [n]
    mul rax
    mov r15, rax
    mov r12, 0



    last_for: 
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
        jne last_for

    add rsp, 8

    xor rax, rax
    ret

    matrix_mul:

        transpose r13, r15
 
        xor r9, r9
        mov rcx, [n]
        shl rcx, 2
        mov rdi, r12
        xor r10 , r10

        for_i: ; r10 counter
            mov rsi, r13
            xor r11, r11

            for_j: ; r11 counter
                mov rdx, rdi
                mov rbx, rsi

                dot rdx, rbx
                mov [r14 + 4 * r9], r15d
                inc r11
                inc r9
                add rsi, rcx
                cmp r11, qword[n]
                jne for_j

            inc r10
            add rdi, rcx
            cmp r10, qword[n]
            jne for_i
        ret

section .data

n_input: db "%d", 0
out: db "%d ", 0
out2: db 10, 0
n: dq  100
