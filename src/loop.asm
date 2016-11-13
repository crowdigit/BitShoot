    %include "sdl.h"
    %include "gl.h"
    %include "player.h"
    %include "step.h"

    extern window
    extern program
    extern ortho
    extern dead
    extern time

    global loop

section .data
    player:     ISTRUC Player
                at Player.pos + vec3.x, dd 0
                at Player.pos + vec3.y, dd 0
                at Player.pos + vec3.z, dd 0
                at Player.speed, dd __float32__(0.02)
                at Player.index, dd 0
                at Player.timer, dd 0
                IEND

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
        cmp     BYTE [player + Player.index], 1
        jne     aaa
        
        call    SDL_GetTicks
        sub     eax, DWORD [time]
        cmp     eax, 300

        jge    case_quit

        aaa:

        lea     rdi, [rbp - 0x38]
        call    SDL_PollEvent
        cmp     rax, 0
        je     loop_main

        cmp     DWORD [rbp - 0x38], SDL_QUIT
        je      case_quit
        jmp     loop_event

        case_quit:
            mov     BYTE [rbp - 0x39], 0
            jmp     loop_main

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
