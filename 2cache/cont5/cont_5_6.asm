extern scanf, printf, fopen, calloc, free, fclose, fread, fwrite

;made by: 2cache

section .rodata
input_filename db "input.bin", 0 ;!
output_filename db "output.bin", 0 ;!
reading_mode db "rb", 0 ;!
writing_mode db "wb", 0 ;!

section .text

; input -- llil-endian num; output -- big-endian num
; input -- 0xabcd; output -- oxdcba

; r a
; ebp
; 0xabcd
; 0xd000
; 0x0c00
; 0x00b0
; 0x000a

; eax -- input
; eax -- output

lil2big:
    push ebp
    mov ebp, esp
    sub esp, 24
    
    mov dword[esp+16], eax
    
    mov dword[esp], eax
    mov dword[esp+4], eax
    mov dword[esp+8], eax
    mov dword[esp+12], eax
    
    shr dword[esp], 24
    
    shl dword[esp+4], 8
    shr dword[esp+4], 24
    shl dword[esp+4], 8
    
    shl dword[esp+8], 16
    shr dword[esp+8], 24
    shl dword[esp+8], 16
    
    shl dword[esp+12], 24
    
    mov eax, dword[esp+4]
    or dword[esp], eax
    
    mov eax, dword[esp+8]
    or dword[esp], eax
    
    mov eax, dword[esp+12]
    or dword[esp], eax
    
    mov eax, dword[esp]
    
    add esp, 24
    leave 
    ret

; eax - a
; ecx - b
; edx - cur2

compare: 
    push ebp
    mov ebp, esp
    
    cmp eax, ecx
    je .RET_CUR2
    
    cmp edx, 0
    je .RET_CUR2
    
    cmp eax, ecx
    jl .CASE
    mov eax, 1
    cmp edx, -1
    jne .RETURN
    mov eax, 0
    jmp .RETURN
    
    .CASE: 
        mov eax, -1
        cmp edx, 1
        jne .RETURN
        mov eax, 0
        jmp .RETURN
        
    .RET_CUR2:
        mov eax, edx
    .RETURN:
        leave
        ret
          
; r a
; ebp
; FILE * [esp+40]
; head [esp+36]
; cur [esp+32]
; cur2 [esp+28]
; res [esp+24]
; ... [esp+20]
; ... [esp+16]
; ... [esp+12]
; ... [esp+8]
; ... [esp+4]
; ... [esp]



global main
main:
    push ebp
    mov ebp, esp
    
    ; struct {
    ; int value;
    ; strcut list *next;
    ;};    
    
    sub esp, 56
    
    mov dword[esp], input_filename
    mov dword[esp+4], reading_mode
    call fopen
    mov dword[esp+40], eax
    
    
    mov dword[esp+36], 0 ; head = NULL
    mov dword[esp+28], 0 ; cur2 = head 
    
    
    lea eax, [esp+16] ; countains value
    mov dword[esp], eax
    mov dword[esp+4], 4
    mov dword[esp+8], 1
    mov eax, dword[esp+40]
    mov dword[esp+12], eax
    call fread
    
    cmp eax, 0
    je .EXIT
    
    mov dword[esp], 1
    mov dword[esp+4], 8 ; |value|*next|
    call calloc
    
    mov ecx, dword[esp+16]
    mov dword[eax], ecx
    mov dword[eax+4], 0
    
    mov dword[esp+36], eax
    mov dword[esp+28], eax
   
    .L:  ; fiiling arr
        lea eax, [esp+16] ; countains value
        mov dword[esp], eax
        mov dword[esp+4], 4
        mov dword[esp+8], 1
        mov eax, dword[esp+40]
        mov dword[esp+12], eax
        call fread
        
        cmp eax, 1
        jne .EXIT  
        
        mov dword[esp], 1
        mov dword[esp+4], 8 ; |value|*next|
        call calloc
        
        mov ecx, dword[esp+16]
        mov dword[eax], ecx
        mov dword[eax+4], 0
        mov edx, dword[esp+28]
        
        mov dword[edx+4], eax
        mov dword[esp+28], eax
        jmp .L
    .EXIT:
        
        mov eax, dword[esp+36]
        mov dword[esp+28], eax
        
        mov eax, dword[esp+36]
        mov eax, dword[eax+4]
        mov dword[esp+32], eax
         ; cur = head->next
    
        mov eax, dword[esp+36]
        mov dword[esp+28], eax ; cur2 = head
        
        mov dword[esp+24], -2 ; res = -2
        
        .L2:
            ; now cur2 will always be parent
            ; cur - children
            mov eax, dword[esp+32]
            cmp eax, 0
            je .END
            
            mov eax, dword[esp+32]
            mov eax, dword[eax]
            mov ecx, dword[esp+28]
            mov ecx, dword[ecx]
            mov edx, dword[esp+24]
            
            call compare
                   
            mov dword[esp+24], eax
            
            cmp dword[esp+24], 0
            je .END
            
            mov eax, dword[esp+32]
            mov eax, dword[eax+4]
            mov dword[esp+32], eax ; cur = cur->next
            ; checking next child
            
            cmp dword[esp+32], 0
            je .END
            
            mov eax, dword[esp+32]
            mov eax, dword[eax]
            mov ecx, dword[esp+28]
            mov ecx, dword[ecx]
            mov edx, dword[esp+24]
            
            call compare
            
            mov dword[esp+24], eax
            
            cmp dword[esp+24], 0
            je .END
            
            mov eax, dword[esp+28]
            mov eax, dword[eax+4]
            mov dword[esp+28], eax ; cur2 = cur2->next
            
            mov eax, dword[esp+32]
            mov eax, dword[eax+4]
            mov dword[esp+32], eax ; cur = cur->next
            
            jmp .L2
        .END:
            cmp dword[esp+24], -2
            jne .CONTINUE2
            mov dword[esp+24], 1
            .CONTINUE2:
            
                mov eax, dword[esp+40]
                mov dword[esp], eax
                call fclose
                
                mov dword[esp], output_filename
                mov dword[esp+4], writing_mode
                call fopen
                mov dword[esp+40], eax
                
            
                
                lea eax, [esp+24]
                mov dword[esp], eax
            
                mov dword[esp+4], 4
                mov dword[esp+8], 1
                mov eax, dword[esp+40]
                mov dword[esp+12], eax
                call fwrite
                
                mov eax, dword[esp+40]
                mov dword[esp], eax
                call fclose
                
                .WIN_LAP:
                    cmp dword[esp+36], 0
                    je .RETURN
                    
                    mov eax, dword[esp+36]
                    mov dword[esp], eax
                    mov ecx, dword[eax+4]
                    mov dword[esp+36], ecx
                    call free
                    jmp .WIN_LAP
                    
                    .RETURN:
                        add esp, 56 
                        leave
                        xor eax, eax
                        ret
