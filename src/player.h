%ifndef __PLAYER_H__
%define __PLAYER_H__

%include "obj.h"

%ifdef __PLAYER_SRC__
%define INOUT global
%elif
%define INOUT extern
%endif

STRUC Player
    .pos:   resb vec3.size
    .vao:   resd 1
    .vbo:   resd 1
    .speed: resd 1
    .index: resd 1
    .timer: resd 1
    .size:
ENDSTRUC


INOUT playerUpdate
INOUT setPlayer

%endif
