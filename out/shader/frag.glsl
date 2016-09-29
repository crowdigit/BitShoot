#version 330

struct Segment {
    vec2 uv;
};

out vec4 color;

in Segment vtf;

void main() {
    // color = vec4(1.0, 0.0, 0.0, 1.0);
    color = vec4(vtf.uv, 1.0, 1.0);
}
