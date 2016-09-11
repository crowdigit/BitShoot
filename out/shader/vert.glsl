#version 330

layout (location = 0) in vec3 vertex;

uniform mat4 Model;

void main() {
    gl_Position = Model * vec4(vertex, 1.0);
}
