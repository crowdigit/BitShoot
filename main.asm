    %include "sdl.asm"
    %define GL_CURRENT_PROGRAM                0x8B8D

    extern loop
    extern LoadProgram
    extern init_obj
    extern init_square
    extern release_square

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
    global glGetShaderInfoLog
    global glAttachShader
    global glLinkProgram
    global glGetProgramiv
    global glGetProgramInfoLog
    global glUseProgram
    global glGenBuffers
    global glBindBuffer
    global glBufferData
    global glDeleteBuffers
    global glGenVertexArrays
    global glBindVertexArray
    global glDeleteVertexArrays
    global glVertexAttribPointer
    global glEnableVertexAttribArray
    global glDisableVertexAttribArray
    global glDrawArrays
    global glGetError
    global glGetIntegerv
    global glGetUniformLocation
    global program
    global glUniformMatrix4fv

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
    glLinkProgram:          dq 0x0
    fnLinkProgram:          db "glLinkProgram", 0
    glGetProgramiv:         dq 0x0
    fnGetProgramiv:         db "glGetProgramiv", 0
    glGetProgramInfoLog:    dq 0x0
    fnGetProgramInfoLog:    db "glGetProgramInfoLog", 0
    glUseProgram:           dq 0x0
    fnUseProgram:           db "glUseProgram", 0
    glGenBuffers:           dq 0x0
    fnGenBuffers:           db "glGenBuffers", 0
    glBindBuffer:           dq 0x0
    fnBindBuffer:           db "glBindBuffer", 0
    glBufferData:           dq 0x0
    fnBufferData:           db "glBufferData", 0
    glDeleteBuffers:        dq 0x0
    fnDeleteBuffers:        db "glDeleteBuffers", 0
    glGenVertexArrays:      dq 0x0
    fnGenVertexArrays:      db "glGenVertexArrays", 0
    glBindVertexArray:      dq 0x0
    fnBindVertexArray:      db "glBindVertexArray", 0
    glDeleteVertexArrays:   dq 0x0
    fnDeleteVertexArrays:   db "glDeleteVertexArrays", 0
    glVertexAttribPointer:  dq 0x0
    fnVertexAttribPointer:  db "glVertexAttribPointer", 0
    glEnableVertexAttribArray:  dq 0x0
    fnEnableVertexAttribArray:  db "glEnableVertexAttribArray", 0
    glDisableVertexAttribArray: dq 0x0
    fnDisableVertexAttribArray: db "glDisableVertexAttribArray", 0
    glDrawArrays:           dq 0x0
    fnDrawArrays:           db "glDrawArrays", 0
    glGetError:             dq 0x0
    fnGetError:             db "glGetError", 0
    glGetIntegerv           dq 0x0
    fnGetIntegerv           db "glGetIntegerv", 0
    glGetUniformLocation:   dq 0x0
    fnGetUniformLocation:   db "glGetUniformLocation", 0
    glUniformMatrix4fv:     dq 0x0
    fnUniformMatrix4fv:     db "glUniformMatrix4fv", 0
    
section .text

main:
_start:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x10

    ;   Initializing: SDL2
    mov     rdi, SDL_INIT_EVERYTHING
    call    SDL_Init
    cmp     rax, 0
    jne     fail

    mov     rdi, SDL_GL_CONTEXT_MAJOR_VERSION
    mov     rsi, 3
    call    SDL_GL_SetAttribute

    mov     rdi, SDL_GL_CONTEXT_MINOR_VERSION
    mov     rsi, 3
    call    SDL_GL_SetAttribute

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
    mov     DWORD [program], eax
    
    mov     rdi, rax
    call    [glUseProgram]

    call    init_square
    call    loop
    call    release_square

    mov     edi, program
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

    mov     rdi, fnLinkProgram
    call    glXGetProcAddress
    mov     QWORD [glLinkProgram], rax

    mov     rdi, fnGetProgramiv
    call    glXGetProcAddress
    mov     QWORD [glGetProgramiv], rax

    mov     rdi, fnGetProgramInfoLog
    call    glXGetProcAddress
    mov     QWORD [glGetProgramInfoLog], rax

    mov     rdi, fnUseProgram
    call    glXGetProcAddress
    mov     QWORD [glUseProgram], rax

    mov     rdi, fnGenBuffers
    call    glXGetProcAddress
    mov     QWORD [glGenBuffers], rax

    mov     rdi, fnBindBuffer
    call    glXGetProcAddress
    mov     QWORD [glBindBuffer], rax

    mov     rdi, fnBufferData
    call    glXGetProcAddress
    mov     QWORD [glBufferData], rax

    mov     rdi, fnDeleteBuffers
    call    glXGetProcAddress
    mov     QWORD [glDeleteBuffers], rax

    mov     rdi, fnGenVertexArrays
    call    glXGetProcAddress
    mov     QWORD [glGenVertexArrays], rax

    mov     rdi, fnBindVertexArray
    call    glXGetProcAddress
    mov     QWORD [glBindVertexArray], rax

    mov     rdi, fnDeleteVertexArrays
    call    glXGetProcAddress
    mov     QWORD [glDeleteVertexArrays], rax

    mov     rdi, fnVertexAttribPointer
    call    glXGetProcAddress
    mov     QWORD [glVertexAttribPointer], rax

    mov     rdi, fnEnableVertexAttribArray
    call    glXGetProcAddress
    mov     QWORD [glEnableVertexAttribArray], rax

    mov     rdi, fnDisableVertexAttribArray
    call    glXGetProcAddress
    mov     QWORD [glDisableVertexAttribArray], rax

    mov     rdi, fnDrawArrays
    call    glXGetProcAddress
    mov     QWORD [glDrawArrays], rax

    mov     rdi, fnGetError
    call    glXGetProcAddress
    mov     QWORD [glGetError], rax

    mov     rdi, fnGetIntegerv
    call    glXGetProcAddress
    mov     QWORD [glGetIntegerv], rax

    mov     rdi, fnGetUniformLocation
    call    glXGetProcAddress
    mov     QWORD [glGetUniformLocation], rax

    mov     rdi, fnUniformMatrix4fv
    call    glXGetProcAddress
    mov     QWORD [glUniformMatrix4fv], rax

    ret
