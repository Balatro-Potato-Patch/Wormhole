#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

//Ben Roffey / Team People Found In Vegas
//Wormhole Mod

extern PRECISION vec2 CRTshutoff; //apprently this is required even though I don't use it

extern PRECISION float startTime; //Time from G.TIMERS.REAL at the point of triggering
extern PRECISION float time; //G.TIMERS.REAL

vec4 effect( vec4 colour, Image tex, vec2 texture_coords, vec2 screen_coords )
{
    float progress = time - startTime;

    //CRT shutoff effect happens over 2 seconds

    //As progress goes from 0 to 1.2, pixels will shrink inwards from the top and bottom edges
    //Then, when there is just a bar in the middle, the sides shrink inwards to a point
    //Also, the colour becomes more and more white

    //As progress goes from 1.2 to 2, pixels expand outward again
    //Fading from a bright white back to their normal colour

    //Otherwise, doesn't change the screen in any way

    vec2 uv = texture_coords;

    vec2 shrinkSpeed = vec2(2.5, 4);    //How quickly the screen shrinks, x and y
    float shrinkBrightnessRate = 1.0;   //A multiplier for progress to make the screen brighter
    float minScale = 0.001;             //The minimum scale of x and y, leaving a bar on the screen
    vec2 expandSpeed = vec2(4, 4);      //How quickly the screen expands, x and y
    float expandBrightnessRate = 1.2;   //A multiplier for progress to dim the screen back to usual colours

    float y_scale = 1; //amount to shrink along y
    if (progress <= 1.2) {
        y_scale = max(minScale, 1.0 - progress * shrinkSpeed.y); 
    }
    else{
        y_scale = min(1, 0.0 + (progress - 1.2) * expandSpeed.y); 
    }
    uv.y = (uv.y - 0.5) / y_scale + 0.5;

    float x_scale = 1; //amount to shrink along x
    if (y_scale == minScale) {
        x_scale = max(minScale, 2 - progress * shrinkSpeed.x);
    }
    if (progress > 1.2) {
        x_scale = min(1, (progress - 1.2) * expandSpeed.x);
    }

    if (y_scale == minScale && x_scale == minScale) {
        y_scale = 0;
        x_scale = 0;
    }
    
    uv.x = (uv.x - 0.5) / x_scale + 0.5;

    //Turn everything outside the collapsing bounds black
    if (uv.y < 0.0 || uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0) {
        return vec4(0.0, 0.0, 0.0, 1.0); 
    }

    vec4 col = Texel(tex, uv);
    float glow = 1.0;
    if (progress > 0) {
        glow = 1.0 + (progress * shrinkBrightnessRate) * 50.0; //As it gets smaller, it gets brighter
    }
    if (progress > 1.2) {
        glow = max(1, 1.0 + (2 - progress * expandBrightnessRate) * 20.0); //As it gets bigger, it returns to normal brightness
    }

    return col * colour * glow;
}