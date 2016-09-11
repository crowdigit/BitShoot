    %define GL_COLOR_BUFFER_BIT     0x4000
    %define GL_FRAGMENT_SHADER      0x8B30
    %define GL_VERTEX_SHADER        0x8B31
    %define GL_COMPILE_STATUS       0x8B81
    %define GL_LINK_STATUS          0x8B82
    %define GL_INFO_LOG_LENGTH      0x8B84
    %define GL_ARRAY_BUFFER         0x8892
    %define GL_STATIC_DRAW          0x88E4
    %define GL_FLOAT                0x1406
    %define GL_TRIANGLES            0x0004

    %define GL_NO_ERROR             0
    %define GL_INVALID_ENUM         0x0500
    %define GL_INVALID_VALUE        0x0501
    %define GL_INVALID_OPERATION    0x0502
    %define GL_OUT_OF_MEMORY        0x0505
    %define GL_INVALID_FRAMEBUFFER_OPERATION  0x0506
    %define GL_STACK_OVERFLOW       0x0503
    %define GL_STACK_UNDERFLOW      0x0504

    %define GL_CURRENT_PROGRAM                0x8B8D

    %ifdef __GL_SRC__
    %define INOUT global
    %elif
    %define INOUT extern
    %endif

    INOUT glClear
    INOUT glClearColor
    INOUT glCreateProgram
    INOUT glCreateShader
    INOUT glDetachShader
    INOUT glDeleteShader
    INOUT glDeleteProgram
    INOUT glShaderSource
    INOUT glCompileShader
    INOUT glGetShaderiv
    INOUT glGetShaderInfoLog
    INOUT glAttachShader
    INOUT glLinkProgram
    INOUT glGetProgramiv
    INOUT glGetProgramInfoLog
    INOUT glUseProgram
    INOUT glGenBuffers
    INOUT glBindBuffer
    INOUT glBufferData
    INOUT glDeleteBuffers
    INOUT glGenVertexArrays
    INOUT glBindVertexArray
    INOUT glDeleteVertexArrays
    INOUT glVertexAttribPointer
    INOUT glEnableVertexAttribArray
    INOUT glDisableVertexAttribArray
    INOUT glDrawArrays
    INOUT glGetError
    INOUT glGetIntegerv
    INOUT glGetUniformLocation
    INOUT glUniformMatrix4fv
