#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 hedonia_shader_drunk;

extern PRECISION number dissolve;
extern PRECISION number time;

extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;

extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

// wobble intensity control
extern PRECISION number wobble_strength;

// required
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

vec4 hsv2rgb(vec4 c);
vec4 rgb2hsv(vec4 c);

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    // create sprite local uv from atlas uv
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    float t = time * 2.0 + (hedonia_shader_drunk.x);

    // lower distortion near the edgest to avoid clipping
    vec2 dist_to_edge = min(uv, 1.0 - uv);
    float edge_dist = min(dist_to_edge.x, dist_to_edge.y);
    float edge_fade = smoothstep(0.0, 0.15, edge_dist);

    // Wibbly Wobbly
    float wobble_x = sin(uv.y * 6.0 + t * 1.7) * 0.02 * wobble_strength;
    float wobble_y = cos(uv.x * 5.0 + t * 1.3) * 0.02 * wobble_strength;

    wobble_x += sin(t * 0.7) * 0.01;
    wobble_y += cos(t * 0.5) * 0.01;

    vec2 distortion = vec2(wobble_x, wobble_y);
    vec2 uv_distorted = clamp(uv + distortion * edge_fade, 0.0, 1.0); // only apply edge fade to uv distort

    // Calculate how distorted the uv of the pixel is.
    float distortion_strength = length(distortion) / 0.05; // normalize approx
    distortion_strength = clamp(distortion_strength, 0.0, 1.0);

    float distortion_strength_ef = length(distortion* edge_fade) / 0.05; //includes edge fade
    distortion_strength_ef = clamp(distortion_strength_ef, 0.0, 1.0);


    float mag = length(distortion); // calculate magnitude of distortion
    vec2 dir = (mag > 1e-4) ? (distortion / mag) : vec2(0.0); // if magnitude is very small, avoid division by zero and set direction to zero
    float hue_shift = dir.x * 0.5 + dir.y * 0.5; // range ~[-1,1]
    hue_shift *= smoothstep(0.01, 0.1, mag); // fade in hue shift as distortion increases

    // convert back to the atlas uv
    vec2 atlas_uv = (uv_distorted * texture_details.ba + texture_details.xy * texture_details.ba) / image_details;

    // distortion based colour split
    // small offset based on distortion direction
    vec2 split_dir = normalize(distortion + 1e-6);
    vec2 split_amt = split_dir * distortion_strength_ef * 0.05; // use edge faded distortion strength for split amount


    vec2 uv_r = clamp(uv_distorted + split_amt, 0.0, 1.0);
    vec2 uv_b = clamp(uv_distorted - split_amt, 0.0, 1.0);

    vec2 atlas_r = (uv_r * texture_details.ba + texture_details.xy * texture_details.ba) / image_details;
    vec2 atlas_b = (uv_b * texture_details.ba + texture_details.xy * texture_details.ba) / image_details;

    vec4 tex_center = Texel(texture, atlas_uv);
    vec4 tex_r = Texel(texture, atlas_r);
    vec4 tex_b = Texel(texture, atlas_b);

    // recombine channels
    vec4 tex = vec4(tex_r.r, tex_center.g, tex_b.b, tex_center.a) * colour;

    // convert to hsv colour space
    vec4 hsv = rgb2hsv(tex);

    // boost saturation in distorted areas
    float sat_boost = mix(1.0, 4.0, distortion_strength); // tweak max (1.5 → stronger)
    hsv.y = clamp(hsv.y * sat_boost, 0.0, 1.0);

    hsv.x += hue_shift * distortion_strength * 0.5;
    hsv.x = fract(hsv.x); // wrap hue around
    // convert back to rgb
    vec4 final = hsv2rgb(hsv);

    return dissolve_mask(final, texture_coords, uv);
}

// stolen from https://stackoverflow.com/questions/15095909/from-rgb-to-hsv-in-opengl-glsl
// modified to include the alpha channel too
vec4 rgb2hsv(vec4 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec4(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x, c.a);
}

vec4 hsv2rgb(vec4 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);

    vec3 rgb = c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);

    return vec4(rgb, c.a);
}

// stolen from ionized.fs which seems to have been stolen from balatro source
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;

    float t = time * 10.0 + 2003.;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
    vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;

    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

// for transforming the card while your mouse is on it
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif