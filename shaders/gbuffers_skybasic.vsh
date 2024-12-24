#version 460 compatibility
#extension GL_EXT_gpu_shader4 : enable

void main() {
	gl_Position = ftransform();
}
