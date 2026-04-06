float PHI = 1.61803398874989484820459;  // Φ = Golden Ratio   

float gold_noise(in vec2 xy, in float seed){
       return fract(tan(distance(xy*PHI, xy)*seed)*xy.x);
}

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
	float noise = gold_noise(screen_coords, 1);
	if (noise > 0.999) {
		return vec4(1.0,1.0,1.0,1.0);
	}
	return vec4(0.0,0.0,0.0,1.0);
}
