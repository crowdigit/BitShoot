    %include "obj.h"

    global ortho

section .data
    left:   dd -66.6667
    right:  dd 66.6667
    top:    dd 50.0
    bottom: dd -50.0
    zNear:  dd 0.0
    zFar:   dd 10.0

section .text

ortho:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x8

    mov     DWORD [rbp - 0x4], 0x2

    xor     rax, rax

    ; first row

    fild    DWORD [rbp - 0x4]
    fld     DWORD [right]
    fsub    DWORD [left]
    fdivp
    fstp    DWORD [rdi + mat4.r1 + vec4.x]
    mov     DWORD [rdi + mat4.r1 + vec4.y], eax
    mov     DWORD [rdi + mat4.r1 + vec4.z], eax
    mov     DWORD [rdi + mat4.r1 + vec4.w], eax

    ; second row

    mov     DWORD [rdi + mat4.r2 + vec4.x], eax
    fild    DWORD [rbp - 0x4]
    fld     DWORD [top]
    fsub    DWORD [bottom]
    fdivp
    fstp    DWORD [rdi + mat4.r2 + vec4.y]
    mov     DWORD [rdi + mat4.r2 + vec4.z], eax
    mov     DWORD [rdi + mat4.r2 + vec4.w], eax

    ; third row

    mov     DWORD [rdi + mat4.r3 + vec4.x], eax
    mov     DWORD [rdi + mat4.r3 + vec4.y], eax
    fild    DWORD [rbp - 0x4]
    fld     DWORD [zFar]
    fsub    DWORD [zNear]
    fdivp
    fstp    DWORD [rdi + mat4.r3 + vec4.z]
    mov     DWORD [rdi + mat4.r3 + vec4.w], eax

    ; fourth row

    fld     DWORD [right]
    fadd    DWORD [left]
    fld     DWORD [right]
    fsub    DWORD [left]
    fdivp
    fstp    DWORD [rdi + mat4.r4 + vec4.x]
    neg     DWORD [rdi + mat4.r4 + vec4.x]

    fld     DWORD [top]
    fadd    DWORD [bottom]
    fld     DWORD [top]
    fsub    DWORD [bottom]
    fdivp
    fstp    DWORD [rdi + mat4.r4 + vec4.y]
    neg     DWORD [rdi + mat4.r4 + vec4.y]

    fld     DWORD [zFar]
    fadd    DWORD [zNear]
    fld     DWORD [zFar]
    fsub    DWORD [zNear]
    fdivp
    fstp    DWORD [rdi + mat4.r4 + vec4.z]
    neg     DWORD [rdi + mat4.r4 + vec4.z]

    mov     DWORD [rdi + mat4.r4 + vec4.w], __float32__(1.0)

    add     rsp, 0x8
    pop     rbp
    xor     rax, rax
    ret

mat4mat4mul:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x20

    mov     QWORD [rbp - 0x20], rdi
    mov     QWORD [rbp - 0x18], rsi
    mov     QWORD [rbp - 0x10], rdx

    

    add     rsp, 0x20
    pop     rbp
    ret
