%ifdef __STEP_SRC__
%define INOUT global
%else
%define INOUT extern
%endif

%include "sdl.h"

INOUT calcStep
INOUT stepi
INOUT tick
