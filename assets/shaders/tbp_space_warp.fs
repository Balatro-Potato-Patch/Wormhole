extern number time;
extern number transparency;
#define NUM_LAYERS 8.
#define TAU 6.28318
#define PI 3.141592
#define Velocity 0.025
#define StarGlow 0.025
#define StarSize 02.
#define CanvasView 20.

float Star(vec2 uv, float flare){
    float d = length(uv);
    float m = sin(StarGlow*1.2)/d;  
    float rays = max(0., 0.5-abs(uv.x*uv.y*1000.)); 
    m += (rays*flare)*2.;
    m *= smoothstep(1., 0.1, d);
    return m;
}
float Hash21(vec2 p){
    p = fract(p*vec2(123.34, 456.21));
    p += dot(p, p+45.32);
    return fract(p.x*p.y);
}
vec3 DistantGalaxy(vec2 uv){
    float t = time * 0.1 + ((.25 + .05 * sin(time * .1))/(length(uv.xy) + .07)) * 2.2;
    float si = sin(t);
    float co = cos(t);
    mat2 ma = mat2(co, si, -si, co);
    float v1, v2, v3;
    v1 = v2 = v3 = 0.0;
    float s = 0.0;
    for (int i = 0; i < 90; i++)
    {
        vec3 p = s * vec3(uv, 0.0);
        p.xy *= ma;
        p += vec3(.22, .3, s - 1.5 - sin(time * .13) * .1);
        for (int i = 0; i < 8; i++) p = abs(p) / dot(p,p) - 0.659;
        v1 += dot(p,p) * .0015 * (1.8 + sin(length(uv.xy * 13.0) + .5  - time * .2));
        v2 += dot(p,p) * .0013 * (1.5 + sin(length(uv.xy * 14.5) + 1.2 - time * .3));
        v3 += length(p.xy*10.) * .0003;
        s  += .035;
    }
    float len = length(uv);
    v1 *= smoothstep(.7, .0, len);
    v2 *= smoothstep(.5, .0, len);
    v3 *= smoothstep(.9, .0, len);
    
    vec3 col = vec3( v3 * (1.5 + sin(time * .2) * .4),
                    (v1 + v3) * .3,
                     v2) + smoothstep(0.2, .0, len) * .85 + smoothstep(.0, .6, v3) * .3;

    return min(pow(abs(col), vec3(1.2)), 1.0);
}
vec3 StarLayer(vec2 uv){
    vec3 col = vec3(0);
    vec2 gv = fract(uv);
    vec2 id = floor(uv);
    for(int y=-1;y<=1;y++){
        for(int x=-1; x<=1; x++){
            vec2 offs = vec2(x,y);
            float n = Hash21(id+offs);
            float size = fract(n);
            float star = Star(gv-offs-vec2(n, fract(n*34.))+0.5, smoothstep(0.1,0.9,size)*0.46);
            vec3 color = sin(vec3(0.2,0.3,0.9)*fract(n*2345.2)*TAU)*0.25+0.75;
            color = color*vec3(0.9,0.59,0.9+size);
            star *= sin(time*0.6+n*TAU)*0.5+0.5;
            col += star*size*color;
        }
    }
    return col;
}
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = (screen_coords - 0.5*love_ScreenSize.xy)/love_ScreenSize.y;
    vec2 M = vec2(0);
    M -= vec2(M.x+sin(time*0.22), M.y-cos(time*0.22));
    float t = time*Velocity; 
    vec3 col = vec3(0);  
    col += DistantGalaxy(uv);
    for(float i=0.; i<1.; i+=1./NUM_LAYERS){
        float depth = fract(i+t);
        float scale = mix(CanvasView, 0.5, depth);
        float fade = depth*smoothstep(1., 0.9, depth);
        col += StarLayer(uv*scale+i*453.2-time*0.05+M)*fade;
    }

    return mix(Texel(texture, texture_coords), vec4(col, 1), transparency);

}