-- https://stackoverflow.com/questions/2353211/hsl-to-rgb-color-conversion
local function hsl2rgb(h,s,l,al) 
    local a=s*math.min(l,1-l);
    local f = function(n, k) k = math.fmod((n+h/30),12); return l - a*math.max(math.min(k-3,9-k,1),-1) end
    return {f(0),f(8),f(4),al};
end

SMODS.DynaTextEffect {
    key = "jtem2_obfuscate",
    func = function (dynatext, index, letter)
        letter.letter = love.graphics.newText(dynatext.font.FONT, string.char(math.fmod((string.byte(letter.char) + math.fmod(math.floor(G.TIMERS.REAL * 142.1 + index), 192)), 94)+ 33))
    end
}

SMODS.DynaTextEffect {
    key = "jtem2_rainbow_wiggle",
    func = function (dynatext, index, letter)
        letter.colour = hsl2rgb(math.fmod((G.TIMERS.REAL + index) * 50, 360), 1, 0.75)
        letter.offset.y = math.cos(G.TIMERS.REAL * 2.95 + index) * 9
        letter.scale = (((math.sin((G.TIMERS.REAL + index)*2.9443) + 1)/2) + 6 )/6
    end
}
SMODS.DynaTextEffect {
    key = "jtem2_snaking",
    func = function (dynatext, index, letter)
        letter.offset.x = math.sin((G.TIMERS.REAL + index) * 7.95) * 7
        letter.offset.y = math.cos((G.TIMERS.REAL + index) * 7.95) * 7
    end
}
SMODS.DynaTextEffect {
    key = "jtem2_shrivel",
    func = function (dynatext, index, letter)
        letter.offset.x = math.sin((G.TIMERS.REAL * 14511.15 + index * 534.415) * 7.95) * 5
        letter.offset.y = math.cos((G.TIMERS.REAL * 534.15 + index * 14511.415) * 7.95) * 5
    end
}
SMODS.DynaTextEffect {
    key = "jtem2_exponent",
    func = function (dynatext, index, letter)
        letter.offset.y = 20
        letter.offset.x = 20
    end
}