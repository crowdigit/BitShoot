global main

extern vec4dot
extern printf
extern mat4mat4mul

section .data
    fmt:    db "%5f%5f%5f%5f", 10, 0

section .text

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0xc8

    mov     DWORD [rbp - 0x80], __float32__(1.0)
    mov     DWORD [rbp - 0x7c], __float32__(4.0)
    mov     DWORD [rbp - 0x78], __float32__(2.0)
    mov     DWORD [rbp - 0x74], __float32__(1.0)
    mov     DWORD [rbp - 0x70], __float32__(2.0)
    mov     DWORD [rbp - 0x6c], __float32__(4.0)
    mov     DWORD [rbp - 0x68], __float32__(3.0)
    mov     DWORD [rbp - 0x64], __float32__(2.0)
    mov     DWORD [rbp - 0x60], __float32__(3.0)
    mov     DWORD [rbp - 0x5c], __float32__(4.0)
    mov     DWORD [rbp - 0x58], __float32__(5.0)
    mov     DWORD [rbp - 0x54], __float32__(3.0)
    mov     DWORD [rbp - 0x50], __float32__(4.0)
    mov     DWORD [rbp - 0x4c], __float32__(4.0)
    mov     DWORD [rbp - 0x48], __float32__(5.0)
    mov     DWORD [rbp - 0x44], __float32__(1.0)

    mov     DWORD [rbp - 0x40], __float32__(3.0)
    mov     DWORD [rbp - 0x3c], __float32__(3.0)
    mov     DWORD [rbp - 0x38], __float32__(-1.0)
    mov     DWORD [rbp - 0x34], __float32__(1.0)
    mov     DWORD [rbp - 0x30], __float32__(4.0)
    mov     DWORD [rbp - 0x2c], __float32__(4.0)
    mov     DWORD [rbp - 0x28], __float32__(3.0)
    mov     DWORD [rbp - 0x24], __float32__(1.0)
    mov     DWORD [rbp - 0x20], __float32__(5.0)
    mov     DWORD [rbp - 0x1c], __float32__(1.0)
    mov     DWORD [rbp - 0x18], __float32__(-3.0)
    mov     DWORD [rbp - 0x14], __float32__(2.0)
    mov     DWORD [rbp - 0x10], __float32__(2.0)
    mov     DWORD [rbp - 0xc], __float32__(3.0)
    mov     DWORD [rbp - 0x8], __float32__(-5.0)
    mov     DWORD [rbp - 0x4], __float32__(3.0)

    lea     rdi, [rbp - 0x80]
    lea     rsi, [rbp - 0x40]
    lea     rdx, [rbp - 0xc0]
    call    mat4mat4mul

    add     rsp, 0xc8
    pop     rbp
    xor     rax, rax
    ret
