    %include "gl.h"
    %include "vec.h"
    %include "transform.h"

    %define __OBJ_SRC__
    %include "obj.h"

    extern ortho
    extern printf

section .data
    square_vao: dd 0d0
    square_vbo: dd 0d0

    modelName:  db "Model", 0
    projName:   db "Proj", 0

    modelLoc:   dd 0d0
    projLoc:    dd 0d0

    err:        dd "%d", 10, 0

section .text

init_square:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x78

    mov     DWORD [rbp - 0x48], __float32__(-0.5)
    mov     DWORD [rbp - 0x44], __float32__(-0.5)
    mov     DWORD [rbp - 0x40], __float32__(0.0)

    mov     DWORD [rbp - 0x3c], __float32__(-0.5)
    mov     DWORD [rbp - 0x38], __float32__(0.5)
    mov     DWORD [rbp - 0x34], __float32__(0.0)

    mov     DWORD [rbp - 0x30], __float32__(0.5)
    mov     DWORD [rbp - 0x2c], __float32__(-0.5)
    mov     DWORD [rbp - 0x28], __float32__(0.0)

    mov     DWORD [rbp - 0x24], __float32__(0.5)
    mov     DWORD [rbp - 0x20], __float32__(0.5)
    mov     DWORD [rbp - 0x1c], __float32__(0.0)

    mov     DWORD [rbp - 0x18], __float32__(-0.5)
    mov     DWORD [rbp - 0x14], __float32__(0.5)
    mov     DWORD [rbp - 0x10], __float32__(0.0)

    mov     DWORD [rbp - 0xc], __float32__(0.5)
    mov     DWORD [rbp - 0x8], __float32__(-0.5)
    mov     DWORD [rbp - 0x4], __float32__(0.0)

    mov     DWORD [rbp - 0x78], __float32__(0.0)
    mov     DWORD [rbp - 0x74], __float32__(0.0)

    mov     DWORD [rbp - 0x70], __float32__(0.0)
    mov     DWORD [rbp - 0x6c], __float32__(1.0)

    mov     DWORD [rbp - 0x68], __float32__(1.0)
    mov     DWORD [rbp - 0x64], __float32__(0.0)

    mov     DWORD [rbp - 0x60], __float32__(1.0)
    mov     DWORD [rbp - 0x5c], __float32__(1.0)

    mov     DWORD [rbp - 0x58], __float32__(0.0)
    mov     DWORD [rbp - 0x54], __float32__(1.0)

    mov     DWORD [rbp - 0x50], __float32__(1.0)
    mov     DWORD [rbp - 0x4c], __float32__(0.0)

    mov     edi, 1
    mov     rsi, square_vao
    call    [glGenVertexArrays]

    mov     edi, DWORD [square_vao]
    call    [glBindVertexArray]

    mov     rdi, 1
    mov     rsi, square_vbo
    call    [glGenBuffers]

    mov     rdi, GL_ARRAY_BUFFER
    mov     esi, DWORD [square_vbo]
    call    [glBindBuffer]

    mov     rdi, GL_ARRAY_BUFFER
    mov     rsi, 0d72
    lea     rdx, [rbp - 0x48]
    mov     rcx, GL_STATIC_DRAW
    call    [glBufferData]

    mov     rdi, GL_ARRAY_BUFFER
    mov     rsi, 0d72
    mov     rdx, 0d48
    lea     rcx, [rbp - 0x78]
    call    [glBufferSubData]

    call    [glGetError]
    mov     rsi, rax
    mov     rdi, err
    xor     rax, rax
    call    printf

    mov     rdi, 0
    mov     rsi, 3
    mov     rdx, GL_FLOAT
    xor     rcx, rcx
    mov     r8, 12
    xor     r9, r9
    call    [glVertexAttribPointer]

    mov     rdi, 1
    mov     rsi, 2
    mov     rdx, GL_FLOAT
    xor     rcx, rcx
    mov     r8, 8
    mov     r9, 0d72
    call    [glVertexAttribPointer]

    xor     rdi, rdi
    call    [glBindVertexArray]

    mov     rdi, GL_ARRAY_BUFFER
    xor     rsi, rsi
    call    [glBindBuffer]

    xor     rax, rax
    leave
    ret

release_square:
    mov     rdi, 1
    mov     rsi, square_vbo
    call    [glDeleteBuffers]

    mov     rdi, 1
    mov     rsi, square_vao
    call    [glDeleteVertexArrays]
    ret

render:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0xd0

    mov     QWORD [rbp - 0x8], rdi          ; rbp - 0x8 -> Object pointer

    ; Get current program
    mov     edi, GL_CURRENT_PROGRAM
    lea     rsi, [rbp - 0x10]               ; rbp - 0x10-> Program ID
    call    [glGetIntegerv]

    ; Get Model matrix's location
    mov     edi, DWORD [rbp - 0x10]
    mov     rsi, modelName
    call    [glGetUniformLocation]
    mov     DWORD [modelLoc], eax

    ; Get Projection matrix's location
    mov     edi, DWORD [rbp - 0x10]
    mov     rsi, projName
    call    [glGetUniformLocation]
    mov     DWORD [projLoc], eax

    lea     rdi, [rbp - 0x50]
    mov     rsi, [rbp - 0x8]
    call    translate

    lea     rdi, [rbp - 0x90]
    call    ortho

    ; lea     rdi, [rbp - 0x90]
    ; lea     rsi, [rbp - 0x50]
    ; lea     rdx, [rbp - 0xd0]
    ; call    mat4mat4mul

    mov     edi, DWORD [square_vao]
    call    [glBindVertexArray]

    xor     rdi, rdi
    call    [glEnableVertexAttribArray]

    mov     rdi, 1
    call    [glEnableVertexAttribArray]
    
    mov     edi, GL_ARRAY_BUFFER
    mov     esi, DWORD [square_vbo]
    call    [glBindBuffer]

    ; mov     edi, [rbp - 0xd4]
    ; mov     esi, 1
    ; xor     rdx, rdx
    ; lea     rcx, [rbp - 0xd0]
    ; call    [glUniformMatrix4fv]

    mov     edi, [modelLoc]
    mov     esi, 1
    xor     rdx, rdx
    lea     rcx, [rbp - 0x50]
    call    [glUniformMatrix4fv]

    mov     edi, [projLoc]
    mov     esi, 1
    xor     rdx, rdx
    lea     rcx, [rbp - 0x90]
    call    [glUniformMatrix4fv]

    mov     edi, GL_TRIANGLES
    xor     rsi, rsi
    mov     edx, 12
    call    [glDrawArrays]

    xor     rdi, rdi
    call    [glDisableVertexAttribArray]

    mov     rdi, 1
    call    [glDisableVertexAttribArray]

    xor     rdi, rdi
    call    [glBindVertexArray]

    leave
    ret
