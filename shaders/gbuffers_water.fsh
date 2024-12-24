#version 460 compatibility
/* DRAWBUFFERS:01 */
#extension GL_EXT_gpu_shader4 : enable
#extension GL_ARB_shader_texture_lod : enable

#define gbuffers_solid
#include "/shaders.settings"

uniform float viewWidth;
uniform float viewHeight;

in vec4 texcoord;
in vec4 texcoordAffine;
in vec4 lmcoord;
in vec4 color;

#include "/lib/psx_util.glsl"

uniform sampler2D texture;
uniform sampler2D lightmap;

void main() {
	#ifdef affine_mapping
	#ifdef affine_clamp_enabled
	vec2 texelSize = vec2(1.0/viewWidth, 1.0/viewHeight);
	vec2 affine = AffineMapping(texcoordAffine, texcoord, texelSize, affine_clamp);
	#else
	vec2 affine = texcoordAffine.xy / texcoordAffine.z;
	#endif
	#else 
	vec2 affine = texcoord.xy;
	#endif


	vec4 col = texture2D(texture, affine) * color * (texture2D(lightmap, lmcoord.st) * 0.8 + 0.2);
	
	gl_FragData[0] = col;
	gl_FragData[1] = vec4(vec3(gl_FragCoord.z), 1.0);
}
