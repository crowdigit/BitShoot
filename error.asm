%include "gl.asm"

    extern glGetError
    extern fprintf
    extern stderr

    global eout

section .data
    fmt:        db "Error: %s", 10, 0
    sno:        db "No error", 0
    sen:        db "Invalid enum", 0
    sva:        db "Invalid value", 0
    sop:        db "Invalid operation", 0
    sou:        db "Out of memory", 0
    sfr:        db "Invalid framebuffer operation", 0
    sov:        db "Stack overflow", 0
    sun:        db "Stack underflow", 0
 
section .text

eout:
    push    rbp

    call    [glGetError]

    mov     rdi, [stderr]
    mov     rsi, fmt

    cmp     rax, GL_NO_ERROR
    je      no

    cmp     rax, GL_INVALID_ENUM
    je      enum

    cmp     rax, GL_INVALID_VALUE
    je      value

    cmp     rax, GL_INVALID_OPERATION
    je      operation

    cmp     rax, GL_OUT_OF_MEMORY
    je      mem

    cmp     rax, GL_INVALID_FRAMEBUFFER_OPERATION
    je      frame

    cmp     rax, GL_STACK_OVERFLOW
    je      over

    cmp     rax, GL_STACK_UNDERFLOW
    je      under

no:
    mov     rdx, sno
    jmp     out
enum:
    mov     rdx, sen
    jmp     out
value:
    mov     rdx, sva
    jmp     out
operation:
    mov     rdx, sop
    jmp     out
mem:
    mov     rdx, sou
    jmp     out
frame:
    mov     rdx, sfr
    jmp     out
over:
    mov     rdx, sov
    jmp     out
under:
    mov     rdx, sun

out:
    call    fprintf

    pop     rbp
    xor     rax, rax
    ret
