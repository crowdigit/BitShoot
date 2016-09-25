%ifndef __ENEMY_H__
%define __ENEMY_H__

%include "obj.h"

%ifdef __PLAYER_SRC__
%define INOUT global
%elif
%define INOUT extern
%endif

STRUC Enemy
    .pos:   resb vec3.size
    .vao:   resd 1
    .vbo:   resd 1
    .size:
ENDSTRUC

%endif
