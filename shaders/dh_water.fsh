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

uniform sampler2D colortex0;
uniform sampler2D texture;
uniform sampler2D lightmap;

void main() {

	//vec4 col = texture2D(texture, texcoord.xy) * color * (texture2D(lightmap, lmcoord.st));
    //figure out later
	
	//gl_FragData[0] = col;
	//gl_FragData[1] = vec4(vec3(gl_FragCoord.z), 1.0);
}
