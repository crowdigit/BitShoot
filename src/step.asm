%define __STEP_SRC__
%include "step.h"

section .data
    stepi:      dd 0
    tick:       dd 0

section .text

calcStep:
    call    SDL_GetTicks
    sub     eax, DWORD [tick]
    mov     DWORD [stepi], eax
    ret
