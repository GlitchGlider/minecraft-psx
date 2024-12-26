vec3 colSaturation(vec3 inputcolor, float ratio) {
    //ratio 0.0 ~ 10.0 
    ratio = clamp(ratio, 0.0, 10.0);
    //0.55, 0.89, 0.44
    float middle = ((inputcolor.r + inputcolor.g + inputcolor.b) / 3.0);
    inputcolor -= middle;
    vec3 outputcolor = (inputcolor * ratio) + middle;
    return outputcolor;
}

vec3 colContrast(vec3 inputcolor, float ratio) {
    //ratio 0.0 ~ 1.0
    ratio = clamp(ratio, 0.0, 1.0);
    vec3 adjustedcolor = inputcolor - 0.5;
    adjustedcolor = -((vec3(2.0) * pow(adjustedcolor.rgb, vec3(3.0))) - (1.5 * adjustedcolor)) + 0.5;
    // -(2x^{3}-1.5x)
    vec3 outputcolor = (inputcolor * (-ratio + 1.0)) + (adjustedcolor * ratio);
    return outputcolor;
}

float rand(float n) {
    return fract(sin(n) * 43758.5453123);
}

float noise(float p) {
    float fl = floor(p);
    float fc = fract(p);
    return mix(rand(fl), rand(fl + 1.0), fc);
}

float noise2(vec2 a) {
    float c = noise(pow(a.x, noise(a.y * 1000.0)) * 100000.0);
    return c;
}