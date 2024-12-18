section .bss
x resd 1
n resd 1

;made by: 2cache

section .text
extern io_get_dec, io_print_dec
global main
main:
    call io_get_dec ;
    mov dword [x], eax ;
    
    call io_get_dec ;
    mov dword [n], eax;
    
    call io_get_dec ;
    sub dword[n], eax;
    
    call io_get_dec ;
    
    sub eax, 2011 ;
    
    imul eax, dword[n] ;
    add eax, dword[x] ;
    
    
    call io_print_dec ;
    
    xor eax, eax ; set eax to 0
    ret ; return
