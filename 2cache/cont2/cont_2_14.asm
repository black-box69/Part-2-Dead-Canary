extern io_get_dec, io_print_dec ;

section .bss
n resd 1
m resd 1
k resd 1
d resd 1
x resd 1
y resd 1
fl resd 1
boxes resd 1

;made by: 2cache

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    call io_get_dec ;
    mov dword[n], eax ;
    
    call io_get_dec ;
    mov dword[m], eax ;
    
    call io_get_dec ;
    mov dword[k], eax ;
    
    call io_get_dec ;
    mov dword[d], eax ;
    
    call io_get_dec ;
    mov dword[x], eax ;
    
    call io_get_dec ;
    mov dword[y], eax ;
    
    mov eax, dword[m] ;
    imul eax, dword[n] ;
    imul dword[k] ;
    
    idiv dword[d] ;
    mov ecx, eax ; res of (n*m*k) / d
    
    
    add edx, dword[d] ;
    sub edx, 1 ;
    mov eax, edx ;
    
    
    cdq ;
    idiv dword[d] ;
    add ecx, eax ; ecx -- all boxes
    
    mov dword[boxes], ecx ;
    
            
    add dword[x], 18 ;
    mov eax, dword[x] ;
    mov ebx, 24 ;
    
    cdq ;
    idiv ebx ;
    mov dword[fl], eax ;
   
    mov eax, dword[boxes] ;
    add eax, 2 ; 1 box case
    
    mov ecx, 3 ; 
    cdq ;
    idiv ecx ;
    
    
    imul eax, dword[fl] ;
    sub dword[boxes], eax ;
    mov eax, dword[boxes] ;
    
    call io_print_dec ;
    
    
    
    ; !0 -> 1
    ;  0 -> 0
    ; (edx + d - 1) / d ;
    
    
    
    
    
    
    
    xor eax, eax
    ret
