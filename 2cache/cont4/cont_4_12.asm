extern io_get_dec, io_print_dec

;made by: 2cache

section .bss
x1 resd 1
y1 resd 1

x2 resd 1
y2 resd 1

x3 resd 1
y3 resd 1

double_S resd 1 ; 
E resd 1; EDGE


section .text

s:
    push ebp
    mov ebp, esp
    mov eax, dword[x1]
    sub eax, dword[x2]
    mov ecx, dword[y1]
    add ecx, dword[y2]
    cdq
    imul ecx
    
    push 0
    mov dword[ebp-4], eax ; first summand
    
    mov eax, dword[x2]
    sub eax, dword[x3]
    mov ecx, dword[y2]
    add ecx, dword[y3]
    cdq
    imul ecx
    
    add dword[ebp-4], eax ; 1 + 2
    
    mov eax, dword[x3]
    sub eax, dword[x1]
    mov ecx, dword[y3]
    add ecx, dword[y1]
    cdq
    imul ecx
    
    add dword[ebp-4], eax; 1 + 2 + 3
    mov eax, dword[ebp-4]
    mov dword[ebp-4], eax
    cmp dword[ebp-4], 0
    jge .NOT_NEGATIVE
    neg dword[ebp-4]
    .NOT_NEGATIVE:
        pop eax
        leave
        ret
    
GCD:
    push ebp
    mov ebp, esp
    L:
        cmp dword[ebp+8], 0
        je .EXIT
        cmp dword[ebp+12], 0
        je .EXIT
  
        .NEXT:      
        mov eax, dword[ebp+8] ; a
        cmp eax, dword[ebp+12]
        jng .ELSE
        mov eax, dword[ebp+8]
        mov ecx, dword[ebp+12]
        xor edx, edx 
        div ecx
        mov dword[ebp+8], edx
        jmp L        
        .ELSE:
            mov eax, dword[ebp+12]
            mov ecx, dword[ebp+8]
            xor edx, edx
            div ecx
            mov dword[ebp+12], edx
            jmp L
            
     .EXIT:
        mov eax, dword[ebp+8]
        add eax, dword[ebp+12]
        inc eax        
        leave 
        ret

edge_point_counter:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp+12]
    sub eax, dword[ebp+20]
    cmp eax, 0
    jge .NOT_NEG
    neg eax
    .NOT_NEG:
        push eax
    
    mov eax, dword[ebp+8]
    sub eax, dword[ebp+16]
    cmp eax, 0
    jge .NOT_NEG2
    neg eax
    .NOT_NEG2:
        push eax
        call GCD
        add esp, 8 ; 2 parameters
        leave 
        ret
    
    
    

global main
main:
    mov ebp, esp; for correct debugging
    call io_get_dec
    mov dword[x1], eax
    call io_get_dec
    mov dword[y1], eax
    
    call io_get_dec
    mov dword[x2], eax
    call io_get_dec
    mov dword[y2], eax
    
    call io_get_dec
    mov dword[x3], eax
    call io_get_dec
    mov dword[y3], eax
    
    push dword[y3]
    push dword[x3]
    push dword[y2]
    push dword[x2]
    push dword[y1]
    push dword[x1]
    call s
    pop dword[x1]
    pop dword[y1]
    pop dword[x2]
    pop dword[y2]
    pop dword[x3]
    pop dword[y3]
    mov dword[double_S], eax
    ;call io_print_dec
    
    
    push dword[y2]
    push dword[x2]
    push dword[y1]
    push dword[x1]
    call edge_point_counter
    pop dword[x1]
    pop dword[y1]
    pop dword[x2]
    pop dword[y2]
    mov dword[E], eax
    
    push dword[y3]
    push dword[x3]
    push dword[y1]
    push dword[x1]
    call edge_point_counter
    pop dword[x1]
    pop dword[y1]
    pop dword[x3]
    pop dword[y3]
    add dword[E], eax
    
    push dword[y3]
    push dword[x3]
    push dword[y2]
    push dword[x2]
    call edge_point_counter
    pop dword[x2]
    pop dword[y2]
    pop dword[x3]
    pop dword[y3]
    add dword[E], eax
    sub dword[E], 3 ; each peak count twice
    
    ; eax has Edge points
    mov eax, dword[E]
    neg eax
    add eax, dword[double_S]
    add eax, 2
    mov ecx, 2
    xor edx, edx    
    div ecx
    
    call io_print_dec
    
    
    
    xor eax, eax
    ret
