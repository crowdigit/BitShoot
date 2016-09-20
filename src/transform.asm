    %include "obj.h"

    %define __TRANSFORM_SRC__
    %include "transform.h"

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
    sub     rsp, 0x10
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
    fchs
    fstp    DWORD [rdi + mat4.r3 + vec4.z]
    mov     DWORD [rdi + mat4.r3 + vec4.w], eax

    ; fourth row

    fld     DWORD [right]
    fadd    DWORD [left]
    fld     DWORD [right]
    fsub    DWORD [left]
    fdivp
    fchs
    fstp    DWORD [rdi + mat4.r4 + vec4.x]

    fld     DWORD [top]
    fadd    DWORD [bottom]
    fld     DWORD [top]
    fsub    DWORD [bottom]
    fdivp
    fchs
    fstp    DWORD [rdi + mat4.r4 + vec4.y]

    fld     DWORD [zFar]
    fadd    DWORD [zNear]
    fld     DWORD [zFar]
    fsub    DWORD [zNear]
    fdivp
    fchs
    fstp    DWORD [rdi + mat4.r4 + vec4.z]

    mov     DWORD [rdi + mat4.r4 + vec4.w], __float32__(1.0)

    leave
    ret

translate:
    xor     rax, rax
    mov     DWORD [rdi + mat4.r1 + vec4.x], __float32__(1.0)
    mov     DWORD [rdi + mat4.r1 + vec4.y], eax
    mov     DWORD [rdi + mat4.r1 + vec4.z], eax
    mov     DWORD [rdi + mat4.r1 + vec4.w], eax
    mov     DWORD [rdi + mat4.r2 + vec4.x], eax
    mov     DWORD [rdi + mat4.r2 + vec4.y], __float32__(1.0)
    mov     DWORD [rdi + mat4.r2 + vec4.z], eax
    mov     DWORD [rdi + mat4.r2 + vec4.w], eax
    mov     DWORD [rdi + mat4.r3 + vec4.x], eax
    mov     DWORD [rdi + mat4.r3 + vec4.y], eax
    mov     DWORD [rdi + mat4.r3 + vec4.z], __float32__(1.0)
    mov     DWORD [rdi + mat4.r3 + vec4.w], eax
    mov     eax, DWORD [rsi + vec3.x]
    mov     DWORD [rdi + mat4.r4 + vec4.x], eax
    mov     eax, DWORD [rsi + vec3.y]
    mov     DWORD [rdi + mat4.r4 + vec4.y], eax
    mov     eax, DWORD [rsi + vec3.z]
    mov     DWORD [rdi + mat4.r4 + vec4.z], eax
    mov     DWORD [rdi + mat4.r4 + vec4.w], __float32__(1.0)
    ret
