extern io_get_udec, io_print_dec

section .bss
i resd 1
fl resd 1

;made by: 2cache

section .text
global main
; eax -- n
; res - res
main:
    mov ebp, esp; for correct debugging
    mov dword[fl], 1
    mov dword[i], 10
    call io_get_udec ; ecx - ebx
    
    cmp eax, 0
    jne LABEL
    
    call io_print_dec
    jmp EXIT
    
    
    LABEL:
    mov ebx, eax 
    shr eax, 30
    shl ebx, 2
    cmp eax, 0
    je L
    call io_print_dec
    mov dword[fl], 0
    
    L:
        mov eax, ebx
        shr eax, 29
        cmp dword[fl], 1
        jne PRINT
        cmp eax, 0
        jne UP_FLAG 
        jmp CONTINUE
        PRINT:
            call io_print_dec 
            jmp CONTINUE 
        UP_FLAG:
            call io_print_dec
            mov dword[fl], 0    
        CONTINUE:
            sub dword[i], 1
            mov edx, dword[i]
            shl ebx, 3
            cmp edx, 0
            jng EXIT
            jmp L
    EXIT:
        
   
        
        
    
    
    xor eax, eax
    ret
