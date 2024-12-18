extern io_get_udec, io_print_udec, io_print_char ;

section .bss
a11 resd 1
a12 resd 1
a21 resd 1
a22 resd 1
b1 resd 1
b2 resd 1
x resd 1
y resd 1
res1 resd 1
res2 resd 1

;made by: 2cache

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    call io_get_udec ;
    mov dword[a11], eax ;
    
    call io_get_udec ;
    mov dword[a12], eax ;
    
    call io_get_udec ;
    mov dword[a21], eax ;
    
    call io_get_udec ;
    mov dword[a22], eax ;
    
    call io_get_udec ;
    mov dword[b1], eax ;
    
    call io_get_udec ;
    mov dword[b2], eax ;
    ;;;;;;;;;
    mov eax, dword[a11] ;
    and eax, dword[x] ;
    
    
    mov ebx, dword[a12] ;
    and ebx, dword[y] ;
    
    xor eax, ebx ;
    xor eax, dword[b1] ;
    mov dword[res1], eax ;
    
    
    ;;;;;;;;;;
    mov eax, dword[a21] ;
    and eax, dword[x] ;
    
    
    mov ebx, dword[a22] ;
    and ebx, dword[y] ;
    
    xor eax, ebx ;
    xor eax, dword[b2] ;
    mov dword[res2], eax ;
    ;;;;;;;;;;;;;;;;;;;;; all 1 bits are incorrect, let's make all incorrect x-bits 1; (1, 0)
    
    mov eax, dword[res1] ;
    or eax, dword[res2] ;
    xor dword[x], eax ;
    
    ; let's find incorrect bits ;
    
    mov eax, dword[a11] ;
    and eax, dword[x] ;
    
    
    mov ebx, dword[a12] ;
    and ebx, dword[y] ;
    
    xor eax, ebx ;
    xor eax, dword[b1] ;
    mov dword[res1], eax ;
    
    
    ;;;;;;;;;;
    mov eax, dword[a21] ;
    and eax, dword[x] ;
    
    
    mov ebx, dword[a22] ;
    and ebx, dword[y] ;
    
    xor eax, ebx ;
    xor eax, dword[b2] ;
    mov dword[res2], eax ;
    ;;;;;;;;;;;;;;;;;;;;;;;; all 1 bits are incorrect, let's make all incorrect y-bits 1; (1, 1)
    
    mov eax, dword[res1] ;
    or eax, dword[res2] ;
    xor dword[y], eax ;
    
    ; let's find incorrect bits ;
    
    mov eax, dword[a11] ;
    and eax, dword[x] ;
    
    
    mov ebx, dword[a12] ;
    and ebx, dword[y] ;
    
    xor eax, ebx ;
    xor eax, dword[b1] ;
    mov dword[res1], eax ;
    
    
    ;;;;;;;;;;
    mov eax, dword[a21] ;
    and eax, dword[x] ;
    
    
    mov ebx, dword[a22] ;
    and ebx, dword[y] ;
    
    xor eax, ebx ;
    xor eax, dword[b2] ;
    mov dword[res2], eax ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;; all 1 bits are incorrect, let's make all incorrect x-bits 0; (0, 1)
    
    mov eax, dword[res1] ;
    or eax, dword[res2] ;
    xor dword[x], eax ;
    
    mov eax, dword[x] ;
    call io_print_udec ;
    
    mov eax, 32 ;
    call io_print_char ;
    
    mov eax, dword[y] ;
    call io_print_udec ;
    
    
    xor eax, eax
    ret
