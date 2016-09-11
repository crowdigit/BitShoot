    %include "gl.h"

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

    extern err

    global LoadProgram

section .data
    mode:       db "rb", 0
    fail_open:  db "error: Failed to open file ", 34, "%s", 34, 33, 10, 0

section .text

LoadProgram:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x40

    mov     QWORD [rbp - 0x8], rdi      ; store vertex shader filename
    mov     QWORD [rbp - 0x10], rsi     ; store fragment shader filename

    call    [glCreateProgram]
    mov     DWORD [rbp - 0x14], eax

    mov     rdi, GL_VERTEX_SHADER
    call    [glCreateShader]
    mov     DWORD [rbp - 0x18], eax

    mov     rdi, GL_FRAGMENT_SHADER
    call    [glCreateShader]
    mov     DWORD [rbp - 0x1c], eax

    mov     DWORD [rbp - 0x20], 2       ; open file iteration number

loop_openfile:
    mov     eax, DWORD [rbp - 0x20]
    mov     rdi, QWORD [rbp + 0x8 * rax - 0x18]

    mov     rsi, mode
    call    fopen
    cmp     rax, 0
    jne     openfile_ok
    
    ; openfile_fail:

    mov     rdi, [stderr]
    mov     rsi, fail_open
    mov     eax, DWORD [rbp - 0x20]
    mov     rdx, QWORD [rbp + 0x8 * rax - 0x18]
    xor     rax, rax
    call    fprintf
    jmp     openfile_next

openfile_ok:
    mov     QWORD [rbp - 0x28], rax
    mov     rdi, rax
    mov     rsi, 0
    mov     rdx, SEEK_END
    call    fseek

    mov     rdi, QWORD [rbp - 0x28]
    call    ftell
    inc     rax
    mov     rdi, rax
    call    malloc
    mov     QWORD [rbp - 0x30], rax

    mov     rdi, QWORD [rbp - 0x28]
    mov     rsi, 0
    mov     rdx, SEEK_SET
    call    fseek

    loop_getline:
        mov     rdi, QWORD [rbp - 0x28]
        call    ftell
        add     rax, QWORD [rbp - 0x30]
        mov     rdi, rax
        mov     rsi, 0xff
        mov     rdx, QWORD [rbp - 0x28]
        call    fgets
        cmp     rax, 0
        jne     loop_getline

    ; glShaderSource

    mov     rdi, QWORD [rbp - 0x28]
    call    ftell
    inc     rax
    mov     DWORD [rbp - 0x34], eax

    mov     eax, DWORD [rbp - 0x20]
    mov     edi, DWORD [rbp + 0x4 * rax - 0x20]
    mov     DWORD [rbp - 0x38], edi
    mov     rsi, 1
    lea     rdx, [rbp - 0x30]
    lea     rcx, [rbp - 0x34]
    call    [glShaderSource]

    mov     edi, DWORD [rbp - 0x38]
    call    [glCompileShader]

    mov     edi, DWORD [rbp - 0x38]
    mov     rsi, GL_COMPILE_STATUS
    lea     rdx, [rbp - 0x3c]
    call    [glGetShaderiv]
    cmp     DWORD [rbp - 0x3c], 1
    je      compile_ok

    ; If compiling failed

    mov     edi, DWORD [rbp - 0x38]
    mov     rsi, GL_INFO_LOG_LENGTH
    lea     rdx, [rbp - 0x3c]
    call    [glGetShaderiv]

    mov     rdi, QWORD [rbp - 0x30]
    call    free

    mov     edi, DWORD [rbp - 0x3c]
    call    malloc
    mov     QWORD [rbp - 0x30], rax

    mov     rcx, rax
    mov     edi, DWORD [rbp - 0x38]
    mov     esi, DWORD [rbp - 0x3c]
    xor     rdx, rdx
    call    [glGetShaderInfoLog]

    mov     rdi, [stderr]
    mov     rsi, err
    mov     rdx, QWORD [rbp - 0x30]
    xor     rax, rax
    call    fprintf

    mov     rdi, QWORD [rbp - 0x30]
    call    free

    mov     rdi, QWORD [rbp - 0x28]
    call    fclose

    jmp     openfile_next

compile_ok:

    mov     rdi, QWORD [rbp - 0x30]
    call    free

    mov     rdi, QWORD [rbp - 0x28]
    call    fclose

    mov     edi, DWORD [rbp - 0x14]
    mov     esi, DWORD [rbp - 0x38]
    call    [glAttachShader]

openfile_next:

    dec     DWORD [rbp - 0x20]
    cmp     DWORD [rbp - 0x20], 0
    jg      loop_openfile

    mov     edi, DWORD [rbp - 0x14]
    call    [glLinkProgram]

    mov     edi, DWORD [rbp - 0x14]
    mov     rsi, GL_LINK_STATUS
    lea     rdx, [rbp - 0x3c]
    call    [glGetProgramiv]
    cmp     DWORD [rbp - 0x3c], 1
    je      link_ok

    mov     edi, DWORD [rbp - 0x14]
    mov     rsi, GL_INFO_LOG_LENGTH
    lea     rdx, [rbp - 0x3c]
    call    [glGetProgramiv]

    mov     edi, DWORD [rbp - 0x3c]
    call    malloc
    mov     QWORD [rbp - 0x30], rax

    mov     rcx, rax
    mov     edi, DWORD [rbp - 0x14]
    mov     esi, DWORD [rbp - 0x3c]
    xor     rdx, rdx
    call    [glGetProgramInfoLog]

    mov     rdi, [stderr]
    mov     rsi, err
    mov     rdx, QWORD [rbp - 0x30]
    xor     rax, rax
    call    fprintf

    mov     rdi, QWORD [rbp - 0x30]
    call    free
    
link_ok:

    mov     DWORD [rbp - 0x38], 2
loop_release:
    mov     eax, DWORD [rbp - 0x38]
    mov     edi, DWORD [rbp - 0x14]
    mov     esi, DWORD [rbp + 0x4 * rax - 0x20]
    call    [glDetachShader]
    mov     eax, DWORD [rbp - 0x38]
    mov     edi, DWORD [rbp + 0x4 * rax - 0x20]
    call    [glDeleteShader]
    dec     DWORD [rbp - 0x38]
    cmp     DWORD [rbp - 0x38], 0
    jg      loop_release

    mov     eax, DWORD [rbp - 0x14]
    add     rsp, 0x40
    pop     rbp
    ret
