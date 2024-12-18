extern io_get_udec, io_print_udec

section .bss
A resd 1000
n resd 1
k resd 1

;made by: 2cache

section .text

count_zeros:
    push ebp
    mov ebp, esp
    cmp dword[ebp+8], 0
    push 0
    push 0
    je .ZERO_CASE
    
    mov dword[ebp-8], 0
    
    .SKIP_ZEROS:
        cmp dword[ebp-8], 33
        je .EXIT
        rcl dword[ebp+8], 1
        inc dword[ebp-8]
        jnc .SKIP_ZEROS

    .COUNT_ZEROS:
        cmp dword[ebp-8], 33
        je .EXIT
        rcl dword[ebp+8], 1
        
        jc .CONTINUE
        inc dword[ebp-4]
        .CONTINUE:
            inc dword[ebp-8]
            jmp .COUNT_ZEROS
            
    .ZERO_CASE:
        mov dword[ebp-4], 32
        
    .EXIT:
        mov eax, dword[ebp-4]
        add esp, 8
    leave
    ret

global main
main:
    mov ebp, esp; for correct debugging
    call io_get_udec
    mov dword[n], eax
    
    xor edi, edi
    FILL_ARR:
        cmp edi, dword[n]
        jnl EXIT1
        call io_get_udec
        mov dword[A + edi*4], eax
        inc edi
        jmp FILL_ARR
    EXIT1:
        
    
    
    
    call io_get_udec
    mov dword[k], eax
    
    xor edi, edi
    COUNT_DIGITS:
        cmp edi, dword[n]
        jnl EXIT2
        mov ecx, dword[A + edi*4]
        push ecx
        call count_zeros
        cmp eax, dword[k]
        mov dword[A + edi*4], 0
        jne SKIP
        mov dword[A + edi*4], 1
        SKIP:
            pop eax ;?
            inc edi
            jmp COUNT_DIGITS
    EXIT2:
    
    xor eax, eax
    xor edi, edi
    
    WIN_LAP:
        cmp edi, dword[n]
        jnl EXIT3
        add eax, dword[A + edi*4]
        inc edi
        jmp WIN_LAP
        
    EXIT3:
    
    
    call io_print_udec
    
    ;call io_print_dec
    ;write your code here
    xor eax, eax
    ret
