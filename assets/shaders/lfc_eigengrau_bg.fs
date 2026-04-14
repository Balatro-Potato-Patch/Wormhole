#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP number alpha;

#define PI 3.14159265358979323846

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

float rand(vec2 c) {
	return fract(sin(dot(c.xy, vec2(12.9898,78.233))) * 43758.5453);
}

float noise(vec2 p, float freq) {
	float unit = 1./freq;
	vec2 ij = floor(p/unit);
	vec2 xy = mod(p,unit)/unit;
	//xy = 3.*xy*xy-2.*xy*xy*xy;
	xy = .5*(1.-cos(PI*xy));
	float a = rand((ij+vec2(0.,0.)));
	float b = rand((ij+vec2(1.,0.)));
	float c = rand((ij+vec2(0.,1.)));
	float d = rand((ij+vec2(1.,1.)));
	float x1 = mix(a, b, xy.x);
	float x2 = mix(c, d, xy.x);
	return mix(x1, x2, xy.y);
}

float pNoise(vec2 p, int res) {
	float persistance = .5;
	float n = 0.;
	float normK = 0.;
	float f = 4.;
	float amp = 1.;
	int iCount = 0;
	for (int i = 0; i<50; i++) {
		n+=amp*noise(p, f);
		f*=2.;
		normK+=amp;
		amp*=persistance;
		if (iCount == res) break;
		iCount++;
	}
	float nf = n/normK;
	return nf*nf*nf*nf;
}

vec2 rot(vec2 v, vec2 o, float r)
{
    float x = v.x; float y = v.y; float dx = o.x; float dy = o.y; float angle = -r;
    float x_rotated = ((x - dx) * cos(angle)) - ((y - dy) * sin(angle)) + dx;
    float y_rotated = ((x - dx) * sin(angle)) + ((y - dy) * cos(angle)) + dy;
    return vec2(x_rotated, y_rotated);
}

vec2 toPolar(vec2 c) {
    return vec2(sqrt(c.x*c.x + c.y*c.y), atan(c.y, c.x));
}

vec2 toCartesian(vec2 p) {
    return vec2(p.x * cos(p.y), p.x * sin(p.y));
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    if (alpha == 0.) {
        return vec4(0,0,0,0);
    }

    vec4 tex = vec4(0.06667, 0.07059, 0.08627, 1.);
    vec2 uv = screen_coords/love_ScreenSize.xy*2;
    vec2 true_uv = uv;

    number low = min(tex.r, min(tex.g, tex.b));
    number high = max(tex.r, max(tex.g, tex.b));
	number delta = high-low -0.1;
    number t = time * 0.025;

    uv.y = uv.y + 0.1*cos(0.0231*sin(t+uv.x));

    number fac = 0.8 + 0.7*sin(3.*(uv.y+(cos(t*0.32)))*uv.x + t*24. + cos(t*5.3 + uv.x*4.2 - uv.y*4.));
    number fac2 = 0.5 + 0.7*sin(8.*(uv.y+(sin(t*1.32)))*uv.x + t*10. - cos(t*2.3 + uv.x*8.2));
    number fac3 = 0.5 + 0.5*sin(5.*(uv.y+(cos(t*0.72)))*uv.x + t*6.111 + sin(t*5.3 + uv.x*3.2));
    number fac4 = 0.5 + 0.5*sin(6.*(uv.y+(sin(t*2.32)))*uv.x + t*8.111 + sin(t*1.3 + uv.y*11.2));
    number fac5 = sin(0.9*16.*uv.y+5.32*uv.x + t*12. + cos(t*5.3 + uv.y*4.2 - uv.x*4.));

    number maxfac = 0.7*max(max(fac, min(fac2*max(sin(t*uv.x*0.5), 0.0), max(fac3,0.0))) + (fac+fac2+fac3*fac4), 0.);

    tex.rgb = tex.rgb*0.25 + vec3(0.01, 0., 0.01);

    

    tex.r = tex.r + 0.05*maxfac*(0.7 - fac5*0.07);
    // tex.g = tex.g + 0.5*maxfac*(0.7 - fac5*0.27);
    tex.b = tex.b + 0.05*maxfac*0.7;
    tex.a = tex.a*(0.5*max(min(1., max(0.,0.3*max(low*0.2, delta) + min(max(maxfac*0.1,0.), 0.4)) ), 0.) + 0.15*maxfac*(0.1+delta));

    tex.rgb = mix(max(vec3(0,0,0), tex.rgb), colour.rgb, tex.a);

    vec2 cloud_passes[3];
    cloud_passes[0] = vec2(1, 0.2);
    cloud_passes[1] = vec2(2, 0.1);
    cloud_passes[2] = vec2(3, 0.05);
    for (int i = 0; i < 3; i++) {
        float layer = 3.71 * cloud_passes[i].x;
        vec2 coord = rot(true_uv*layer, vec2(1., 0.)*layer, true_uv.x*cloud_passes[i].x + t);
        tex.rgb += vec3(0.5,0.2,1) * pNoise(coord, 4) * cloud_passes[i].y;
    }

    vec2 star_passes[4];
    star_passes[0] = vec2(1, 0.6);
    star_passes[1] = vec2(2, 0.3);
    star_passes[2] = vec2(3, 0.1);
    star_passes[3] = vec2(4, 0.3);
    for (int i = 0; i < 4; i++) {
        float layer = 6 * star_passes[i].x;
        vec2 coord = rot(true_uv*layer, vec2(1., 0.)*layer, true_uv.x*star_passes[i].x + t);
        float p3 = pNoise(coord, 10 + 3 * i);
        if (p3 > (0.5 - i*0.025)) {
            tex.rgb += vec3(1,1,0.95) * star_passes[i].y;
        }
    }

    tex.a = alpha;

    return tex;
}