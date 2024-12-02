#version 120
#extension GL_EXT_gpu_shader4 : enable

#define composite
#include "/shaders.settings"

#define DITHER_COLORS 128
varying vec2 texcoord;

uniform sampler2D colortex0;
uniform sampler2D gaux4;
uniform vec2 texelSize;
uniform float viewWidth;
uniform float viewHeight;
uniform float aspectRatio;

vec3 GetDither(vec2 pos, vec3 c, float intensity) {
    int DITHER_THRESHOLDS[16] = int[](-4, 0, -3, 1, 2, -2, 3, -1, -3, 1, -4, 0, 3, -1, 2, -2);
    int index = (int(pos.x) & 3) * 4 + (int(pos.y) & 3);

    c.xyz = clamp(c.xyz * (DITHER_COLORS - 1) + DITHER_THRESHOLDS[index] * (intensity * 100), vec3(0), vec3(DITHER_COLORS - 1));

    c /= DITHER_COLORS;
    return c;
}

void main() {
    vec2 baseRes = vec2(viewWidth, viewHeight);
    vec2 dsRes = baseRes * resolution_downscale;
    //float pixelSize = dsRes.x / baseRes.x;
    vec2 downscale = floor(texcoord * (dsRes - 1) + 0.5) / (dsRes - 1);

    #if aber_toggle == 0
        vec3 col = texture2D(colortex0, downscale).rgb;
    #endif

    #if aber_toggle > 0
        float norm_aber_strength = aber_strength / 6000.0;
        float scr_ratio = (viewWidth / viewHeight) / 1.4;
        vec3 col = vec3(texture2D(colortex0, (downscale + vec2(-norm_aber_strength / scr_ratio * aber_direction,
                                                                norm_aber_strength * scr_ratio * (-aber_direction + 1)) )).r,
                        texture2D(colortex0, downscale).g,
                        texture2D(colortex0, (downscale + vec2(norm_aber_strength / scr_ratio * aber_direction,
                                                                -norm_aber_strength * scr_ratio * (-aber_direction + 1)) )).b
                        );
    #endif


    col = clamp((retro_zazz + 1) * (col - 0.5) + 0.5 + (retro_zazz * 0.17), 0, 1);
    col = GetDither(vec2(downscale.x, downscale.y / aspectRatio) * dsRes.x * dither_scale, col, (dither_amount * 0.0007));
    col = clamp(floor(col * color_depth) / color_depth, 0.0, 1.0);

    gl_FragColor.rgb = col;
}
