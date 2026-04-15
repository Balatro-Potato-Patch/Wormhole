WORM_JTEM = {}

SMODS.Atlas({
	key = "jtem2_creds",
	path = "Jtem 2/jteminspace.png",
	px = 71,
	py = 95,
})

SMODS.Gradient({
	key = "jtem2_rainbow",
	cycle = 1,
	colours = {
		HEX("FFB0B2"),
		HEX("FFD7B0"),
		HEX("FFFAB0"),
		HEX("BFFFB0"),
		HEX("B0FFED"),
		HEX("B0E7FF"),
		HEX("B0B0FF"),
		HEX("E0B0FF"),
	},
})

SMODS.Gradient({
	key = "jtem2_lexi",
	colours = {
		HEX("ff75c9"),
		G.C.WHITE,
		G.C.ORANGE,
	},
	cycle = 2,
})

-- why is smods.color not a thing even tho it's easy to hook for colours variables
-- the weather was fucking shit okay give me a break
SMODS.Gradient({
	key = "jtem2_teamcolor",
	cycle = 1,
	colours = {
		HEX("ff4267"),
		HEX("ff4267"),
	},
})

PotatoPatchUtils.Team({
	name = "jtem2",
	colour = HEX("ff4267"),
	loc = true,
	calculate = function(self, context) end,
	credit_rows = { 3, 3 },
})

PotatoPatchUtils.Developer({
	name = "aikoyori",
	colour = G.C.GREEN,
	team = "jtem2",
	loc = true,
	pos = { x = 0, y = 0 },
	atlas = "worm_jtem2_creds",
})
PotatoPatchUtils.Developer({
	name = "sleepyg11",
	colour = G.C.BLUE,
	team = "jtem2",
	loc = true,
	calculate = function(self, context)
		if WORM_JTEM.quantum_rock then
			WORM_JTEM.quantum_rock.calculate(context)
		end
	end,
	pos = { x = 1, y = 0 },
	atlas = "worm_jtem2_creds",
})
PotatoPatchUtils.Developer({
	name = "haya",
	colour = HEX("8772d6"),
	team = "jtem2",
	loc = true,
	pos = { x = 2, y = 0 },
	atlas = "worm_jtem2_creds",
})
PotatoPatchUtils.Developer({
	name = "lexi",
	colour = SMODS.Gradients["worm_jtem2_lexi"],
	team = "jtem2",
	loc = true,
	pos = { x = 0, y = 1 },
	atlas = "worm_jtem2_creds",
})
PotatoPatchUtils.Developer({
	name = "missingnumber",
	colour = SMODS.Gradients["worm_jtem2_rainbow"],
	team = "jtem2",
	loc = true,
	pos = { x = 1, y = 1 },
	atlas = "worm_jtem2_creds",
})
PotatoPatchUtils.Developer({
	name = "ari",
	colour = HEX('09d707'),
	team = "jtem2",
	loc = true,
	pos = { x = 2, y = 1 },
	atlas = "worm_jtem2_creds",
})
