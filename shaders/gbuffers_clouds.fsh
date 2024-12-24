#version 460 compatibility
/* DRAWBUFFERS:6 */

#extension GL_EXT_gpu_shader4 : enable
#extension GL_ARB_shader_texture_lod : enable

in vec4 texcoord;
in vec4 color;

uniform sampler2D texture;
uniform sampler2D lightmap;

void main() {
	vec4 col = texture2D(texture, texcoord.xy) * color;
	
	gl_FragData[0] = col;
}
