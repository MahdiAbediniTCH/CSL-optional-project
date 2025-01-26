global matrix_mul

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
        cmp r15, r8

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
    mov rax, r8
    mul rax
    mov r9, r8
    shl r9, 2
    macrofor:

        cmp r10, r8
        jne ifisnt
        xor r10, r10
        xor rcx , rcx
        add rbx, 4


        ifisnt:
        mov rdx, [rcx + rbx]
        mov [%2 + 4 * r11], rdx

        inc r11
        inc r10
        add rcx, r9
        cmp r11, rax
        jne macrofor
    mov %1, %2
%endmacro



section .text

matrix_mul:

    mov r12, rdi
    mov r13, rsi
    mov r14, rdx
    mov r15, r8

    mov r8, rcx

    push rcx


    ; transpose r13, r15

    
    pop rcx



    xor r9, r9
    mov rcx, r8
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
            cmp r11, r8
            jne for_j

        inc r10
        add rdi, rcx
        cmp r10, r8
        jne for_i
    ret

