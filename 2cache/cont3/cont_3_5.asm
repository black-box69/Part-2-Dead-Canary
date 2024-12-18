extern io_get_dec, io_print_dec

section .bss
max_len resd 1
len resd 1
buf resd 1
n resd 1
i resd 1

;made by: 2cache

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    mov dword[len], 1
    mov dword[max_len], 1
    call io_get_dec
    
    cmp eax, 0
    je ZERO_CASE
    
    
    dec eax
    mov dword[n], eax ; n-1
    call io_get_dec ; scanf(a)
    mov dword[i], 0
    L:
        mov dword[buf], eax
        call io_get_dec ; scanf(b)
        ; buf = a, eax = b
        cmp dword[buf], eax 
        jnl ELSE
        inc dword[len]
        jmp CONDITION
        ELSE:
            mov ebx, dword[len]
            cmp ebx, dword[max_len]
            mov dword[len], 1
            jng CONDITION
            mov dword[max_len], ebx
            
        CONDITION: 
            inc dword[i]
            mov ebx, dword[n]
            cmp dword[i], ebx
            jl L
            
    mov eax, dword[len]
    cmp eax, dword[max_len]
    jl EXIT
    mov dword[max_len], eax
    
    ZERO_CASE:
        call io_print_dec
        xor eax, eax
        ret
    
    EXIT:
    
    mov eax, dword[max_len]
    call io_print_dec
    xor eax, eax
    ret
