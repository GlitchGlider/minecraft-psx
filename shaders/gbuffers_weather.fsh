#version 460 compatibility

#include "/lib/common.glsl"

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
    color.rgb = colSaturation(color.rgb, 1.0);
	if (color.a < alphaTestRef) {
		discard;
	}
}