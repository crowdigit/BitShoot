%ifndef __PLAYER_H__
%define __PLAYER_H__

%include "obj.h"

%ifdef __PLAYER_SRC__
%define INOUT global
%elif
%define INOUT extern
%endif

INOUT playerUpdate

%endif
