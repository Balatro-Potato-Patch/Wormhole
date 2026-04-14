Wormhole.TEAM_MEOW = {}

Wormhole.TEAM_MEOW.DEBUG = false
local old = Game.init_game_object
function Game:init_game_object(...)
	local ret = old(self, ...)
	ret.max_foil_slots = 7
	return ret
end

local exit_mods_hook = G.FUNCS.exit_mods
function G.FUNCS.exit_mods(e, ...)
	local ret = exit_mods_hook(e, ...)
	love.mouse.setCursor()
end

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
	SMODS.Sound({
		key = "meowMeow" .. i,
		path = "TeamMeow/meow" .. i .. ".ogg",
	})
end
SMODS.Sound({
	key = "meowChomp",
	path = "TeamMeow/chomp.ogg",
})
SMODS.Sound({
	key = "meowSanctuary",
	path = "TeamMeow/3rdSanctuaryJolyne.ogg",
})
SMODS.Sound({
	key = "meowSwoon",
	path = "TeamMeow/swoonIncognito.ogg",
})
SMODS.Sound({
	key = "meowDread",
	path = "TeamMeow/dread.ogg",
	volume = 0.25,
	pitch = 1,
})
PotatoPatchUtils.Team({
	name = "meow",
	colour = HEX("F9D0D1"),
	loc = true,
	credit_rows = { 4, 4 },
	short_credit = true,
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
	pos = { x = 4, y = 0 },
	calculate = function(self, context)
		if context.setting_blind and G.GAME.meow_sanity_lost then
			return {
				x_blind_size = 1.25 ^ G.GAME.meow_sanity_lost,
			}
		end
	end,
})

PotatoPatchUtils.Developer({
	name = "corobo",
	colour = G.C.GOLD, -- Change this
	loc = true,
	team = "meow",
	atlas = "worm_meowCredits",
	pos = { x = 3, y = 0 },
	click_func = function(card)
		love.system.openURL("https://photonmodmanager.onrender.com/browse")
	end,
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
	pos = { x = 2, y = 0 },
})

PotatoPatchUtils.Developer({
	name = "gappie",
	colour = HEX("FFDE3B"),
	loc = true,
	team = "meow",
	atlas = "worm_meowCredits",
	pos = { x = 5, y = 0 },
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
	pos = { x = 0, y = 0 },
	click_func = function(card)
		love.system.openURL("https://golden-leaf.itch.io/")
	end,
})

loc_colour("red")
G.ARGS.LOC_COLOURS["incognito"] = HEX("D0D0D0")

PotatoPatchUtils.Developer({
	name = "incognito",
	colour = HEX("D0D0D0"),
	loc = true,
	team = "meow",
	atlas = "worm_meowCredits",
	pos = { x = 1, y = 0 },
	click_func = function(card)
		play_sound("worm_meowSwoon")
		love.system.openURL("https://github.com/IncognitoN71/Incognito")
	end,
})

local toma_colour = SMODS.Gradient({
	key = "toma_gradient",
	colours = {
		HEX("FCB3EA"),
		HEX("EAB3FC"),
		HEX("FCB3C5")
	},
	cycle = 5,
})

PotatoPatchUtils.Developer({
	name = "toma",
	colour = toma_colour,
	loc = true,
	team = "meow",
	atlas = "worm_meowCreditsJolyne",
	pos = { x = 0, y = 0 },
	click_func = function(card)
		play_sound("worm_meowSanctuary")
	end,
})

SMODS.Attribute({
	key = "cat",
	keys = { "j_lucky_cat" },
})
SMODS.Attribute({
	key = "spacetart",
	alias = { "tart" },
})

local card_click_hook = Card.click
function Card:click()
	card_click_hook(self)
	if (self.ppu_team or {}).name == "meow" then
		local member = self.ppu_member
		if member.click_func then
			member.click_func(self)
		end
	end
end

local hover_hook = Moveable.hover
function Moveable:hover()
	hover_hook(self)
	if (self.ppu_team or {}).name == "meow" then
		local member = self.ppu_member
		love.mouse.setCursor(Wormhole.TEAM_MEOW.cursor)
		self.children.center:set_sprite_pos({
			x = member.pos and member.pos.x or 0,
			y = 1,
		})
		local r = math.random(1, 3)
		play_sound("worm_meowMeow" .. r, 1 + 0.5 * (math.random() - 0.5), 0.6)
	end
end

local stop_hover_hook = Card.stop_hover
function Card:stop_hover()
	stop_hover_hook(self)
	if (self.ppu_team or {}).name == "meow" then
		local member = self.ppu_member
		love.mouse.setCursor()
		self.children.center:set_sprite_pos({ x = member.pos and member.pos.x or 0, y = 0 })
	end
end
