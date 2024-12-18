extern io_get_dec, io_print_char ;

section .bss
buf resd 1

;made by: 2cache

section .data
fam dd "SCDH"
rank dq "23456789TJQKA"

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    call io_get_dec ;
    sub eax, 1;
    cdq ;
    mov ebx, 13 ;
    idiv ebx ;
    
    mov ebx, eax ;
    
    
    
    mov al, rank[edx] ;
    
    mov dword[buf], edx ;
        
    call io_print_char ;
    
    mov ecx, ebx ;
    mov al, fam[ecx] ;
    
    call io_print_char ;
    
    xor eax, eax
    ret
