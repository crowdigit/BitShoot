    %define __VEC_SRC__
    %include "vec.h"

    extern sqrtf

section .text

vec4dot:
    fld     DWORD [rdi + vec4.x]
    fmul    DWORD [rsi + vec4.x]
    fld     DWORD [rdi + vec4.y]
    fmul    DWORD [rsi + vec4.y]
    fld     DWORD [rdi + vec4.z]
    fmul    DWORD [rsi + vec4.z]
    fld     DWORD [rdi + vec4.w]
    fmul    DWORD [rsi + vec4.w]
    faddp
    faddp
    faddp
    fstp    DWORD [rdx]
    ret

mat4mat4mul:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x30

    mov     QWORD [rbp - 0x20], rdi ; operand 1
    mov     QWORD [rbp - 0x18], rsi ; operand 2
    mov     QWORD [rbp - 0x10], rdx ; result

    mov     rcx, 0
    mov     rbx, 0
    
mat4mat4mul_loop:
    ; store column n(rbx + 1)
    mov     eax, DWORD [rdi + rbx * 0x4 + vec4.size * 0x0]
    mov     DWORD [rbp - 0x30 + vec4.x], eax
    mov     eax, DWORD [rdi + rbx * 0x4 + vec4.size * 0x1]
    mov     DWORD [rbp - 0x30 + vec4.y], eax
    mov     eax, DWORD [rdi + rbx * 0x4 + vec4.size * 0x2]
    mov     DWORD [rbp - 0x30 + vec4.z], eax
    mov     eax, DWORD [rdi + rbx * 0x4 + vec4.size * 0x3]
    mov     DWORD [rbp - 0x30 + vec4.w], eax

    push    rdi
    push    rsi
    push    rdx

    mov     eax, ecx
    mov     r9d, 4
    mul     r9d
    lea     rsi, [rsi + rax * 0x4]          ; row
    lea     rdi, [rbp - 0x30]               ; column

    mov     eax, ecx
    mov     r9d, 0x10
    mul     r9d
    mov     rdx, [rbp - 0x10]
    lea     rdx, [rdx + 0x4 * rbx]
    lea     rdx, [rdx + rax]                ; result address

    call    vec4dot

    pop     rdx
    pop     rsi
    pop     rdi
    
    inc     rcx
    cmp     rcx, 4
    jl      mat4mat4mul_loop

    mov     rcx, 0
    inc     rbx
    cmp     rbx, 4
    jl      mat4mat4mul_loop
    
    leave
    ret

vec3normalize:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x10

    fld     DWORD [rdi + vec3.x]
    fmul    st0
    fld     DWORD [rdi + vec3.y]
    fmul    st0
    fld     DWORD [rdi + vec3.z]
    fmul    st0
    faddp
    faddp

    fstp    DWORD [rbp - 0x10]
    movss   xmm0, DWORD [rbp - 0x10]
    call    sqrtf
    movss   DWORD [rbp - 0x10], xmm0

    fld     DWORD [rdi + vec3.x]
    fld     DWORD [rbp - 0x10]
    fdivp
    fstp    DWORD [rsi + vec3.x]

    fld     DWORD [rdi + vec3.y]
    fld     DWORD [rbp - 0x10]
    fdivp
    fstp    DWORD [rsi + vec3.y]

    fld     DWORD [rdi + vec3.z]
    fld     DWORD [rbp - 0x10]
    fdivp
    fstp    DWORD [rsi + vec3.z]

    leave
    ret

vec3floatmul:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x4

    mov     DWORD [rbp - 0x4], esi
    fld     DWORD [rbp - 0x4]

    fld     DWORD [rdi + vec3.x]
    fmul    st0, st1
    fstp    DWORD [rdx + vec3.x]

    fld     DWORD [rdi + vec3.y]
    fmul    st0, st1
    fstp    DWORD [rdx + vec3.y]

    fld     DWORD [rdi + vec3.z]
    fmul    st0, st1
    fstp    DWORD [rdx + vec3.z]

    fstp    DWORD [rbp - 0x4]

    leave
    ret
