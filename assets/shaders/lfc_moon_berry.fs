#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

#define PI 3.14159

// !! change this variable name to your Shader's name
// YOU MUST USE THIS VARIABLE IN THE vec4 effect AT LEAST ONCE

// Values of this variable:
// self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + (math.sin(G.TIMERS.REAL/28) + 1) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
// self.ARGS.send_to_shader[2] = G.TIMERS.REAL
extern PRECISION vec2 lfc_moon_berry;
extern Image wormhole_img;
extern PRECISION vec2 wormhole_img_details;

extern PRECISION number dissolve;
extern PRECISION number time;
// [Note] sprite_pos_x _y is not a pixel position!
//        To get pixel position, you need to multiply  
//        it by sprite_width _height (look flipped.fs)
// (sprite_pos_x, sprite_pos_y, sprite_width, sprite_height) [not normalized]
extern PRECISION vec4 texture_details;
// (width, height) for atlas texture [not normalized]
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

// https://www.shadertoy.com/view/fc2GzV
float hash(float n) { return fract(sin(n) * 43758.5453); }
float speedLine(float angle, float radial, float d, float t, float count, float seed)
{
    float a = angle * count;
    float dx = fract(a);
    float id = floor(a) + seed * 137.0;
    float r1 = hash(id);
    float r2 = hash(id * 2.177);
    float r3 = hash(id * 3.314);
    float r4 = hash(id * 4.531);
    if (r3 < 0.1) return 0.0;
    float speed = r2 * 0.12 + 0.25;
    speed*=7.0;
    float phase = fract(radial * 0.2 + t * speed + r1);
    float len = r2 * 0.2 + 0.25;
    len*=0.7;
    float body = smoothstep(0.0, 0.004, phase)
               * smoothstep(len, len - 0.004, phase);
    float cellWidth = d * 2.0 * PI / count / 4.0;
    float screenDist = abs(dx - 0.5) * cellWidth;
    float halfWidth = max(0.0004, 0.003 * d);
    float w = 1.0 - smoothstep(halfWidth * 0.3, halfWidth, screenDist);
    float innerRadius = 0.15 + r4 * 0.05;
    float centerMask = step(innerRadius, d);
    return body * w * centerMask;
}

// https://www.shadertoy.com/view/NtsBzB
vec3 hash2( vec3 p ) // replace this by something better
{
	p = vec3( dot(p,vec3(127.1,311.7, 74.7)),
			  dot(p,vec3(269.5,183.3,246.1)),
			  dot(p,vec3(113.5,271.9,124.6)));

	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}
float noise( in vec3 p )
{
    vec3 i = floor( p );
    vec3 f = fract( p );
	
	vec3 u = f*f*(3.0-2.0*f);

    return mix( mix( mix( dot( hash2( i + vec3(0.0,0.0,0.0) ), f - vec3(0.0,0.0,0.0) ), 
                          dot( hash2( i + vec3(1.0,0.0,0.0) ), f - vec3(1.0,0.0,0.0) ), u.x),
                     mix( dot( hash2( i + vec3(0.0,1.0,0.0) ), f - vec3(0.0,1.0,0.0) ), 
                          dot( hash2( i + vec3(1.0,1.0,0.0) ), f - vec3(1.0,1.0,0.0) ), u.x), u.y),
                mix( mix( dot( hash2( i + vec3(0.0,0.0,1.0) ), f - vec3(0.0,0.0,1.0) ), 
                          dot( hash2( i + vec3(1.0,0.0,1.0) ), f - vec3(1.0,0.0,1.0) ), u.x),
                     mix( dot( hash2( i + vec3(0.0,1.0,1.0) ), f - vec3(0.0,1.0,1.0) ), 
                          dot( hash2( i + vec3(1.0,1.0,1.0) ), f - vec3(1.0,1.0,1.0) ), u.x), u.y), u.z );
}

number hue(number s, number t, number h)
{
	number hs = mod(h, 1.)*6.;
	if (hs < 1.) return (t-s) * hs + s;
	if (hs < 3.) return t;
	if (hs < 4.) return (t-s) * (4.-hs) + s;
	return s;
}

