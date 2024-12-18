extern printf, scanf

;made by: 2cache

section .rodata
i_f db "%u", 0
o_f db "0x%08X", `\n`, 0

section .text
global main
main:
    push ebp
    mov ebp, esp
    sub esp, 24
    
    xor eax, eax
    L:
        mov dword[esp], i_f
        lea eax, [ebp-12]
        
        mov dword[esp+4], eax
        call scanf
        
        cmp eax, -1
        je EXIT
        
        mov eax, dword[ebp-12]
        mov dword[esp+4], eax
        
        mov dword[esp], o_f
        
        call printf
        
        jmp L
        
    EXIT:
        add esp, 24
        xor eax, eax
        leave
        ret
        
        
; a.v
; ebp
; ...
; a
; &a
; i_f
