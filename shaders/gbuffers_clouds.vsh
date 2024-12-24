#version 460 compatibility
#extension GL_EXT_gpu_shader4 : enable

out vec4 texcoord;
out vec4 color;

uniform vec2 texelSize;

void main() {
	texcoord = gl_MultiTexCoord0;

	color = gl_Color;
	
	gl_Position = ftransform();
}
