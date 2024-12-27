#version 460 compatibility

in vec2 texcoord;
uniform float frameTimeCounter;
uniform float frameTime;
uniform vec3 fogColor;

in vec4 glcolor;
#include "/lib/common.glsl"
#include "/shaders.settings"

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
    float small_frames = int(mod(frameTimeCounter, 20) * 10 * end_noise_speed)*0.2;
    color = vec4(0.145, 0.055, 0.231, 1.0);
    color.rgb *= vec3(
        noise2(texcoord + small_frames),
        noise2(texcoord + small_frames),
        noise2(texcoord + small_frames)
        ) * end_noise_strength + (end_noise_strength * -0.5 + 0.5);
}
