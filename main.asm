    %include "sdl.asm"

    extern loop
    extern LoadProgram

    extern glXGetProcAddress

    global main
    global window
    global glClear
    global glClearColor
    global glCreateProgram
    global glCreateShader
    global glDetachShader
    global glDeleteShader
    global glDeleteProgram
    global glShaderSource
    global glCompileShader
    global glGetShaderiv

    global err

section .data
    err:        db "error: %s", 10, 0
    title:      db "Hello Assembly!", 0
    window:     dq 0x0
    context:    dq 0x0
    program:    dd 0d0

    vert:       db "vert.glsl", 0
    frag:       db "frag.glsl", 0

    glClear:                dq 0x0
    fnClear:                db "glClear", 0
    glClearColor:           dq 0x0
    fnClearColor:           db "glClearColor", 0
    glCreateProgram:        dq 0x0
    fnCreateProgram:        db "glCreateProgram", 0
    glDeleteProgram:        dq 0x0
    fnDeleteProgram:        db "glDeleteProgram", 0
    glCreateShader:         dq 0x0
    fnCreateShader:         db "glCreateShader", 0
    glDeleteShader:         dq 0x0
    fnDeleteShader:         db "glDeleteShader", 0
    glAttachShader:         dq 0x0
    fnAttachShader:         db "glAttachShader", 0
    glDetachShader:         dq 0x0
    fnDetachShader:         db "glDetachShader", 0
    glShaderSource:         dq 0x0
    fnShaderSource:         db "glShaderSource", 0
    glCompileShader:        dq 0x0
    fnCompileShader:        db "glCompileShader", 0
    glGetShaderiv:          dq 0x0
    fnGetShaderiv:          db "glGetShaderiv", 0
    glGetShaderInfoLog:     dq 0x0
    fnGetShaderInfoLog:     db "glGetShaderInfoLog", 0
    
section .text

main:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x10

    ;   Initializing: SDL2
    mov     rdi, SDL_INIT_EVERYTHING
    call    SDL_Init
    cmp     rax, 0
    jne     fail

    ;   Creating window
    mov     rdi, title
    mov     rsi, SDL_WINDOWPOS_CENTERED
    mov     rdx, SDL_WINDOWPOS_CENTERED
    mov     rcx, 640
    mov     r8, 480
    mov     r9, SDL_WINDOW_SHOWN
    or      r9, SDL_WINDOW_OPENGL
    call    SDL_CreateWindow

    cmp     rax, 0
    je      fail
    mov     QWORD [window], rax

    ;   Creating context

    mov     rdi, rax
    call    SDL_GL_CreateContext
    
    cmp     rax, 0
    je      fail
    mov     QWORD [context], rax

    call    glInit

    mov     rdi, vert
    mov     rsi, frag
    call    LoadProgram
    mov     DWORD [rbp - 0x4], eax

    call    loop

    mov     edi, DWORD [rbp - 0x4]
    call    [glDeleteProgram]

    jmp     release

fail:
    call    SDL_GetError
    mov     rsi, rax
    mov     rdi, err
    xor     rax, rax
    call    printf

release:

    ;   Destroying context
    mov     rdi, QWORD [context]
    call    SDL_GL_DeleteContext

    ;   Destroying Window
    mov     rdi, QWORD [window]
    call    SDL_DestroyWindow

    ;   Releasing
    call    SDL_Quit
    jmp     quit

quit:
    add     rsp, 0x10
    pop     rbp
    xor     rax, rax
    ret

glInit:
    mov     rdi, fnClear
    call    glXGetProcAddress
    mov     QWORD [glClear], rax

    mov     rdi, fnClearColor
    call    glXGetProcAddress
    mov     QWORD [glClearColor], rax

    mov     rdi, fnCreateProgram
    call    glXGetProcAddress
    mov     QWORD [glCreateProgram], rax

    mov     rdi, fnDeleteProgram
    call    glXGetProcAddress
    mov     QWORD [glDeleteProgram], rax

    mov     rdi, fnClearColor
    call    glXGetProcAddress
    mov     QWORD [glClearColor], rax

    mov     rdi, fnCreateShader
    call    glXGetProcAddress
    mov     QWORD [glCreateShader], rax

    mov     rdi, fnDeleteShader
    call    glXGetProcAddress
    mov     QWORD [glDeleteShader], rax

    mov     rdi, fnAttachShader
    call    glXGetProcAddress
    mov     QWORD [glAttachShader], rax
    
    mov     rdi, fnDetachShader
    call    glXGetProcAddress
    mov     QWORD [glDetachShader], rax

    mov     rdi, fnShaderSource
    call    glXGetProcAddress
    mov     QWORD [glShaderSource], rax

    mov     rdi, fnCompileShader
    call    glXGetProcAddress
    mov     QWORD [glCompileShader], rax

    mov     rdi, fnGetShaderiv
    call    glXGetProcAddress
    mov     QWORD [glGetShaderiv], rax

    mov     rdi, fnGetShaderInfoLog
    call    glXGetProcAddress
    mov     QWORD [glGetShaderInfoLog], rax

    ret
