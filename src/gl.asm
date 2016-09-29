%define __GL_SRC__
%include "gl.h"

section .data
    glClear:                dq 0x0
    fnClear:                db "glClear", 0
    glClearColor:           dq 0x0
    fnClearColor:           db "glClearColor", 0
    glCreateProgram:        dq 0x0
    fnCreateProgram:        db "glCreateProgram", 0
    glDeleteProgram:        dq 0x0
    fnDeleteProgram:        db "glDeleteProgram", 0
    glCreateShader:         dq 0x0
    fnCreateShader:         db "glCreateShader", 0
    glDeleteShader:         dq 0x0
    fnDeleteShader:         db "glDeleteShader", 0
    glAttachShader:         dq 0x0
    fnAttachShader:         db "glAttachShader", 0
    glDetachShader:         dq 0x0
    fnDetachShader:         db "glDetachShader", 0
    glShaderSource:         dq 0x0
    fnShaderSource:         db "glShaderSource", 0
    glCompileShader:        dq 0x0
    fnCompileShader:        db "glCompileShader", 0
    glGetShaderiv:          dq 0x0
    fnGetShaderiv:          db "glGetShaderiv", 0
    glGetShaderInfoLog:     dq 0x0
    fnGetShaderInfoLog:     db "glGetShaderInfoLog", 0
    glLinkProgram:          dq 0x0
    fnLinkProgram:          db "glLinkProgram", 0
    glGetProgramiv:         dq 0x0
    fnGetProgramiv:         db "glGetProgramiv", 0
    glGetProgramInfoLog:    dq 0x0
    fnGetProgramInfoLog:    db "glGetProgramInfoLog", 0
    glUseProgram:           dq 0x0
    fnUseProgram:           db "glUseProgram", 0
    glGenBuffers:           dq 0x0
    fnGenBuffers:           db "glGenBuffers", 0
    glBindBuffer:           dq 0x0
    fnBindBuffer:           db "glBindBuffer", 0
    glBufferData:           dq 0x0
    fnBufferData:           db "glBufferData", 0
    glBufferSubData:        dq 0x0
    fnBufferSubData:        db "glBufferSubData", 0
    glDeleteBuffers:        dq 0x0
    fnDeleteBuffers:        db "glDeleteBuffers", 0
    glGenVertexArrays:      dq 0x0
    fnGenVertexArrays:      db "glGenVertexArrays", 0
    glBindVertexArray:      dq 0x0
    fnBindVertexArray:      db "glBindVertexArray", 0
    glDeleteVertexArrays:   dq 0x0
    fnDeleteVertexArrays:   db "glDeleteVertexArrays", 0
    glVertexAttribPointer:  dq 0x0
    fnVertexAttribPointer:  db "glVertexAttribPointer", 0
    glEnableVertexAttribArray:  dq 0x0
    fnEnableVertexAttribArray:  db "glEnableVertexAttribArray", 0
    glDisableVertexAttribArray: dq 0x0
    fnDisableVertexAttribArray: db "glDisableVertexAttribArray", 0
    glDrawArrays:           dq 0x0
    fnDrawArrays:           db "glDrawArrays", 0
    glGetError:             dq 0x0
    fnGetError:             db "glGetError", 0
    glGetIntegerv           dq 0x0
    fnGetIntegerv           db "glGetIntegerv", 0
    glGetUniformLocation:   dq 0x0
    fnGetUniformLocation:   db "glGetUniformLocation", 0
    glUniformMatrix4fv:     dq 0x0
    fnUniformMatrix4fv:     db "glUniformMatrix4fv", 0
    glTexImage2D:           dq 0x0
    fnTexImage2D:           db "glTexImage2D", 0
    glGenTextures:          dq 0x0
    fnGenTextures:          db "glGenTextures", 0
    glDeleteTextures:       dq 0x0
    fnDeleteTextures:       db "glDeleteTextures", 0
    glBindTexture:          dq 0x0
    fnBindTexture:          db "glBindTexture", 0
    glTexParameteri:        dq 0x0
    fnTexParameteri:        db "glTexParameteri", 0

section .text

