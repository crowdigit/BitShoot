    %include "sdl.h"
    %include "gl.h"

    extern loop
    extern LoadProgram
    extern init_obj
    extern init_square
    extern release_square

    global main
    global window
    global program

    global err

section .data
    err:        db "error: %s", 10, 0
    title:      db "Hello Assembly!", 0
    window:     dq 0x0
    context:    dq 0x0
    program:    dd 0d0

    vert:       db "./shader/vert.glsl", 0
    frag:       db "./shader/frag.glsl", 0
    
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
