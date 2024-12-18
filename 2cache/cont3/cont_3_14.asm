extern io_get_udec

section .bss
pascal resd 33*33
i resd 1
j resd 1

;made by: 2cache

section .text
global main
main:
    L1:
        cmp esi, 32
        je EXIT1
        mov edi, 0
        L2:
            cmp edi, 32
            je EXIT2 
            mov eax, esi
            imul eax, 32
            add eax, edi
            mov dword[pascal + eax*4]
            inc esi
        EXIT2:
        inc esi
    EXIT1:
    ;write your code here
    xor eax, eax
    ret
