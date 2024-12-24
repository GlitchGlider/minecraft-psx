#version 460 compatibility
/* DRAWBUFFERS:5 */

in vec4 color;
in vec2 texcoord;

uniform sampler2D texture;

void main() {
	gl_FragData[0] = texture2D(texture,texcoord.xy) * color * vec4(0.2,0.2,0.2,1.0);
}
