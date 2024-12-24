#version 460 compatibility
/* DRAWBUFFERS:7 */

in vec4 color;

in vec2 texcoord;
in float lmcoord;

uniform sampler2D texture;

void main() {

	vec4 tex = texture2D(texture, texcoord.xy)*color;

	gl_FragData[0] = vec4(vec3(1.0,lmcoord,1.0),tex.a*length(tex.rgb)/1.732);
}
