Wormhole.TEAM_MEOW = {}

PotatoPatchUtils.Team({
	name = "meow",
	colour = HEX("F9D0D1"),
	loc = true,
})

local thunderedge_colour = SMODS.Gradient({
	key = "thunderedge_gradient",
	colours = {
		HEX("89C41B"),
		HEX("C5CC41"),
	},
	cycle = 1.5,
})

PotatoPatchUtils.Developer({
	name = "thunderedge",
	colour = thunderedge_colour,
	loc = true,
	team = "meow",
})

PotatoPatchUtils.Developer({
	name = "corobo",
	colour = G.C.GOLD, -- Change this
	loc = true,
	team = "meow",
})

PotatoPatchUtils.Developer({
	name = "revo",
	colour = HEX("7E7AFF"),
	loc = true,
	team = "meow",
})

PotatoPatchUtils.Developer({
	name = "gappie",
	colour = HEX("FFDE3B"),
	loc = true,
	team = "meow",
})

PotatoPatchUtils.Developer({
	name = "incognito",
	colour = HEX("D0D0D0"),
	loc = true,
	team = "meow",
})

PotatoPatchUtils.Developer({
	name = "toma",
	colour = HEX("FCB3EA"),
	loc = true,
	team = "meow",
})

local silverautumn_colour = SMODS.Gradient({
	key = "silverautumn_gradient",
	colours = {
		HEX("FF0044"),
		G.C.WHITE,
	},
	cycle = 3,
})

PotatoPatchUtils.Developer({
	name = "silverautumn",
	colour = silverautumn_colour,
	loc = true,
	team = "meow",
})
