WORM_JTEM = {}

PotatoPatchUtils.Team({
	name = "jtem2",
	colour = HEX("ff4267"),
	loc = true,
	calculate = function(self, context) end,
	credit_rows = { 4, 3 },
})
PotatoPatchUtils.Developer({
	name = "aikoyori",
	colour = G.C.ORANGE,
	team = "jtem2",
	loc = true,
	-- pos = { x = 1, y = 0 },
	-- atlas = "atlas_key",
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
	-- pos = { x = 1, y = 0 },
	-- atlas = "atlas_key",
})
PotatoPatchUtils.Developer({
	name = "haya",
	colour = HEX("8772d6"),
	team = "jtem2",
	loc = true,
	-- pos = { x = 1, y = 0 },
	-- atlas = "atlas_key",
})
PotatoPatchUtils.Developer({
	name = "lexi",
	colour = SMODS.Gradient({
		key = "jtem2_lexi_color",
		colours = {
			HEX("ff75c9"),
			G.C.WHITE,
			G.C.ORANGE,
		},
		cycle = 2,
	}),
	team = "jtem2",
	loc = true,
	-- pos = { x = 1, y = 0 },
	-- atlas = "atlas_key",
})
PotatoPatchUtils.Developer({
	name = "ari",
	colour = G.C.ORANGE,
	team = "jtem2",
	loc = true,
	-- pos = { x = 1, y = 0 },
	-- atlas = "atlas_key",
})
PotatoPatchUtils.Developer({
	name = "missingnumber",
	colour = G.C.ORANGE,
	team = "jtem2",
	loc = true,
	-- pos = { x = 1, y = 0 },
	-- atlas = "atlas_key",
})
