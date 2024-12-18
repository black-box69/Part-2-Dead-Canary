extern io_get_udec, io_print_udec, io_newline

;made by: 2cache

section .bss
k resd 1
A resd 1
N resd 1
F resd 2011 ; [f(0), f(1), ... f(2010)]

section .text

; convert(D) res
CONVERT:
    push ebp
    mov ebp, esp
    
    sub esp, 4
    mov dword[ebp-4], 0
    ;sub esp, 4
    .L:
        cmp dword[ebp+8], 0
        je .EXIT
        ;mov ecx, dword[k]
        mov eax, dword[ebp-4]
        mul dword[k]
        mov dword[ebp-4], eax
        mov eax, dword[ebp+8] 
        xor edx, edx
        div dword[k]
        add dword[ebp-4], edx
        mov dword[ebp+8], eax
        jmp .L
        .EXIT:
            ;add esp, 4
            mov eax, dword[ebp-4]
            add esp, 4
            leave 
            ret
    

global main
main:
    mov ebp, esp; for correct debugging
    call io_get_udec
    mov dword[k], eax
    call io_get_udec
    mov dword[N], eax
    call io_get_udec
    mov dword[A], eax
    
    xor edi, edi
    L:
        cmp edi, 2010
        je EXIT
        mov eax, edi
        mul edi
        push eax
        call CONVERT
        add esp, 4
        mov ecx, 2011
        xor edx, edx
        div ecx
        mov dword[F + edi*4], edx
        inc edi
        jmp L
    EXIT:
    
    mov eax, dword[A]
    mov ecx, 2011
    xor edx, edx
    div ecx
    mov eax, edx
    
    xor edi, edi
    L2:
        cmp edi, dword[N]
        je END
        mov eax, dword[F + eax*4]
        inc edi
        jmp L2
    END:
        call io_print_udec
        xor eax, eax
        ret
