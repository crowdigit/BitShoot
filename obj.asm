    %include "gl.asm"

    global init_obj
    global init_square
    global release_square
    global square_vao
    global square_vbo
    global render

    extern ortho

STRUC vec3
    .x:     resd 1
    .y:     resd 1
    .z:     resd 1
    .size:
ENDSTRUC

STRUC vec4
    .x:     resd 1
    .y:     resd 1
    .z:     resd 1
    .w:     resd 1
    .size:
ENDSTRUC

STRUC mat4
    .r1:    resb vec4.size
    .r2:    resb vec4.size
    .r3:    resb vec4.size
    .r4:    resb vec4.size
    .size:
ENDSTRUC

STRUC obj
    .pos:   resb vec3.size
    .vao:   resd 1
    .vbo:   resd 1
    .size:
ENDSTRUC

section .data
    square_vao:  dd 0d0
    square_vbo:  dd 0d0
    modelName:      db "Model", 0

section .text

init_square:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x48

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

    mov     rdi, 0
    mov     rsi, 3
    mov     rdx, GL_FLOAT
    xor     rcx, rcx
    mov     r8, 12
    xor     r9, r9
    call    [glVertexAttribPointer]

    xor     rdi, rdi
    call    [glBindVertexArray]

    mov     rdi, GL_ARRAY_BUFFER
    xor     rsi, rsi
    call    [glBindBuffer]

    add     rsp, 0x48
    pop     rbp
    xor     rax, rax
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
    sub     rsp, 0x50

    mov     QWORD [rbp - 0x8], rdi

    ; Get current program
    mov     edi, GL_CURRENT_PROGRAM
    lea     rsi, [rbp - 0x10]
    call    [glGetIntegerv]

    ; Get Model matrix's location
    mov     edi, DWORD [rbp - 0x10]
    mov     rsi, modelName
    call    [glGetUniformLocation]
    mov     DWORD [rbp - 0xc], eax

    lea     rdi, [rbp - 0x50]
    call    ortho

    mov     edi, DWORD [square_vao]
    call    [glBindVertexArray]

    xor     rdi, rdi
    call    [glEnableVertexAttribArray]
    
    mov     edi, GL_ARRAY_BUFFER
    mov     esi, DWORD [square_vbo]
    call    [glBindBuffer]

    mov     edi, [rbp - 0xc]
    mov     esi, 1
    mov     rdx, 1
    lea     rcx, [rbp - 0x50]
    call    [glUniformMatrix4fv]

    mov     edi, GL_TRIANGLES
    xor     rsi, rsi
    mov     edx, 12
    call    [glDrawArrays]

    xor     rdi, rdi
    call    [glDisableVertexAttribArray]

    xor     rdi, rdi
    call    [glBindVertexArray]

    add     rsp, 0x50
    pop     rbp
    ret
