%define __TEX_SRC__
%include "tex.h"

%include "sdl.h"

extern printf

section .data
    fmt:    db "IMG_Load: %s", 10, 0
    err:    db "%d", 10, 0

section .text

LoadTexture:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x20

    ; rdi -> Filename

    mov     DWORD [rbp - 0xc], 0

    mov     QWORD [rbp - 0x8], rdi
    call    IMG_Load
    cmp     rax, 0
    jne     load_succ

    call    SDL_GetError
    mov     rsi, rax
    mov     rdi, fmt
    xor     rax, rax
    call    printf
    jmp     quit

load_succ:

    mov     QWORD [rbp - 0x14], rax

    mov     rdi, 1
    lea     rsi, [rbp - 0xc]
    call    [glGenTextures]

    mov     rdi, GL_TEXTURE_2D
    mov     esi, DWORD [rbp - 0xc]
    call    [glBindTexture]

    mov     rdi, GL_TEXTURE_2D
    xor     rsi, rsi
    mov     rdx, GL_RGBA
    mov     rax, QWORD [rbp - 0x14]
    mov     ecx, DWORD [rax + Surface.w]
    mov     r8d, DWORD [rax + Surface.h]
    xor     r9d, r9d
    push    QWORD [rax + Surface.pixels]
    push    GL_UNSIGNED_BYTE
    push    GL_RGBA
    call    [glTexImage2D]
    add     rsp, 0x18

    mov     rdi, GL_TEXTURE_2D
    mov     rsi, GL_TEXTURE_MAG_FILTER
    mov     rdx, GL_NEAREST
    call    [glTexParameteri]

    mov     rdi, GL_TEXTURE_2D
    mov     rsi, GL_TEXTURE_MIN_FILTER
    mov     rdx, GL_NEAREST
    call    [glTexParameteri]

    mov     rdi, QWORD [rbp - 0x14]
    call    SDL_FreeSurface

    mov     rdi, GL_TEXTURE_2D
    xor     esi, esi
    call    [glBindTexture]

quit:
    mov     rax, [rbp - 0xc]
    leave
    ret
