global matrix_mul

%macro dot 2
    xorps xmm0, xmm0
    xor r15 , r15

    next_four:

        movdqu xmm1, [%1]

        movdqu xmm2, [%2]

        pmulld xmm1, xmm2

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
%macro transpose 1
    mov r10,%1
    xor r9,r9

    shl r8,2
    mov rdx, r8
    add rdx, %1
    macrofor1:

        mov r11,r10
        mov rcx, r9

        macrofor2:

            mov ebx, [r9+r11]
            mov eax, [rcx+r10]
            mov [r9+r11], eax
            mov [rcx+r10], ebx
            add rcx, r8
            add r11,4
            cmp r11,rdx
            jne macrofor2

        add r10,4
        add r9, r8
        cmp r10,rdx
        jne macrofor1
%endmacro



section .text

 matrix_mul:

    mov r12, rdi
    mov r13, rsi
    mov r14, rdx
    mov r8, rcx

    push r8
    transpose r13
    pop r8


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
