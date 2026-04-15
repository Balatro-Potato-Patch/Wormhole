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
	colour = HEX("09d707"),
	team = "jtem2",
	loc = true,
	pos = { x = 2, y = 1 },
	atlas = "worm_jtem2_creds",
})

-- This should be moved somewhere else if possible....
-- Annoyingly, Potato Patch credits will override this, so extend from potato patch instead
-- Plus, too lazy to localize
local prev_extra_tabs = PotatoPatchUtils.CREDITS.register_page
PotatoPatchUtils.CREDITS.register_page = function(mod)
	local t = prev_extra_tabs and prev_extra_tabs(mod)() or {}
	local tt = { t }
	-- Prevent other Potato Patch mods from adding the keybinds menu LMAO
	if mod ~= Wormhole then
		return tt
	end
	table.insert(tt, {
		label = "Jtem 2 config",
		tab_definition_function = function()
			return {
				n = G.UIT.ROOT,
				config = {
					r = 0.1,
					padding = 0.2,
					colour = G.C.BLACK,
					align = "cm",
				},
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.05,
						},
						nodes = {
							create_toggle({
								label = "Quantum Rock",
								ref_table = WORM_JTEM.quantum_rock,
								ref_value = "enabled",
							}),
						},
					},
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							padding = 0.05,
						},
						nodes = {
							JtemTGM.UI.CreateSection("Tetris - Piece movement"),
							JtemTGM.UI.CreateKeybindUI("Move piece left", "move_left"),
							JtemTGM.UI.CreateKeybindUI("Move piece right", "move_right"),
							JtemTGM.UI.CreateKeybindUI("Move piece down", "move_down"),
							JtemTGM.UI.CreateKeybindUI("Sonic drop", "sonic_drop"),
							JtemTGM.UI.CreateSection("Tetris - Piece manipulation"),
							JtemTGM.UI.CreateKeybindUI("Rotate piece left", "rotate_left"),
							JtemTGM.UI.CreateKeybindUI("Rotate piece right", "rotate_right"),
							JtemTGM.UI.CreateKeybindUI("Hold piece", "hold"),
						},
					},
				},
			}
		end,
	})

	return function()
		return tt
	end
end
