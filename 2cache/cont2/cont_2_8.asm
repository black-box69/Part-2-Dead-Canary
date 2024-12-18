extern io_get_hex, io_print_hex

section .bss
a resd 1
b resd 1
c resd 1

;made by: 2cache

section .text
global main
main:
    mov ebp, esp; for correct debugging
    
    call io_get_hex ;
    mov dword[a], eax ;
    
    call io_get_hex ;
    mov dword[b], eax ;
    
    call io_get_hex ;
    
    and dword[a], eax ;
    
    not eax;
    
    and dword[b], eax ;
    
    mov eax, dword[b] ;
    
    or eax, dword[a];
    
    call io_print_hex;
    
    ;write your code here
    xor eax, eax
    ret
