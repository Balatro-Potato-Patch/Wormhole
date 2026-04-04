Wormhole.TEAM_MEOW = {}

Wormhole.TEAM_MEOW.DEBUG = false

SMODS.Atlas({
	key = "meowCredits",
	px = 71,
	py = 95,
	path = "TeamMeow/creditCards.png",
})
SMODS.Atlas({
	key = "meowCreditsJolyne",
	px = 107,
	py = 100,
	path = "TeamMeow/creditCardsJolyne.png",
})
SMODS.Atlas({
	key = "meowPaw",
	px = 40,
	py = 38,
	path = "TeamMeow/paw.png",
})
G.E_MANAGER:add_event(Event({
	trigger = "after",
	delay = 0,
	func = function()
		Wormhole.TEAM_MEOW.cursor = love.mouse.newCursor(G.ASSET_ATLAS.worm_meowPaw.image_data, 20, 19)
		return true
	end,
}))
for i = 1, 3 do
	SMODS.Sound {
		key = "meowMeow"..i,
		path = "TeamMeow/meow"..i..".ogg",
	}
end
SMODS.Sound {
	key = "meowChomp",
	path = "TeamMeow/chomp.ogg",
}
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
	atlas = "worm_meowCredits",
	pos = { x = 4, y = 0 }
})

PotatoPatchUtils.Developer({
	name = "corobo",
	colour = G.C.GOLD, -- Change this
	loc = true,
	team = "meow",
	atlas = "worm_meowCredits",
	pos = {x = 3, y = 0}
})

local revo_colour = SMODS.Gradient({
	key = "revo_gradient",
	colours = {
		HEX("7e7aff"),
		HEX("c57aff"),
	},
	cycle = 2,
})
PotatoPatchUtils.Developer({
	name = "revo",
	colour = revo_colour,
	loc = true,
	team = "meow",
	atlas = "worm_meowCredits",
	pos = { x = 2, y = 0 }
})

PotatoPatchUtils.Developer({
	name = "gappie",
	colour = HEX("FFDE3B"),
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
	atlas = "worm_meowCredits",
	pos = { x = 0, y = 0 }
})

loc_colour('red')
G.ARGS.LOC_COLOURS['incognito'] = HEX("D0D0D0")

PotatoPatchUtils.Developer({
	name = "incognito",
	colour = HEX("D0D0D0"),
	loc = true,
	team = "meow",
	atlas = "worm_meowCredits",
	pos = { x = 1, y = 0 }
})

PotatoPatchUtils.Developer({
	name = "toma",
	colour = HEX("FCB3EA"),
	loc = true,
	team = "meow",
	atlas = "worm_meowCreditsJolyne",
	pos = { x = 0, y = 0 }
})

