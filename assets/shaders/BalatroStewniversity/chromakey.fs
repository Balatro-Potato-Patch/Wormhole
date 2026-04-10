#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define PRECISION highp
#else
	#define PRECISION mediump
#endif

extern PRECISION float target_hue;


float hue(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.r, max(c.g, c.b));
	number delta = high - low;
	number sum = high+low;

    float res = .0;
	if (delta == .0)
		return .0;

	if (high == c.r)
		res = (c.g - c.b) / delta;
	else if (high == c.g)
		res = (c.b - c.r) / delta + 2.0;
	else
		res = (c.r - c.g) / delta + 4.0;

	res = mod(res / 6., 1.);
	return res;
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec4 pixel = Texel(texture, texture_coords);
	// if (pixel.a < 99.) return pixel;//vec4(1., 0., 0., 1.);

    float pixel_hue = hue(pixel);

    // TODO : smoothstep instead cuz Idk buh
    if (abs(pixel_hue - target_hue) < 0.05) {
        pixel.a = 0;
    }

    return colour * pixel;
}

