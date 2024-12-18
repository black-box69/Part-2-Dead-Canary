extern scanf, calloc, strcmp, printf, free

;made by: 2cache

section .data
id db "%d", 0
is db "%s", 0


; r a
; ebp
; ...
; ...
; counter [esp+36]
; counter2 (for cycle) [esp+32]
; counter1 (for cycle) [esp+28]
; *s2 [esp+24]
; *s1 [esp+20] 
; *p [esp+16]
; n [esp+12]
; working zone [esp+8]
; working zone [esp+4]
; working zone [esp]



section .text
global main
main:
    push ebp
    mov ebp, esp
    sub esp, 56
    
    lea eax, [esp+8]
    mov dword[esp+4], eax
    mov dword[esp], id
    call scanf
    mov eax, dword[esp+8]
    mov dword[esp+12], eax ; copy of n
    
    mov dword[esp], eax
    mov dword[esp+4], 11 ; 10 chars + 0
    call calloc ; sizeof(arr) == n * 11
    
    mov dword[esp+16], eax ; counter
    
    ; fill the array
    mov eax, dword[esp+12]
    mov dword[esp+8], eax ; counter
    
    dec dword[esp+8]
    
    mov dword[esp], is
    L:
        mov ecx, dword[esp+8]
        cmp ecx, 0
        jl EXIT
        
        mov eax, ecx
        mov ecx, 11
        mul ecx
        add eax, dword[esp+16]
        mov dword[esp+4], eax
        call scanf
        
        dec dword[esp+8]
        jmp L
        
    
    EXIT:
        mov dword[esp+36], 1
        mov dword[esp+28], 1 ; counter1
        ; first word is always unique
        L1:
            mov ecx, dword[esp+28]
            cmp ecx, dword[esp+12]
            je END1
            mov eax, 11
            mul ecx
            add eax, dword[esp+16]
            mov dword[esp+20], eax
            
            mov dword[esp+32], 0 ; counter2
            L2:
                mov ecx, dword[esp+32]
                cmp ecx, dword[esp+28]
                jnl END2
                
                mov eax, 11
                mul ecx
                add eax, dword[esp+16]
                mov dword[esp+24], eax
                
                mov eax, dword[esp+24]
                mov dword[esp], eax
                
                mov eax, dword[esp+20]
                mov dword[esp+4], eax
                
                call strcmp
                cmp eax, 0
                je NOT_UNIQUE
                inc dword[esp+32]
                jmp L2
                
            END2:
                inc dword[esp+36]
                NOT_UNIQUE:
                    inc dword[esp+28]
                    jmp L1
        END1:
            mov eax, dword[esp+36]
        
            mov dword[esp], id
            mov dword[esp+4], eax
            call printf
        
            mov eax, dword[esp+16]
            mov dword[esp], eax
            call free
            
            add esp, 56
            leave
            xor eax, eax
            ret
