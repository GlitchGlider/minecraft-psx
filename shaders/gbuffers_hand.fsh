#version 460 compatibility
/* DRAWBUFFERS:01 */
#extension GL_EXT_gpu_shader4 : enable
#extension GL_ARB_shader_texture_lod : enable

#include "/shaders.settings"
#include "/lib/common.glsl"
#include "/lib/psx_util.glsl"

in vec4 texcoord;
in vec4 lmcoord;
in vec4 color;
in vec4 blockColor;
in vec4 normalMat;

uniform sampler2D texture;
uniform sampler2D lightmap;

void main() {
	vec3 normal = normalMat.xyz;

	vec4 data0 = texture2D(texture, texcoord.xy) * color * (texture2D(lightmap, lmcoord.st) * 0.8 + 0.2);
	
	gl_FragData[0] = data0;
}
