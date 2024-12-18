extern fopen, fclose, free, calloc, fread, printf

;made by: 2cache

section .rodata
input_filename db "input.bin", 0 ;!
reading_mode db "rb", 0 ;!
writing_format db "%d ", 0

section .text

; eax -- root
bf:
    push ebp
    mov ebp, esp
    sub esp, 24
    
    mov dword[esp+12], eax ; curr addr
    
    mov dword[esp], writing_format
    mov edx, dword[eax]
    mov dword[esp+4], edx
    call printf
    
    mov eax, dword[esp+12]
    cmp dword[eax+4], 0
    je .NO_LEFT_SON
    mov eax, dword[eax+4]
    call bf
    .NO_LEFT_SON:
        mov eax, dword[esp+12]
        cmp dword[eax+8], 0
        je .RETURN
        mov eax, dword[eax+8]
        call bf
    .RETURN:
        add esp, 24
        leave
        ret

global main
main:
    push ebp
    mov ebp, esp
    sub esp, 56
    
    mov dword[esp], input_filename
    mov dword[esp+4], reading_mode
    call fopen
    mov dword[esp+20], eax ; FILE *
    
    mov dword[esp+24], 0 ; counter/n
    
    mov dword[esp], 10000
    mov dword[esp+4], 12
    call calloc
    mov dword[esp+28], eax
    
    
    
    .READ:  
        lea eax, [esp+16] ; contains value
        mov dword[esp], eax
        mov dword[esp+4], 4
        mov dword[esp+8], 1
        mov eax, dword[esp+20]
        mov dword[esp+12], eax
        call fread
        cmp eax, 0
        je .END_READING
        
        mov eax, dword[esp+24]
        mov ecx, 4
        mul ecx
        
        mov ecx, dword[esp+28]
        
        mov edx, dword[esp+16]
        mov dword[ecx + eax], edx ; dword[A+4*i], dword[esp+16]
        
        inc dword[esp+24]
        jmp .READ
        
    .END_READING:
        mov eax, dword[esp+20]
        mov dword[esp], eax
        call fclose
        
        
        mov eax, dword[esp+24]
        mov ecx, 3
        xor edx, edx
        div ecx
        mov dword[esp+24], eax
        
        mov dword[esp], eax
        mov dword[esp+4], 4
        call calloc
        mov dword[esp+32], eax ; addresses of each element
        
        mov eax, dword[esp+24]
        mov dword[esp], eax
        mov dword[esp+4], 4
        call calloc
        mov dword[esp+36], eax ; checker (will be used in finding root)
        
        ; fill addresses
        mov dword[esp+16], 0 ; we will use this free cage as counter
        .FILL_ADDRESSES:
            mov eax, dword[esp+24]
            cmp eax, dword[esp+16]
            je .END_FILLING
            
            mov eax, dword[esp+16]
            mov ecx, dword[esp+16]
            mov eax, 4
            mul ecx

            add eax, dword[esp+32]
            mov dword[esp+12], eax ; stores addr of this element in array
            
            mov dword[esp], 1
            mov dword[esp+4], 12 ; |value|left_son|right_son
            call calloc
            
            mov dword[eax+4], 0
            mov dword[eax+8], 0
            ; no left or\and right sons
            
            mov ecx, dword[esp+16]
            imul ecx, ecx, 4
            imul ecx, ecx, 3;!
            mov edx, dword[esp+28]
            add edx, ecx
            mov edx, dword[edx]
            mov dword[eax], edx
            
            mov ecx, dword[esp+12]
            mov dword[ecx], eax ; every element of array is an address for every element of tree (struct: value, left_son, right_son)
            
            inc dword[esp+16]
            jmp .FILL_ADDRESSES
            
        .END_FILLING:
            mov dword[esp+16], 0 ; we will use this cage as counter
            .FILL_CHECKER:
                mov eax, dword[esp+24]
                cmp eax, dword[esp+16]
                je .END_FILLING_CHECKER
                
                mov ecx, dword[esp+16]
                imul ecx, ecx, 3
                inc ecx
                
                mov edx, dword[esp+28]
                mov eax, dword[edx + ecx*4]
                cmp eax, -1
                je .NO_LEFT_CHILD
                mov ecx, 12
                xor edx, edx
                div ecx
                mov edx, dword[esp+36]
                mov dword[edx+4*eax], 1
                .NO_LEFT_CHILD:
                    
                    mov ecx, dword[esp+16]
                    imul ecx, ecx, 3
                    add ecx, 2
                    mov edx, dword[esp+28]
                    mov eax, dword[edx + ecx*4]
                    cmp eax, -1
                    je .NO_RIGHT_CHILD
                    mov ecx, 12
                    xor edx, edx
                    div ecx
                    mov edx, dword[esp+36]
                    mov dword[edx+4*eax], 1
                    .NO_RIGHT_CHILD:
                        inc dword[esp+16]
                        jmp .FILL_CHECKER
                
            .END_FILLING_CHECKER:
                ; find root
                xor ecx, ecx
                mov edx, dword[esp+36]
                .LOOK_FOR_ROOT:
                    mov eax, dword[edx+4*ecx]
                    cmp eax, 0
                    je .SAVE_ROOT
                    
                    inc ecx
                    jmp .LOOK_FOR_ROOT
                    
                    .SAVE_ROOT:
                        mov eax, dword[esp+32]
                        imul ecx, ecx, 4
                        add eax, ecx
                        mov eax, dword[eax]
                        mov dword[esp+40], eax
    ; preparation is over
    mov dword[esp+16], 0 ; 0-8
    .LINK_CAGES:
    
        mov eax, dword[esp+24]
        mov ecx, 3
        mul ecx
        cmp eax, dword[esp+16]
        je .END_LINKING
        
        xor edx, edx
        mov ecx, 3
        mov eax, dword[esp+16]
        div ecx
        cmp edx, 0
        je .SKIP ; don't watch values of each cage
        
        ; link
        
        ; find right child
        ; link
        
        ;eax -- number of cage
        mov ecx, 4
        mul ecx 
        add eax, dword[esp+32]
        mov eax, dword[eax]
        
        mov dword[esp+12], eax ; parent
        
        
        mov eax, dword[esp+16]
        
        ; if -1 jmp SKIP
        mov ecx, 4
        mul ecx
        add eax, dword[esp+28]
        mov eax, dword[eax]
        
        cmp eax, -1
        je .FIND_RIGHT_CHILD

        ; find left child 
        
        mov ecx, 12
        xor edx, edx
        div ecx
        
        mov ecx, 4
        mul ecx
        
        add eax, dword[esp+32]
        mov eax, dword[eax]
        
        mov edx, dword[esp+12]
        add edx, 4
        mov dword[edx], eax
        
        
        .FIND_RIGHT_CHILD:
            inc dword[esp+16]
            mov eax, dword[esp+16]
        
        ; if -1 jmp SKIP
            mov ecx, 4
            mul ecx
            add eax, dword[esp+28]
            mov eax, dword[eax]
        
            cmp eax, -1
            je .SKIP
            
            mov ecx, 12
            xor edx, edx
            div ecx
        
            mov ecx, 4
            mul ecx
        
            add eax, dword[esp+32]
            mov eax, dword[eax]
        
            mov edx, dword[esp+12]
            add edx, 8
            mov dword[edx], eax
            
        .SKIP:
            inc dword[esp+16]
            jmp .LINK_CAGES
        
          
    .END_LINKING:
        ; start printing
        mov eax, dword[esp+40]
        call bf
    
    mov eax, dword[esp+36]
    mov dword[esp], eax
    call free
    
    mov eax, dword[esp+28]
    mov dword[esp], eax
    call free
    
    mov dword[esp+4], 0
    .FREE_ADDRESSES:
        mov ecx, dword[esp+4]
        cmp ecx, dword[esp+24]
        je .END_WORK
        mov eax, dword[esp+32]
        mov eax, dword[eax + ecx*4]
        mov dword[esp], eax
        call free
        inc dword[esp+4]
        jmp .FREE_ADDRESSES
        
    .END_WORK:
        add esp, 56
        leave
        xor eax, eax
        ret
