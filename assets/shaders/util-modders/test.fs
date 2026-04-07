extern float screen_scale;
extern float time;
extern float seed;
// Gold Noise ©2015 dcerisano@standard3d.com
// Taken from https://stackoverflow.com/a/28095165
float PHI = 1.61803398874989484820459;  // Φ = Golden Ratio   
float gold_noise(in vec2 xy, in float seed){
    return fract(tan(distance(xy*PHI, xy)*seed)*xy.x);
}

int random_range(vec2 xy, float seed, int min, int max) {
    float t = gold_noise(xy, seed); // [0, 1)
    return int(floor(t * (max - min + 1))) + min;
}

vec4 mixWhite(vec4 colour, float percent) {
    return mix(colour, vec4(1.0), percent);
}


// Main code
vec4 stars(vec2 coords, vec4 bg) {
    float noise = gold_noise(coords, seed);
    float brightness = (sin(time+coords.x+coords.y+noise) + 1);
    if (noise > 0.995) {
	return mixWhite(bg, brightness);
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
	for(int i=0;i<shootLengthTotal;++i) {
	    if (i > currLength) break;
	    float brightness = currLength - i;
	    if (brightness > 1.0) brightness = max(min(shootLengthMax - brightness, 1.0), 0.0);
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

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    // Setup
    vec4 bg = vec4(0.0, 0.0, 0.2, 1.0);
    vec2 coords = vec2(floor(screen_coords.x / screen_scale * 15), floor(screen_coords.y / screen_scale * 15));

    // Stars
    bg = stars(coords, bg);
    // Shooting stars
    bg = shootingStars(coords, bg);
    return bg;
}
