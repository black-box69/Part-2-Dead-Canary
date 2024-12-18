extern io_get_dec, io_print_dec

;made by: 2cache

section .bss
k resd 1
N resd 1
A resd 1

section .text

;f(x1, x0) int pow_k
f:
    push ebp
    mov ebp, esp
    
    push 1 ; minimum pow of k that is above A
    .L:
        mov eax, dword[ebp+8]
        cmp eax, 0
        je .ZERO_CASE
        cmp eax, dword[ebp-4]
        jl .EXIT
        mov ecx, dword[k]
        mov eax, dword[ebp-4]
        mul ecx
        mov dword[ebp-4], eax
        jmp .L
        .ZERO_CASE:
            mov eax, dword[ebp+12]
            mov ecx, dword[k]
            mul ecx
            add esp, 4
            leave 
            ret
        .EXIT:
            mov eax, dword[ebp+12]
            mov ecx, dword[ebp-4]
            mul ecx
            add eax, dword[ebp+8]
            add esp, 4
            leave 
            ret

global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    call io_get_dec
    mov dword[k], eax
    call io_get_dec 
    mov dword[N], eax
    call io_get_dec 
    mov dword[A], eax
    
    xor edi, edi
    mov eax, dword[A]
    mov ecx, 2011
    xor edx, edx
    div ecx
    mov eax, edx ; eax = x0
    
    mov ebx, eax ; ebx = x0
    push eax
    push eax
    call f
    add esp, 8
    mov ecx, 2011
    xor edx, edx
    div ecx
    mov eax, edx ; eax = x1
      
    inc edi
    
    L:
        cmp edi, dword[N]
        je EXIT
        push eax ; X(I)
        push ebx ; x(i-1)
        mov ebx, eax
        call f ; 
        add esp, 8
        mov ecx, 2011
        xor edx, edx
        div ecx
        mov eax, edx ; eax = x(i+1)
        inc edi
        jmp L
        EXIT:
            call io_print_dec
    
    
    xor eax, eax
    ret
