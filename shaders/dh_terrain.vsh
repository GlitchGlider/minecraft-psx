#version 460 compatibility
#extension GL_EXT_gpu_shader4 : enable
#include "/lib/psx_util.glsl"

#include "/shaders.settings"

out vec4 lmcoord;
out vec4 color;

void main() {
	vec4 texcoord = gl_MultiTexCoord0;
	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	
	vec4 ftrans = ftransform();
	float depth = clamp(ftrans.w, 0.001, 1000.0);
	float sqrtDepth = pow(depth, 0.1/vertex_distance_scalar) + vertex_distance_scalar / 50;
	
	//vec4 position4 = PixelSnap(ftrans, pow(vertex_inaccuracy_terrain, 0.25) * 5 * (vertex_distance_scalar * 0.5)  / sqrtDepth);
	vec3 position = ftrans.xyz;

	color = gl_Color;
	
	gl_Position = ftrans;
	
}
