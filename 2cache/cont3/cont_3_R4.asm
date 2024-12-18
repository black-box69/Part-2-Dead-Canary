extern io_get_udec, io_print_udec, io_newline

;made by: 2cache

section .data
    mask    dd      0xffff, 0xff00ff, 0xf0f0f0f, 0x33333333, 0x55555555

section .text
global main
main:
    mov ebp, esp; for correct debugging
    call   io_get_udec
    mov    ebx, mask
    add    ebx, 16
    mov    ecx, 1
.label:
    mov    esi, dword [ebx]
    mov    edi, esi
    not    edi
    mov    edx, eax
    and    eax, esi
    and    edx, edi
    shl    eax, cl
    shr    edx, cl
    or     eax, edx
    shl    ecx, 1
    sub    ebx, 4
    cmp    ebx, mask - 4
    jne    .label

    call   io_print_udec
    call   io_newline
    xor    eax, eax
    ret
