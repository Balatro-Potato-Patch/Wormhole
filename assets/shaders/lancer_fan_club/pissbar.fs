uniform vec2 dims;
uniform vec2 pos;
uniform float fac;
uniform vec3 palette[4];
uniform sampler2D bubbles;

extern MY_HIGHP_OR_MEDIUMP number time;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {

	vec4 tex = Texel(texture, texture_coords);
	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;
	
	float progress = clamp(fac,0.,1.);
	bool flowEdge = !(floor(progress+.5)!=progress);
	
	vec4 c = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	float waveA = sin(uv.x*2.+time*progress*5.)/40.; // Flowing at edge of bar
	
	float waveB = sin(uv.y*4.+time*progress*-4.)/10.+.5; // Health bar flowing
	
	float waveC = sin(uv.y*.5+time*progress)/60.; // Bubble texture X offset
	
	
	waveA = flowEdge ? 0. : waveA; // Only flow if HP isn't full/empty
	waveB = waveB+uv.x*2.;
	
	waveB = waveB>2.&&!noSlime ? 2.-(waveB-2.)*1.5 : waveB;
	
	waveB += float(uv.y>(progress+waveA-1./dims.y) && !flowEdge)*.75;
	
	vec2 bubbleTexCoord = uv*dims/128.;
	bubbleTexCoord += vec2(waveC+.2,time*progress/11.-floor(time*progress/11.));
	bubbleTexCoord -= floor(bubbleTexCoord); // Like modulo, but better :3
	
	float bubbleTex = texture2D( bubbles, bubbleTexCoord ).x*.5;
	waveB = clamp(waveB-bubbleTex*float(!noSlime), 0.,3.);
	
	vec3 fac = mix(palette[int(floor(waveB))],palette[int(ceil(waveB))],waveB-floor(waveB));
	
	if ( uv.y<(progress+waveA) ) { vec4(fac,c.a) } else { discard; }
	
	return c;
}

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position ) {
	return transform_projection * vertex_position;
}
#endif