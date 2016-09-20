    %include "sdl.h"
    %include "gl.h"
    %include "player.h"

    extern window
    extern program
    extern ortho

    extern printf

    global loop

section .data
    player:     ISTRUC obj
                at obj.pos + vec3.x, dd 0
                at obj.pos + vec3.y, dd 0
                at obj.pos + vec3.z, dd 0
                IEND
    tick:       dd 0
    step:       dd 0

section .text

loop:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x60

    ;   is running
    mov     BYTE [rbp - 0x39], 1

    xor     rdi, rdi
    call    SDL_GetKeyboardState
    mov     QWORD [rbp - 0x48], rax

    mov     DWORD [rbp - 0x4c], __float32__(1.0)
    
    loop_event:
        lea     rdi, [rbp - 0x38]
        call    SDL_PollEvent
        cmp     rax, 0
        je     loop_main

        cmp     DWORD [rbp - 0x38], SDL_QUIT
        je      case_quit
        jmp     loop_event

        case_quit:
            mov     BYTE [rbp - 0x39], 0
            jmp     loop_event

    loop_main:
        mov     rdi, player
        lea     rsi, [rbp - 0x48]
        call    playerUpdate

        call    SDL_GetTicks
        mov     DWORD [tick], eax

        pxor    xmm0, xmm0
        pxor    xmm1, xmm1
        pxor    xmm2, xmm2
        pxor    xmm3, xmm3
        call    [glClearColor]

        mov     rdi, GL_COLOR_BUFFER_BIT
        call    [glClear]

        mov     rdi, player
        call    render

        mov     rdi, QWORD [window]
        call    SDL_GL_SwapWindow

        cmp     BYTE [rbp - 0x39], 1
        je      loop_event

    leave
    xor     rax, rax
    ret

calcStep:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x10

    call    SDL_GetTicks
    sub     eax, DWORD [tick]
    mov     DWORD [step], eax

    leave
    ret
