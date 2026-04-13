#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define PRECISION highp
#else
	#define PRECISION mediump
#endif

extern PRECISION vec2 stew_stellar;
extern PRECISION number dissolve;
extern PRECISION number time;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

extern PRECISION number stellar_seed;

#define steps 5
#define darken 0.61
#define starting_grid_percent 0.13 // 0.1 = split spri 

#define distfading 0.92;
#define distsize 0.55;

const vec3 ourple = vec3(175./255., 158./255., 1.) * 0.09;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

float hash(vec2 p) {
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

float circle(vec2 uv, vec2 coords, float radius) {
    vec2 center = uv - coords;

    return 1. - smoothstep(0., radius*radius, center.x * center.x + center.y * center.y);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec4 tex = Texel(texture, texture_coords);
	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;
	vec2 gips_image_size = texture_details.ba;
    uv.x = uv.x * gips_image_size.x / gips_image_size.y;

	float time_ = stew_stellar.y;
	float ref_size = gips_image_size.x;
    float grid_size = ref_size * starting_grid_percent;

    float radius = starting_grid_percent / 4;
    float cutoff = 0.992; // higher cutoff = less results
    float fade = 1.;

	float shift_mult = 0.008;

	vec4 star_texture = vec4(0.);

    // Main idea is to replicate https://www.shadertoy.com/view/XlfGRj
    // without going too deep on volumetric rendering & dark matter
    // which I'm too stoopid to understand atm
    for (int i = 0; i < steps; i++) {
		vec2 center_shift = vec2(sin(stew_stellar.x), cos(stew_stellar.x)) * shift_mult;

	    vec4 star_color = vec4(1.0);
        vec2 grid_uv = floor(uv.xy*(gips_image_size/grid_size))*grid_size / gips_image_size;
        vec2 grid_center = (grid_uv.xy + vec2(grid_size)/2./gips_image_size.xy);
        float hashed = hash(grid_center + stellar_seed);

        if (hashed > cutoff) {
			if (hashed > 0.997) {
				// yellow
                star_color = vec4(1., 0.95 * hashed, 0.65 * hashed, 1.0);
			} else if (hashed > 0.9965) {
				// orange (saturated)
                star_color = vec4(1., 0.56 * hashed, 0.01 * hashed, 1.0);
			} else if (hashed > 0.994) {
				// orange
                star_color = vec4(1., 0.66 * hashed, 0.50 * hashed, 1.0);
            }

            float final_radius = radius;
            if ((i == 2 || i == 3) && hashed > 0.992 && hashed < 0.995) {
                final_radius *= 1 + 0.5 * sin(time_ / 110. / (1. - hashed));
            }

            float val = circle( uv, grid_center + center_shift, final_radius);
			star_texture += val * star_color * fade;
        }

		if (i > 1) {
        	fade *= distfading;
		}
        radius *= distsize;
        grid_size *= distsize;
		shift_mult *= 0.85;
        cutoff *= 0.99; // more stars show up
    }

    tex.rgb *= darken;
	tex.rgb += ourple;
	float tex_a = tex.a;

	tex = tex * (1. - star_texture.a) + star_texture;
	tex.a = tex_a;
    
    return dissolve_mask(tex, texture_coords, uv);
}

// Card shader stuff

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
