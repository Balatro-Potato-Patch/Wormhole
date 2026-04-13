extern float screen_scale;
extern float time;
extern float seed;
extern float transparency;

extern vec3 nebula_color1;
extern vec3 nebula_color2;
extern vec3 nebula_color3;
extern bool shooting;

// Gold Noise ©2015 dcerisano@standard3d.com
// Taken from https://stackoverflow.com/a/28095165
float PHI = 1.61803398874989484820459;  // Φ = Golden Ratio   
float gold_noise(in vec2 xy, in float seed){
    return fract(tan(distance(xy * PHI, xy) * seed) * xy.x);
}

// Simplex 2D noise
// Based on https://github.com/ashima/webgl-noise
vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x * 34.0) + 1.0) * x); }

float snoise(vec2 v) {
    vec4 C = vec4(0.211324865405187, 0.366025403784439,
                  -0.577350269189626, 0.024390243902439);
    vec2 i = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;

    x12.xy -= i1;
    i = mod289(i);

    vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0));
    vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);

    m = m * m;
    m = m * m;

    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);

    vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;

    return 130.0 * dot(m, g);
}

// Fractal Brownian Motion.
// This gives us a smoother look compared to raw noise.
float fbm(vec2 p, float s) {
    float val = 0.0;
    float amp = 0.5;
    float freq = 1.0;
    for (int i = 0; i < 3; i++) {
        val += amp * snoise(p * freq + s);
        freq *= 2.0;
        amp *= 0.5;
    }
    return val;
}

vec4 nebula(vec2 coords) {
    vec2 uv = coords * 0.003;
    float s = seed * 13.37;

    // Warp the UV to create some patterned distortions. Goal here is to avoid a uniform noise pattern.
    vec2 warp = vec2(fbm(uv, s + 50.0), fbm(uv, s + 80.0));
    uv += warp * 0.4;

    // Map channels onto noise offsets
    float n1 = fbm(uv, s + 0.0);
    float n2 = fbm(uv, s + 100.0);
    float n3 = fbm(uv, s + 200.0);

    n1 = smoothstep(0.0, 0.8, n1 * 0.5 + 0.5);
    n2 = smoothstep(0.0, 0.8, n2 * 0.5 + 0.5);
    n3 = smoothstep(0.0, 0.8, n3 * 0.5 + 0.5);

    // Attempt to create some colour variation via re-sampling the noise.
    float dust = smoothstep(0.3, 0.6, fbm(uv * 2.0, s + 300.0) * 0.5 + 0.5);

    float shimmer = snoise(uv * 3.0 + time * 0.02) * 0.05;

    vec3 col = nebula_color1 * n1 + nebula_color2 * n2 + nebula_color3 * n3;
    col = col * 0.4 * dust + shimmer;
    col = max(col, 0.0);

    return vec4(col, 1.0);
}

int random_range(vec2 xy, float seed, int min, int max) {
    float t = gold_noise(xy, seed); // [0, 1)
    return int(floor(t * (max - min + 1))) + min;
}

vec4 mixWhite(vec4 colour, float percent) {
    return mix(colour, vec4(1.0), percent);
}

// Select a star colour based on an emulated "temperature class".
// This is a simple mapping of gold noise onto star colours, but it's fun to pretend.
vec3 star_tint(vec2 coords) {
    float t = gold_noise(coords, seed + 1.0);
    // In order, blue-white, white-yellow, yellow, orange-red
    if (t < 0.3) return vec3(0.7, 0.8, 1.0);
    if (t < 0.7) return vec3(1.0, 1.0, 0.95);
    if (t < 0.9) return vec3(1.0, 0.9, 0.6);
    return vec3(1.0, 0.7, 0.4);
}

// Main code
vec4 stars(vec2 coords, vec4 bg, float nebula_density) {
    float noise = gold_noise(coords, seed);

    // Add an out of phase brightness component for that cute twinkle effect. (Tinkle effect haha)
    float phase = gold_noise(coords, seed + 2.0) * 6.28;
    float twinkle = sin(time * 3.0 + phase) * sin(time * 5.0 + phase * 2.0);
    float brightness = clamp(twinkle * 0.5 + 0.7, 0.2, 1.0);

    // Cluster stars more tighly around nebulae
    float cluster = clamp(nebula_density * 6.0, 0.0, 1.0);
    float threshold = 0.997 - cluster * 0.006;

    if (noise > threshold) {
	    vec3 tint = star_tint(coords);
	    return vec4(mix(bg.rgb, tint, brightness), 1.0);
    }

    // Emulate the look of bright stars by "bleeding" their illuminance onto surrounding pixels.
    // Ref images on https://en.wikipedia.org/wiki/Nebula
    for (int dx = -1; dx <= 1; dx++) {
        for (int dy = -1; dy <= 1; dy++) {
            if (dx == 0 && dy == 0) { 
                continue;
            }

            if (abs(dx) + abs(dy) > 1) { 
                continue; 
            }

            vec2 neighbor = coords + vec2(dx, dy);
            float n = gold_noise(neighbor, seed);
            if (n > 0.9995) {
                float p = gold_noise(neighbor, seed + 2.0) * 6.28;
                float b = clamp(sin(time * 3.0 + p) * sin(time * 7.0 + p * 2.0) * 0.5 + 0.7, 0.2, 1.0) * 0.4;
                vec3 tint = star_tint(neighbor);
                bg = vec4(mix(bg.rgb, tint, b), 1.0);
            }
        }
    }

    return bg;
}

vec4 shootingStars(vec2 coords, vec4 bg) {
    float shootTimeMax = .2;
    float shootLengthTotal = 50;
    float shootLengthMax = 5;
    float shootLengthEnd = 5;
    float skip = 4;
    float shootIteration = floor(time / shootTimeMax);

    if (mod(shootIteration, skip + 1) == 0) {
        float shootTimer = mod(time, shootTimeMax);
        float shootingx = random_range(vec2(shootIteration, shootIteration), seed, 20, 320);
        float shootingy = random_range(vec2(shootIteration, shootIteration), seed, 20, 200);
        float percent = shootTimer / shootTimeMax;
        float currLength = shootLengthTotal * percent + shootLengthEnd * percent;

        for(int i=0; i < shootLengthTotal; ++i) {
            if (i > currLength) {
                break;
            }

            float brightness = currLength - i;
            if (brightness > 1.0) {
                brightness = max(min(shootLengthMax - brightness, 1.0), 0.0);
            }

            if (coords.x == shootingx - i && coords.y == shootingy + i) {
                return mixWhite(bg, brightness);
            }
        }
        // Debug
        //    if (coords.x == shootingx) {
        // return vec4(1.0, 0.0, 0.0, 1.0);
        //    }
        //    if (coords.y == shootingy) {
        // return vec4(0.0, 1.0, 0.0, 1.0);
        //    }
    }
    return bg;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // Setup
    vec2 coords = vec2(floor(screen_coords.x / screen_scale), floor(screen_coords.y / screen_scale));
    vec4 bg = nebula(coords);
    float nebula_density = (bg.r + bg.g + bg.b) / 3.0;

    // Stars
    bg = stars(coords, bg, nebula_density);

    // Shooting stars
    if (shooting) {
        bg = shootingStars(coords, bg);
    }

    if (transparency == 1.0) {
        return bg;
    }

    return mix(Texel(texture, texture_coords), bg, transparency);
}
