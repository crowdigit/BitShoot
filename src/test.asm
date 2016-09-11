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
    sub     rsp, 0x50

    mov     DWORD [rbp - 0x50 + vec3.x], __float32__(1.0)
    mov     DWORD [rbp - 0x50 + vec3.y], __float32__(1.0)
    mov     DWORD [rbp - 0x50 + vec3.z], __float32__(1.0)

    lea     rdi, [rbp - 0x40]
    lea     rsi, [rbp - 0x50]
    tmp:
    call    translate

    add     rsp, 0x50
    pop     rbp
    xor     rax, rax
    ret
