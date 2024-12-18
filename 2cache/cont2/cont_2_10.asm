extern io_get_dec, io_print_dec ;

section .bss
month resd 1
day_in_month resd 1

;made by: 2cache

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    call io_get_dec ;
    mov dword[month], eax ;
    
    call io_get_dec ;
    mov dword[day_in_month], eax ;
    
    sub dword[month], 1 ;
    
    ; 1 -- 41
    ; 2 -- 41 + 41 + 1
    ; 3 -- 41 + 41 + 41 + 1
    ; 4 -- 41 + 41 + 41 + 41 + 1 + 1
    ; 5 -- 41 + 41 + .. + 1 + 1
    ; (41 * N) + (N/2) ;
    
    mov ebx, dword[month] ;
    imul ebx, 41 ;
    
    
    shr dword[month], 1 ;
    add ebx, dword[month] ;
    add ebx, dword[day_in_month] ;
    mov eax, ebx ;
    call io_print_dec ;
    
    
    
        
    xor eax, eax
    ret
