%ifndef __OBJ_H__
%define __OBJ_H__

%include "vec.h"

%ifdef __OBJ_SRC__
%define INOUT global
%elif
%define INOUT extern
%endif

INOUT init_obj
INOUT init_square
INOUT release_square
INOUT square_vao
INOUT square_vbo
INOUT render

STRUC obj
    .pos:   resb vec3.size
    .vao:   resd 1
    .vbo:   resd 1
    .size:
ENDSTRUC

%endif
