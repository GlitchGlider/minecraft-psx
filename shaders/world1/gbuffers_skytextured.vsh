#version 460 compatibility

out vec4 color;
out vec2 texcoord;

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).st;
	color = gl_Color;

	gl_Position = ftransform();
}