glInit:
    mov     rdi, fnClear
    call    glXGetProcAddress
    mov     QWORD [glClear], rax

    mov     rdi, fnClearColor
    call    glXGetProcAddress
    mov     QWORD [glClearColor], rax

    mov     rdi, fnCreateProgram
    call    glXGetProcAddress
    mov     QWORD [glCreateProgram], rax

    mov     rdi, fnDeleteProgram
    call    glXGetProcAddress
    mov     QWORD [glDeleteProgram], rax

    mov     rdi, fnClearColor
    call    glXGetProcAddress
    mov     QWORD [glClearColor], rax

    mov     rdi, fnCreateShader
    call    glXGetProcAddress
    mov     QWORD [glCreateShader], rax

    mov     rdi, fnDeleteShader
    call    glXGetProcAddress
    mov     QWORD [glDeleteShader], rax

    mov     rdi, fnAttachShader
    call    glXGetProcAddress
    mov     QWORD [glAttachShader], rax
    
    mov     rdi, fnDetachShader
    call    glXGetProcAddress
    mov     QWORD [glDetachShader], rax

    mov     rdi, fnShaderSource
    call    glXGetProcAddress
    mov     QWORD [glShaderSource], rax

    mov     rdi, fnCompileShader
    call    glXGetProcAddress
    mov     QWORD [glCompileShader], rax

    mov     rdi, fnGetShaderiv
    call    glXGetProcAddress
    mov     QWORD [glGetShaderiv], rax

    mov     rdi, fnGetShaderInfoLog
    call    glXGetProcAddress
    mov     QWORD [glGetShaderInfoLog], rax

    mov     rdi, fnLinkProgram
    call    glXGetProcAddress
    mov     QWORD [glLinkProgram], rax

    mov     rdi, fnGetProgramiv
    call    glXGetProcAddress
    mov     QWORD [glGetProgramiv], rax

    mov     rdi, fnGetProgramInfoLog
    call    glXGetProcAddress
    mov     QWORD [glGetProgramInfoLog], rax

    mov     rdi, fnUseProgram
    call    glXGetProcAddress
    mov     QWORD [glUseProgram], rax

    mov     rdi, fnGenBuffers
    call    glXGetProcAddress
    mov     QWORD [glGenBuffers], rax

    mov     rdi, fnBindBuffer
    call    glXGetProcAddress
    mov     QWORD [glBindBuffer], rax

    mov     rdi, fnBufferData
    call    glXGetProcAddress
    mov     QWORD [glBufferData], rax

    mov     rdi, fnBufferSubData
    call    glXGetProcAddress
    mov     QWORD [glBufferSubData], rax

    mov     rdi, fnDeleteBuffers
    call    glXGetProcAddress
    mov     QWORD [glDeleteBuffers], rax

    mov     rdi, fnGenVertexArrays
    call    glXGetProcAddress
    mov     QWORD [glGenVertexArrays], rax

    mov     rdi, fnBindVertexArray
    call    glXGetProcAddress
    mov     QWORD [glBindVertexArray], rax

    mov     rdi, fnDeleteVertexArrays
    call    glXGetProcAddress
    mov     QWORD [glDeleteVertexArrays], rax

    mov     rdi, fnVertexAttribPointer
    call    glXGetProcAddress
    mov     QWORD [glVertexAttribPointer], rax

    mov     rdi, fnEnableVertexAttribArray
    call    glXGetProcAddress
    mov     QWORD [glEnableVertexAttribArray], rax

    mov     rdi, fnDisableVertexAttribArray
    call    glXGetProcAddress
    mov     QWORD [glDisableVertexAttribArray], rax

    mov     rdi, fnDrawArrays
    call    glXGetProcAddress
    mov     QWORD [glDrawArrays], rax

    mov     rdi, fnGetError
    call    glXGetProcAddress
    mov     QWORD [glGetError], rax

    mov     rdi, fnGetIntegerv
    call    glXGetProcAddress
    mov     QWORD [glGetIntegerv], rax

    mov     rdi, fnGetUniformLocation
    call    glXGetProcAddress
    mov     QWORD [glGetUniformLocation], rax

    mov     rdi, fnUniformMatrix4fv
    call    glXGetProcAddress
    mov     QWORD [glUniformMatrix4fv], rax

    mov     rdi, fnTexImage2D
    call    glXGetProcAddress
    mov     QWORD [glTexImage2D], rax

    mov     rdi, fnGenTextures
    call    glXGetProcAddress
    mov     QWORD [glGenTextures], rax

    mov     rdi, fnDeleteTextures
    call    glXGetProcAddress
    mov     QWORD [glDeleteTextures], rax

    mov     rdi, fnBindTexture
    call    glXGetProcAddress
    mov     QWORD [glBindTexture], rax

    mov     rdi, fnTexParameteri
    call    glXGetProcAddress
    mov     QWORD [glTexParameteri], rax

    ret
