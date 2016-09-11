%ifndef __VEC_H__
%define __VEC_H__

STRUC vec3
    .x:     resd 1
    .y:     resd 1
    .z:     resd 1
    .size:
ENDSTRUC

STRUC vec4
    .x:     resd 1
    .y:     resd 1
    .z:     resd 1
    .w:     resd 1
    .size:
ENDSTRUC

%ifdef __VEC_SRC__
    global vec4dot
%elif
    extern vec4dot
%endif

%endif
