#version 330

struct Segment {
    vec2 uv;
};

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec2 uv;

uniform mat4 Proj;
uniform mat4 Model;

out Segment vtf;

mat4 Scale(vec3 s) {
    return mat4(
        vec4(s.x, 0.0, 0.0, 0.0),
        vec4(0.0, s.y, 0.0, 0.0),
        vec4(0.0, 0.0, s.z, 0.0),
        vec4(0.0, 0.0, 0.0, 1.0)
    );
}

float ClampToGrid(float stride, float num) {
    float a = floor(num / stride);
    return stride * a;
}

void main() {
    vec4 pos = Model * Scale(vec3(3.0, 3.0, 3.0)) * vec4(vertex, 1.0);
    pos.x = ClampToGrid(1.0, pos.x);
    pos.y = ClampToGrid(1.0, pos.y);
    gl_Position = Proj * pos;

    vtf.uv = uv;
}
