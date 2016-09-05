#version 330

layout (location = 0) in vec3 vertex
layout (location = 1) in vec3 normal
layout (location = 2) in vec2 uv

void main() {
    gl_Position = vec4(vertex, 1.0);
}
