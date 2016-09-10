%ifndef __OBJ_H__
%define __OBJ_H__

%include "vec.h"

extern init_obj
extern init_square
extern release_square
extern square_vao
extern square_vbo
extern render

STRUC mat4
    .r1:    resb vec4.size
    .r2:    resb vec4.size
    .r3:    resb vec4.size
    .r4:    resb vec4.size
    .size:
ENDSTRUC

STRUC obj
    .pos:   resb vec3.size
    .vao:   resd 1
    .vbo:   resd 1
    .size:
ENDSTRUC

%endif
