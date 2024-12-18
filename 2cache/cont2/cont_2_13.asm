extern io_get_char, io_print_dec, io_print_char, io_get_dec

section .bss
x1 resd 1
y1 resd 1
x2 resd 1
y2 resd 1

; modulus -- <<1 >>1 bezznak

;made by: 2cache

section .text
global main
main:
    mov ebp, esp; for correct debugging
    call io_get_char ;
    mov dword[x1], eax ;
    
    call io_get_dec ;
    mov dword[y1], eax ;
    
    
    call io_get_char ;
    call io_get_char ;
    mov dword[x2], eax ;

    call io_get_dec ;
    mov dword[y2], eax ;
    
    
    sub dword[x1], 65 ;      
    sub dword[x2], 65 ;

        
                        
    mov eax, dword[x2];
    sub dword[x1], eax ;
    
    mov eax, dword[y2] ;
    sub dword[y1], eax ;
    
    mov eax, dword[y1] ;
    sar eax, 31 ;
    imul eax, 2 ;
    imul eax, dword[y1] ;
    add dword[y1], eax ;
    
    
    mov eax, dword[x1] ;
    sar eax, 31 ;
    imul eax, 2 ;
    imul eax, dword[x1] ;
    add dword[x1], eax ;
    
    mov eax, dword[x1] ;
    add eax, dword[y1] ;
    

    call io_print_dec ;
    
    xor eax, eax
    ret
