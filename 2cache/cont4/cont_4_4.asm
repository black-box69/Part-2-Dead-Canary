extern io_get_dec, io_print_dec, io_print_char

;made by: 2cache

section .text
f:
    push ebp
    mov ebp, esp
    
    call io_get_dec
    mov ecx, eax
    push ecx
    
    cmp ecx, 0
    je .END
    
    mov edx, dword[ebp + 8]
    xor edx, 1
    cmp edx, 1
    mov dword[ebp+8], edx
    
    jne .LABLE

    mov eax, ecx
    call io_print_dec
    mov eax, 32
    call io_print_char
    mov eax, ecx
    
    .LABLE:
        mov edx, dword[ebp+8]
        push edx
        call f
        cmp dword[ebp+8], 0
        jne .END
        mov eax, dword[ebp-4]
        call io_print_dec
        mov eax, 32
        call io_print_char
    .END: 
        pop ecx     
        pop edx
        leave
        ret
        
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    mov edx, 0
    
    push edx
    call f
    add esp, 4
    
    xor eax, eax
    ret
