%include "transform.h"
%include "vec.h"

global main

section .data
section .text

%ifdef TEST
main:
%endif
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x20

    mov     DWORD [rbp - 0xc], __float32__(1.0)
    mov     DWORD [rbp - 0x8], __float32__(2.0)
    mov     DWORD [rbp - 0x4], __float32__(3.0)

    lea     rdi, [rbp - 0xc]
    lea     rsi, [rbp - 0x18]
    call    vec3normalize

    leave
    xor     rax, rax
    ret
