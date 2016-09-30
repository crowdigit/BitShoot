#version 330

struct Segment {
    vec2 uv;
};

out vec4 color;
in Segment vtf;
uniform sampler2D tex;

void main() {
    color = texture(tex, vtf.uv);
}
