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

    extern glClear
    extern glClearColor
    extern glCreateProgram
    extern glCreateShader
    extern glDetachShader
    extern glDeleteShader
    extern glDeleteProgram
    extern glShaderSource
    extern glCompileShader
    extern glGetShaderiv
    extern glGetShaderInfoLog
    extern glAttachShader
    extern glLinkProgram
    extern glGetProgramiv
    extern glGetProgramInfoLog
    extern glUseProgram
    extern glGenBuffers
    extern glBindBuffer
    extern glBufferData
    extern glDeleteBuffers
    extern glGenVertexArrays
    extern glBindVertexArray
    extern glDeleteVertexArrays
    extern glVertexAttribPointer
    extern glEnableVertexAttribArray
    extern glDisableVertexAttribArray
    extern glDrawArrays
    extern glGetError
    extern glGetIntegerv
    extern glGetUniformLocation
    extern glUniformMatrix4fv
