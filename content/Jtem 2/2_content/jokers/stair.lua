SMODS.Atlas({
	key = "jtem2_stair",
	path = "Jtem 2/jokers/stair.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "jtem2_stair_soul",
	path = "Jtem 2/jokers/stair_soul.png",
	px = 71,
	py = 95,
	frames = 4,
	atlas_table = "ANIMATION_ATLAS",
    fps = 7
})

SMODS.Joker({
	key = "jtem2_stair",

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
	ppu_artist = { "missingnumber" },


	atlas = "jtem2_stair",
    soul_atlas = "jtem2_stair_soul",
})