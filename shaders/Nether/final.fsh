#version 460 compatibility
#extension GL_EXT_gpu_shader4 : enable

#include "/shaders.settings"
#include "/lib/common.glsl"

#define DITHER_COLORS 128
in vec2 texcoord;

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform sampler2D gaux4;
uniform vec2 texelSize;
uniform float viewWidth;
uniform float viewHeight;
uniform float aspectRatio;
uniform vec3 fogColor;

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

    
    float depth0 = texture(depthtex0, downscale).r;

    
    #if fog_enabled == 1
        #ifndef DISTANT_HORIZONS
            float fogdepth = clamp(pow(depth0, fog_distance), 0.0, 1.0);
            if (depth0 < 1.0) {
                col.rgb = col.rgb*(-fogdepth+1) + (fogdepth*fogColor);
            }
        #endif
        #ifdef DISTANT_HORIZONS
            float fogdepth = clamp(pow(-pow(fog_distance/5000.0, 0.0000001)*500000 + 500000, 2), 0.0, 1.0);
            if (depth0 < 1.0) {
                col.rgb*(fogdepth) + ((-fogdepth+1)*fogColor);
            }
        #endif
    #endif

    col = clamp(colSaturation(col, (retro_zazz * 0.8) + 1.0), 0, 1);
    col = GetDither(vec2(downscale.x, downscale.y / aspectRatio) * dsRes.x * dither_scale, col, (dither_amount * 0.0007));
    col = clamp(floor(col * color_depth) / color_depth, 0.0, 1.0);
    col = clamp(colContrast(col, retro_zazz * 1.8), 0.0, 1.0);

    gl_FragColor.rgb = col;
}
