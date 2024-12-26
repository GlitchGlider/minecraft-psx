#version 460 compatibility

out vec2 texcoord;
out vec4 glcolor;

void main() {
	gl_Position = ftransform();
	glcolor = gl_Color;
	texcoord = gl_MultiTexCoord0.xy;
}
