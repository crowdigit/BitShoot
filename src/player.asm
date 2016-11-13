%include "vec.h"

%define __PLAYER_SRC__
%include "player.h"

extern sqrtf
extern tmp_tex

global time

global dead

section .data
    clicknow:   dw 0
    clickpre:   dw 0
    fmt:       db "%d", 10, 0
    dead:       db 0
    time:       db 0
    tex_in:     db 0

section .text

playerUpdate:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x20

    mov     QWORD [rbp - 0x10], rdi

    cmp     BYTE [dead], 1
    jne     nodie

    tmpaa:

    call    SDL_GetTicks
    mov     rdx, QWORD [rbp - 0x10]
    mov     edx, DWORD [rdx + Player.timer]
    sub     eax, edx

    mov     rbx, 0d500
    xor     edx, edx
    div     ebx

    mov     rdi, QWORD [rbp - 0x10]
    mov     DWORD [rdi + Player.index], eax

aaa:
    jmp     con

    ; call    SDL_GetTicks
    ; dec     DWORD [time]
    ; cmp     eax, 500
    ; inc     DWORD [tex_in]

    ; cmp     DWORD [tex_in], 4
    ; jne     con

; xor     rax, rax
    ; mov     DWORD [rbp - 0x4], eax                  ; rbp - 0x4 = 0.0f
    ; mov     DWORD [rbp - 0x8], __float32__(1.0)     ; rbp - 0x8 = 1.0f

    ; fld     DWORD [rbp - 0x4]   ; Delta x

    ; mov     rax, [rsi]
   ; ;left:
        ; cmp     BYTE [rax + SDL_SCANCODE_A], 0
        ; je      right
; 
        ; fsub    DWORD [rbp - 0x8]
; 
    ; right:
        ; cmp     BYTE [rax + SDL_SCANCODE_D], 0
        ; je      up
; 
        ; fadd    DWORD [rbp - 0x8]
; 
    ; up:
        ; fld     DWORD [rbp - 0x4]   ; Delta y
; 
        ; cmp     BYTE [rax + SDL_SCANCODE_W], 0
        ; je      down
; 
        ; fadd    DWORD [rbp - 0x8]
; 
    ; down:
        ; cmp     BYTE [rax + SDL_SCANCODE_S], 0
        ; je      endkey
; 
        ; fsub    DWORD [rbp - 0x8]
; 
    ; endkey:
; 
        ; mov     DWORD [rbp - 0xc], 0
        ; fstp    DWORD [rbp - 0x10]   ; Store delta y
        ; fstp    DWORD [rbp - 0x14]  ; Store delta x
; 
        ; ; check if vector's length is zero
; 
        ; cmp     DWORD [rbp - 0x14], 0
        ; jne     move_yes
; 
        ; cmp     DWORD [rbp - 0x10], 0
        ; jne     move_yes
; 
        ; jmp     move_end
; 
        ; move_yes:
; 
            ; ; normalize move vector
            ; push    rdi
            ; push    rsi
            ; lea     rdi, [rbp - 0x14]
            ; lea     rsi, [rbp - 0x20]
            ; call    vec3normalize       ; normalized vector is at [rbp - 0x20]
; 
            ; call    calcStep
            ; fild    DWORD [stepi]
            ; mov     rax, [rsp + 0x8]
            ; fmul    DWORD [rax + Player.speed]
            ; fstp    DWORD [rbp - 0x14]  ; frame indepent speed
; 
            ; lea     rdi, [rbp - 0x20]
            ; mov     esi, DWORD [rbp - 0x14]
            ; lea     rdx, [rbp - 0x14]
            ; call    vec3floatmul        ; calculated velocity vector(3) is at [rbp - 0x14]
; 
            ; pop     rsi                 ; kb pointer
            ; pop     rdi                 ; player pointer
; 
            ; fld     DWORD [rbp - 0x14 + vec3.x]
            ; fadd    DWORD [rdi + obj.pos + vec3.x]
            ; fstp    DWORD [rdi + obj.pos + vec3.x]
; 
            ; fld     DWORD [rbp - 0x14 + vec3.y]
            ; fadd    DWORD [rdi + obj.pos + vec3.y]
            ; fstp    DWORD [rdi + obj.pos + vec3.y]
; 
        ; move_end:

nodie:

    mov     ax, WORD [clicknow]
    mov     WORD [clickpre], ax

    lea     rdi, [rbp - 0x4]
    lea     rsi, [rbp - 0x8]
    call    SDL_GetMouseState

    cmp     rax, 1
    jne     no

    cmp     WORD [clickpre], 0
    jne     con

    mov     WORD [clicknow], 1

    ; clicked

    mov     eax, DWORD [tmp_tex + 4]
    mov     DWORD [tmp_tex], eax
    call    firstdie

    jmp     con

no:
    mov     WORD [clicknow], 0
    jmp     con

con:

    leave
    ret

firstdie:
    mov     BYTE [dead], 1
    call    SDL_GetTicks
    mov     rdi, QWORD [rbp - 0x10]
    mov     DWORD [rdi + Player.timer], eax
    ret
