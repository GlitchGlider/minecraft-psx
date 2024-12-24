#version 460 compatibility
#extension GL_EXT_gpu_shader4 : enable

out vec2 texcoord;

void main() {

	gl_Position = ftransform();
	texcoord = gl_MultiTexCoord0.xy;
}
