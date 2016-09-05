    %include "gl.asm"

    %define SEEK_SET 0
    %define SEEK_END 2

    extern fopen
    extern fclose
    extern ftell
    extern fseek
    extern fprintf
    extern stderr
    extern malloc
    extern free
    extern fgets
    extern rewind

    global LoadProgram

section .data
    mode:       db "rb", 0
    fail_open:  db "error: Failed to open file ", 34, "%s", 34, 33, 10, 0

    tmp:        db "%s", 10, 0
    extern printf

section .text

LoadProgram:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x40

    mov     QWORD [rbp - 0x8], rdi      ; store vertex shader filename
    mov     QWORD [rbp - 0x10], rsi     ; store fragment shader filename

    ; mov     DWORD [rbp - 0x14], GL_VERTEX_SHADER
    ; mov     DWORD [rbp - 0x18], GL_FRAGMENT_SHADER

    mov     DWORD [rbp - 0x1c], 2       ; open file iteration number

loop_openfile:
    mov     eax, DWORD [rbp - 0x1c]
    mov     rdi, QWORD [rbp + 0x8 * rax - 0x18]

    mov     rsi, mode
    call    fopen
    cmp     rax, 0
    jne     openfile_ok
    
    ; openfile_fail:

    mov     rdi, [stderr]
    mov     rsi, fail_open
    mov     eax, DWORD [rbp - 0x1c]
    mov     rdx, QWORD [rbp + 0x8 * rax - 0x18]
    xor     rax, rax
    call    fprintf
    jmp     openfile_next

openfile_ok:
    mov     QWORD [rbp - 0x24], rax
    mov     rdi, rax
    mov     rsi, 0
    mov     rdx, SEEK_END
    call    fseek

    mov     rdi, QWORD [rbp - 0x24]
    call    ftell
    inc     rax
    mov     rdi, rax
    call    malloc
    mov     QWORD [rbp - 0x2c], rax

    mov     rdi, QWORD [rbp - 0x24]
    mov     rsi, 0
    mov     rdx, SEEK_SET
    call    fseek

    loop_getline:
        mov     rdi, QWORD [rbp - 0x24]
        call    ftell
        add     rax, QWORD [rbp - 0x2c]
        mov     rdi, rax
        mov     rsi, 0xff
        mov     rdx, QWORD [rbp - 0x24]
        call    fgets
        cmp     rax, 0
        jne     loop_getline

    mov     rdi, tmp
    mov     rsi, QWORD [rbp - 0x2c]
    xor     rax, rax
    call    printf

    mov     rdi, QWORD [rbp - 0x2c]
    call    free

    mov     rdi, QWORD [rbp - 0x24]
    call    fclose

openfile_next:

    dec     DWORD [rbp - 0x1c]
    cmp     DWORD [rbp - 0x1c], 0
    jg      loop_openfile

    add     rsp, 0x40
    pop     rbp
    xor     rax, rax
    ret
