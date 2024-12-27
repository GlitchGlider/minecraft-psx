#version 460 compatibility
#DISTANT_HORIZONS
/* DRAWBUFFERS:01 */
#extension GL_EXT_gpu_shader4 : enable
#extension GL_ARB_shader_texture_lod : enable


uniform float viewWidth;
uniform float viewHeight;
uniform vec3 fogColor;

in vec4 lmcoord;
in vec4 color;

#include "/lib/psx_util.glsl"
#include "/shaders.settings"

uniform sampler2D texture;
uniform sampler2D lightmap;
uniform sampler2D dhDepthTex1;

void main() {
    vec2 texcoord = gl_FragCoord.xy / vec2(viewWidth, viewHeight);

	vec4 lighting = color * (texture2D(lightmap, lmcoord.st));
	vec4 col = texture2D(texture, texcoord.xy) * lighting;

    float depth0 = texture(dhDepthTex1, texcoord.xy).r;
    float fogdepth = clamp(pow(depth0, fog_distance/4), 0.0, 1.0);

    #if fog_enabled == 1
        col.rgb = col.rgb*(-fogdepth+1) + (fogdepth*fogColor);
    #endif
	
	gl_FragData[0] = col;
	gl_FragData[1] = vec4(vec3(gl_FragCoord.z), 1.0);
}
