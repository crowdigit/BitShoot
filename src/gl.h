%ifndef __GL_H__
%define __GL_H__

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
    %define GL_TEXTURE_2D			0x0DE1

    %define GL_CURRENT_PROGRAM      0x8B8D

    %define GL_RGB					0x1907
    %define GL_RGBA					0x1908
    %define GL_UNSIGNED_BYTE		0x1401

;   Texture mapping
    %define GL_TEXTURE_ENV			0x2300
    %define GL_TEXTURE_ENV_MODE		0x2200
    %define GL_TEXTURE_1D			0x0DE0
    %define GL_TEXTURE_2D			0x0DE1
    %define GL_TEXTURE_WRAP_S		0x2802
    %define GL_TEXTURE_WRAP_T		0x2803
    %define GL_TEXTURE_MAG_FILTER	0x2800
    %define GL_TEXTURE_MIN_FILTER	0x2801
    %define GL_TEXTURE_ENV_COLOR	0x2201
    %define GL_TEXTURE_GEN_S		0x0C60
    %define GL_TEXTURE_GEN_T		0x0C61
    %define GL_TEXTURE_GEN_R		0x0C62
    %define GL_TEXTURE_GEN_Q		0x0C63
    %define GL_TEXTURE_GEN_MODE		0x2500
    %define GL_TEXTURE_BORDER_COLOR	0x1004
    %define GL_TEXTURE_WIDTH		0x1000
    %define GL_TEXTURE_HEIGHT		0x1001
    %define GL_TEXTURE_BORDER		0x1005
    %define GL_TEXTURE_COMPONENTS	0x1003
    %define GL_TEXTURE_RED_SIZE		0x805C
    %define GL_TEXTURE_GREEN_SIZE	0x805D
    %define GL_TEXTURE_BLUE_SIZE	0x805E
    %define GL_TEXTURE_ALPHA_SIZE			0x805F
    %define GL_TEXTURE_LUMINANCE_SIZE		0x8060
    %define GL_TEXTURE_INTENSITY_SIZE		0x8061
    %define GL_NEAREST_MIPMAP_NEAREST		0x2700
    %define GL_NEAREST_MIPMAP_LINEAR		0x2702
    %define GL_LINEAR_MIPMAP_NEAREST		0x2701
    %define GL_LINEAR_MIPMAP_LINEAR			0x2703
    %define GL_OBJECT_LINEAR		0x2401
    %define GL_OBJECT_PLANE			0x2501
    %define GL_EYE_LINEAR			0x2400
    %define GL_EYE_PLANE			0x2502
    %define GL_SPHERE_MAP			0x2402
    %define GL_DECAL				0x2101
    %define GL_MODULATE				0x2100
    %define GL_NEAREST				0x2600
    %define GL_REPEAT				0x2901
    %define GL_CLAMP				0x2900
    %define GL_S					0x2000
    %define GL_T					0x2001
    %define GL_R					0x2002
    %define GL_Q					0x2003
    %define GL_LINEAR				0x2601


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
    INOUT glBufferSubData
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
    INOUT glGenTextures
    INOUT glDeleteTextures
    INOUT glInit
    INOUT glBindTexture
    INOUT glTexParameteri
    INOUT glTexImage2D
    extern glXGetProcAddress

%endif
