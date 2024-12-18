extern io_get_dec, io_print_dec

section .data
n dd 0
max_d dd 1

;made by: 2cache

section .text
global main
main:
    mov ebp, esp; for correct debugging
    mov esi, 0 ; found d
    ;write your code here
    call io_get_dec
    mov ebx, 1 ; i
    mov dword[n], eax
    L:
        inc ebx
        xor edx, edx
        mov eax, ebx
        mul ebx
        cmp eax, dword[n]
        jg EXIT
        
        mov eax, dword[n]
        div ebx ; eax - n/i; ebx - i
        cmp edx, 0 ;
        jne L
        cmp eax, ebx
        cmovl eax, ebx
        cmp eax, dword[max_d]
        cmovl eax, dword[max_d]
        mov dword[max_d], eax
        jmp L 
    EXIT:
        mov eax, dword[max_d]
        call io_print_dec
    
    
    xor eax, eax
    ret