vec4 RGB(vec4 c)
{
	if (c.y < 0.0001)
		return vec4(vec3(c.z), c.a);

	number t = (c.z < .5) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
	number s = 2.0 * c.z - t;
	return vec4(hue(s,t,c.x + 1./3.), hue(s,t,c.x), hue(s,t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.r, max(c.g, c.b));
	number delta = high - low;
	number sum = high+low;

	vec4 hsl = vec4(.0, .0, .5 * sum, c.a);
	if (delta == .0)
		return hsl;

	hsl.y = (hsl.z < .5) ? delta / sum : delta / (2.0 - sum);

	if (high == c.r)
		hsl.x = (c.g - c.b) / delta;
	else if (high == c.g)
		hsl.x = (c.b - c.r) / delta + 2.0;
	else
		hsl.x = (c.r - c.g) / delta + 4.0;

	hsl.x = mod(hsl.x / 6., 1.);
	return hsl;
}

// [Required] 
// Apply dissolve effect (when card is being "burnt", e.g. when consumable is used)
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{

    // Take pixel color (rgba) from `texture` at `texture_coords`, equivalent of texture2D in GLSL
    vec4 tex = Texel(texture, texture_coords);
    // Position of a pixel within the sprite
	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    if (tex.rgb != vec3(0.0) || tex.a == 0.0){
        return vec4(0.0);
    }

    //tex.rgb += vec3(79.0, 99.0, 103.0)/255.0;

    // wormhole spiral start
    vec2 center_uv = uv-.5;//texture_coords*image_details/wormhole_img_details.xy;
    // center spiral
    center_uv.y *= image_details.x / image_details.y; // extend it out a bit

    // find angles and stuff
    float pixel_angle = atan(center_uv.x,center_uv.y) / PI;
    float pixel_distance =  length(center_uv)* 2.0;
    vec2 polar = vec2(pixel_angle, pixel_distance);
    polar += lfc_moon_berry.y * vec2(-0.5, 1.0);

    // vortex
    vec4 bg_tex = Texel(wormhole_img, fract(polar));
    bg_tex.a = min(1.0, bg_tex.a * (pixel_distance + 0.25));
    //bg_tex.a = min(1.0, pow(bg_tex.a, 3.0));

    tex.rgb += bg_tex.rgb*bg_tex.a;

    // speed lines
    vec2 sl_p = (uv - 0.5) * image_details.x / image_details.y;
    float sl_d = length(sl_p);
    float sl_angle = atan(sl_p.x, sl_p.y) / (2.0 * PI) + 0.5;
    float sl_radial = -log(max(sl_d, 0.005));
    float sl_t = lfc_moon_berry.y * -0.3;
    float sl_lines = 0.0;
    sl_lines += speedLine(sl_angle,          sl_radial,       sl_d, sl_t,        20.0, 0.0);
    sl_lines += speedLine(sl_angle + 0.011,  sl_radial + 1.5, sl_d, sl_t + 0.25, 15.0, 1.0) * 0.85;
    sl_lines += speedLine(sl_angle + 0.023,  sl_radial + 3.0, sl_d, sl_t + 0.50, 10.0, 2.0) * 0.7;
    vec3 sl_col = vec3(1.0) * sl_lines * 0.85;
    sl_col *= pixel_distance;

    tex.rgb += sl_col * 0.5;

    // vignette
    tex.rgb += clamp(pow(pixel_distance, 3.0), 0.0, 1.0);

    // interpolate color
    vec3 start_color = vec3(207.0, 93.0, 197.0)/255.0;
    vec3 mid_color = vec3(65.0, 30.0, 88.0)/255.0;
    vec3 end_color = vec3(18.0, 17.0, 47.0)/255.0;
    vec4 hsl = HSL(tex);

    tex.rgb = mix(mix(mid_color, start_color, (hsl.b-0.5)/0.5), mix(end_color, mid_color, hsl.b/0.5), step(hsl.b, 0.5));

    // stars
    vec2 stars_uv = fract((screen_coords * 0.25)/image_details);
    
    // Stars computation:
    vec3 stars_direction = normalize(vec3(stars_uv * 2.0f - 1.0f, 1.0f)); // could be view vector for example
	float stars_threshold = 12.0f; // modifies the number of stars that are visible
	float stars_exposure = 400.0f; // modifies the overall strength of the stars
	float stars = pow(clamp(noise(stars_direction * 200.0f), 0.0f, 1.0f), stars_threshold) * stars_exposure;
	stars *= mix(0.4, 1.4, noise(stars_direction * 100.0f + vec3(lfc_moon_berry.y))); // time based flickering
    stars = clamp(stars, 0.0, 1.0);
	
    // add stars
    vec3 star_color = vec3(99.0, 211.0, 246.0)/255.0;
    tex.rgb += mix(mix(star_color, vec3(1.0), (stars-0.5)/0.5), mix(vec3(0.0), star_color, stars/0.5), step(stars, 0.5));

    if (lfc_moon_berry.y > lfc_moon_berry.y * 2.0 * wormhole_img_details.x) {
        return vec4(0.0);
    }

    return dissolve_mask(tex*colour, texture_coords, uv);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

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