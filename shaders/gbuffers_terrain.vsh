#version 460 compatibility
#extension GL_EXT_gpu_shader4 : enable

#include "/shaders.settings"
#include "/lib/common.glsl"
#include "/lib/psx_util.glsl"

out vec4 texcoord;
out vec4 texcoordAffine;
out vec4 lmcoord;
out vec4 color;
out vec4 normal;
out vec3 tangent;
out vec3 binormal;

in vec4 mc_Entity;
uniform vec2 texelSize;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;
uniform sampler2D lightmap;
uniform float far;

#define diagonal3(m) vec3((m)[0].x, (m)[1].y, m[2].z)
#define projMAD(m, v) (diagonal3(m) * (v) + (m)[3].xyz)
vec4 toClipSpace3(vec3 viewSpacePosition) {
    return vec4(projMAD(gl_ProjectionMatrix, viewSpacePosition),-viewSpacePosition.z);
}

void main() {
	texcoord = gl_MultiTexCoord0;
	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	
	vec4 ftrans = ftransform();
	float depth = clamp(ftrans.w, 0.001, 1000.0);
	float sqrtDepth = pow(depth, 0.1/vertex_distance_scalar) + vertex_distance_scalar / 50;
	
	vec4 position4 = PixelSnap(ftrans, pow(vertex_inaccuracy_terrain, 0.25) * 5 * (vertex_distance_scalar * 0.5)  / sqrtDepth);
	vec3 position = position4.xyz;
	
	float wVal = (mat3(gl_ProjectionMatrix) * position).z;
	wVal = clamp(wVal, -10000.0, 0.0);
	texcoordAffine = vec4(texcoord.xy * wVal, wVal, 0);

	color = gl_Color;
	
	normal.a = 0.02;
	normal.xyz = normalize(gl_NormalMatrix * gl_Normal);
	
	gl_Position = position4;
	
	mat3 tbnMatrix = mat3(tangent.x, binormal.x, normal.x,
                          tangent.y, binormal.y, normal.y,
                          tangent.z, binormal.z, normal.z);
}
