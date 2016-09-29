%ifndef __TEX_H__
%define __TEX_H__

%include "gl.h"

%ifdef __TEX_SRC__
%define INOUT global
%else
%define INOUT extern
%endif

INOUT LoadTexture

%endif
