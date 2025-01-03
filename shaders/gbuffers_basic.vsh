#version 460 compatibility
#extension GL_EXT_gpu_shader4 : enable

#include "/shaders.settings"
#include "/lib/common.glsl"
#include "/lib/psx_util.glsl"

out vec4 texcoord;
out vec4 texcoordAffine;
out vec4 lmcoord;
out vec4 color;
out vec4 normalMat;

in vec4 mc_Entity;
uniform vec2 texelSize;

#define diagonal3(m) vec3((m)[0].x, (m)[1].y, m[2].z)
#define projMAD(m, v) (diagonal3(m) * (v) + (m)[3].xyz)
vec4 toClipSpace3(vec3 viewSpacePosition) {
    return vec4(projMAD(gl_ProjectionMatrix, viewSpacePosition), -viewSpacePosition.z);
}

void main() {
    texcoord = gl_MultiTexCoord0;
    lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;

    vec4 position4 = mat4(gl_ModelViewMatrix) * vec4(gl_Vertex) + gl_ModelViewMatrix[3].xyzw;
    vec3 position = PixelSnap(position4, vertex_inaccuracy_terrain).xyz;

    float wVal = (mat3(gl_ProjectionMatrix) * position).z;
    wVal = clamp(wVal, -10000.0, 0.0);
    texcoordAffine = vec4(texcoord.xy * wVal, wVal, 0);

    color = gl_Color;

    gl_Position = toClipSpace3(position);
}
