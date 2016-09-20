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

STRUC mat4
    .r1:    resb vec4.size
    .r2:    resb vec4.size
    .r3:    resb vec4.size
    .r4:    resb vec4.size
    .size:
ENDSTRUC

    %ifdef __VEC_SRC__
    %define INOUT global
    %elif
    %define INOUT extern
    %endif

    INOUT vec4dot
    INOUT mat4mat4mul
    INOUT vec3normalize
    
%endif
