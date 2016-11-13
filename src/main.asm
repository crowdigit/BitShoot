    %include "sdl.h"
    %include "gl.h"
    %include "tex.h"

    extern loop
    extern LoadProgram
    extern init_obj
    extern init_square
    extern release_square
    global tmp_tex

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
    initflag:   dd 0d1

    vert:       db "./shader/vert.glsl", 0
    frag:       db "./shader/frag.glsl", 0
    tex:        db "./res/icont.png", 0
    die:        db "./res/over.png", 0

    tmp_tex:
                dd 0x0
                dd 0x0
                dd 0x0
    
section .text

%ifndef TEST
main:
%endif
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x10

    ;   Initializing SDL2
    mov     rdi, SDL_INIT_EVERYTHING
    call    SDL_Init
    cmp     rax, 0
    jne     fail

    mov     rdi, IMG_INIT_PNG
    call    IMG_Init
    cmp     rax, IMG_INIT_PNG
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
    mov     rcx, 1024
    mov     r8, 768
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
    lea     rdx, [initflag]
    call    LoadProgram
    mov     DWORD [program], eax
    
    cmp     DWORD [initflag], 1
    jne     rel_a
    
    mov     rdi, rax
    call    [glUseProgram]

    mov     rdi, tex
    call    LoadTexture
    mov     DWORD [tmp_tex + 0x0], eax

    mov     rdi, die
    call    LoadTexture
    mov     DWORD [tmp_tex + 0x4], eax

    call    init_square
    call    loop

rel_a:
    call    release_square

    mov     edi, program
    call    [glDeleteProgram]
    
    mov     rdi, 1
    lea     esi, [tmp_tex]
    call    [glDeleteTextures]
    
    mov     rdi, 1
    lea     esi, [tmp_tex + 0x4]
    call    [glDeleteTextures]


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
    call    IMG_Quit
    call    SDL_Quit

quit:
    add     rsp, 0x10
    pop     rbp
    xor     rax, rax
    ret
