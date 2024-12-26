#version 460 compatibility
#DISTANT_HORIZONS
/* DRAWBUFFERS:01 */
#extension GL_EXT_gpu_shader4 : enable
#extension GL_ARB_shader_texture_lod : enable

#define gbuffers_solid

uniform float viewWidth;
uniform float viewHeight;
uniform vec3 skyColor;

in vec4 texcoord;
in vec4 texcoordAffine;
in vec4 lmcoord;
in vec4 color;

#include "/lib/psx_util.glsl"
#include "/shaders.settings"

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform sampler2D dhDepthTex0;

void main() {

	vec4 lighting = color * (texture2D(lightmap, lmcoord.st));
	vec4 col = texture2D(texture, texcoord.xy) * lighting;

    float depth0 = texture(dhDepthTex0, texcoord.xy).r;
    col.rgb = col.rgb*0.5 + skyColor * 0.5;
	
	gl_FragData[0] = col;
	gl_FragData[1] = vec4(vec3(gl_FragCoord.z), 1.0);
}
