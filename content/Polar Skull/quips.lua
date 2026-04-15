SMODS.Font{
	key = "polarskull_noto",
	path = "Polar Skull/NotoEmoji.ttf"
}

local center = "polarskull_martian"
local particle_colours = {HEX("74cca8"), HEX("334461"), HEX("bfc7d5")}

local alien_quip = function(keyword, play_when, length)
	SMODS.JimboQuip{
		key = center..'_'..keyword,
		type = play_when,
		extra = {
			center = "j_worm_"..center,
			particle_colours = particle_colours,
			times = length * 2,
			delay = 0.25
		},
		play_sounds = function(self, times)
			if times % 2 == 0 then
				play_sound("worm_polarskull_alienquip"..math.random(5), nil, 0.6)
			end
		end
	}
end

alien_quip("party", "win", 3)
alien_quip("music", "win", 4)
alien_quip("world", "win", 4)
alien_quip("workout", "win", 4)
alien_quip("plsrocket", "loss", 4)
alien_quip("dumbass", "loss", 2)
alien_quip("broke", "loss", 4)
alien_quip("retry", "loss", 3)
