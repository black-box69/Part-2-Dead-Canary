extern io_get_udec, io_print_udec, io_print_char

section .bss
n resd 1
arr resd 1000000
arr_new resd 10000000
k resd 1
mask resd 1

;made by: 2cache

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    call io_get_udec
    mov dword[n], eax
    mov ebx, 0
    
    cmp dword[n], 1
    je EMERG
    
    cmp dword[n], 0
    je ZERO_CASE

    
    L1:
        call io_get_udec
        mov dword[arr + ebx*4], eax
        mov dword[arr_new+ ebx*4], eax
        inc ebx
        cmp ebx, dword[n]
        jl L1
    
    call io_get_udec
    mov dword[k], eax
    
    mov edi, 0
    cmp dword[k], 0
    je EXIT
    
    mov edi, 1
    mov dword[mask], 1
    GENERATE_MASK:
        shl dword[mask], 1
        xor dword[mask], 1
        inc edi
        cmp edi, dword[k]
        jl GENERATE_MASK
    
    
    sub dword[n], 1
    
    mov edi, 0
    L2:
        mov eax, dword[arr + 4*edi]
        and eax, dword[mask]
        
        mov ecx, 32
        sub ecx, dword[k]
        shl eax, cl
        
        mov ecx, dword[k]
        shr dword[arr_new + 4*(edi + 1)], cl
        
        or dword[arr_new + 4*(edi + 1)], eax
        inc edi
        cmp edi, dword[n]
        jl L2
    
    
    ; update firts element of array
    mov eax, dword[arr + 4*edi]
    and eax, dword[mask]
        
    mov ecx, 32
    sub ecx, dword[k]
    shl eax, cl
    
    mov ecx, dword[k]
    shr dword[arr_new], cl
    or dword[arr_new], eax
    
    
    
    
    mov edi, 0
    inc dword[n]
    EXIT:
        ; print out array
        ; cmp dword[n], 1
        mov eax, dword[arr_new + edi*4]
        call io_print_udec
        mov eax, 32
        call io_print_char
        inc edi
        cmp edi, dword[n]
        jl EXIT

        
        
    xor eax, eax
    ret
        
        
    EMERG:
        call io_get_udec
        mov ebx, eax
        call io_get_udec
        
        mov ecx, eax
        mov eax, ebx
        
        ror eax, cl
        call io_print_udec
    ZERO_CASE:
        xor eax, eax
        ret
