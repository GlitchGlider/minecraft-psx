#version 460 compatibility

uniform sampler2D colortex0;

in vec2 texcoord;
#include "/shaders.settings"

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
    #ifdef fog_enabled
	float fogDepth = depth * fog_distance - (fog_distance-1);
	fogDepth = clamp(fogDepth, 0.0, 1.0);
	#endif
	color = texture(colortex0, texcoord);
}
