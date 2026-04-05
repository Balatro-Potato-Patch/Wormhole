(* #if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define PRECISION highp
#else
	#define PRECISION mediump
#endif

extern PRECISION vec2 hole_coords;

/*

Author: Mirza Beig.

> https://x.com/TheMirzaBeig/status/2006021462818189411
> https://x.com/TheMirzaBeig/status/2006881499681825026

- https://twitter.com/TheMirzaBeig
- https://www.youtube.com/@MirzaBeig

CG: https://www.shadertoy.com/view/3fVBDw

*/
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec2 uv = screen_coords / love_ScreenSize.xy;

    // Normalized coordinates (UV).
    
    float aspectRatio = love_ScreenSize.x / love_ScreenSize.y;

    // Normalized mouse.
    
    vec2 mouse = hole_coords / love_ScreenSize.xy;
    
    // Track mouse.
    
    vec2 offsetToMouse = mouse - uv;
    offsetToMouse.x *= aspectRatio;
    
    float distanceToMouse = length(offsetToMouse);
    
    // Radial direction (toward gravitational source).
    
    vec2 directionToMouse = offsetToMouse / distanceToMouse;
    
    // Inverse-square falloff.
    
    float eventHorizonRadius = 1.0 / 12.0;
    float lensStrength = 1.0 / 512.0;
    
    float distanceToMouseSqr = distanceToMouse * distanceToMouse;
    
    float gravity = lensStrength / distanceToMouseSqr;
    float eventHorizonMask = step(eventHorizonRadius, distanceToMouse);
    
    // Radial displacement towards black hole.
    
    vec2 lensOffset = directionToMouse * gravity;    
    vec3 textureColour = Texel(texture, uv + lensOffset).rgb;
        
    vec3 black = vec3(0.0);
    
    vec4 res = vec4(0.);
    res.rgb = mix(black, textureColour, eventHorizonMask);
        
    res.a = 1.0;
    return res;
}

