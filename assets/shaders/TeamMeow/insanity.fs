extern float time;
extern float insanity;

vec2 rotatePoint(vec2 target, float angle, vec2 center) {
    vec2 diff = target - center;
    float cosAngle = cos(angle);
    float sinAngle = sin(angle);
    mat2 rotationMatrix = mat2(
        cosAngle, sinAngle,
        -sinAngle, cosAngle
    );
    vec2 rotated_diff = rotationMatrix * diff;
    return rotated_diff + center;
}

vec3 permute(vec3 x) { return mod(((x*34.0)+1.0)*x, 289.0); }

float snoise(vec2 v){
  const vec4 C = vec4(0.211324865405187, 0.366025403784439,
           -0.577350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod(i, 289.0);
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
  + i.x + vec3(0.0, i1.x, 1.0 ));
  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy),
    dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}


vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    float sanity_fac = pow(min(insanity, 25.0) / 25.0, 0.4);

    //add coordinate-modifying effects here
    vec4 tex = Texel(texture, texture_coords);
    // add colour-modifying effects here
    
    vec2 x = texture_coords - vec2(0.5,0.5);
    float radius = length(x);
    float norm_radius = radius * sqrt(2);
    float rad_fac = pow((0.2 + 0.8 * norm_radius), 3.0);

    tex *= (1 - norm_radius * pow(sanity_fac, 1.2));

    float color_shift1 = clamp(snoise(rotatePoint(texture_coords + time / 11.0, time / 5.0, vec2(0.5) + time / 11.0)), 0, 1);

    vec3 purple = vec3(0.722, 0.102, 0.69);

    float fac1 = pow(sanity_fac * color_shift1 + 0.3 * sanity_fac, 3.0) * rad_fac;

    float color_shift2 = clamp(snoise(rotatePoint(texture_coords + vec2(cos(time / 12.0), sin(time / 12.0)), time / 6.0, vec2(0.5) + vec2(cos(time / 12.0), sin(time / 12.0)))), 0, 1);

    float fac2 = pow(sanity_fac * color_shift2 + 0.3 * sanity_fac, 3.0) * rad_fac;

    tex.rgb = mix(tex.rgb, purple, max(fac1, fac2));

    return tex;
}


//necessary to prevent crashes i believe
#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif