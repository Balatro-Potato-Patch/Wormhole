local function build_nyarlathotep_entries(all_entries, max_cols, no_commas)
	max_cols = max_cols or 3
	local entries_to_organize = {}
	for _, e in ipairs(all_entries) do
		local loc_target = G.localization.descriptions.Other["worm_meow_nyarlathotep_" .. e.key].text_parsed
		for _, row in ipairs(loc_target) do
			entries_to_organize[#entries_to_organize + 1] = {
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = SMODS.localize_box(row, { text_colour = G.C.UI.TEXT_DARK, vars = e.vars }),
			}
		end
	end
	local rows = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {},
		},
	}
	for i, e in ipairs(entries_to_organize) do
		table.insert(rows[#rows].nodes, e)
		if i ~= #entries_to_organize then
			if i % max_cols == 0 then
				if not no_commas then
					table.insert(rows[#rows].nodes, {
						n = G.UIT.C,
						config = { align = "cm" },
						nodes = SMODS.localize_box(
							{ { strings = { "," }, control = {} } },
							{ text_colour = G.C.UI.TEXT_DARK }
						),
					})
				end
				rows[#rows + 1] = {
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {},
				}
			elseif not no_commas then
				table.insert(rows[#rows].nodes, {
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = SMODS.localize_box(
						{ { strings = { ", " }, control = {} } },
						{ text_colour = G.C.UI.TEXT_DARK }
					),
				})
			end
		end
	end
	local ret = {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = {
			{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = rows,
			},
		},
	}
	return ret
end

SMODS.Joker({
	key = "nyarlathotep",
	-- sprite and pos tbd
	config = {
		extra = {
			individual = {},
			joker_main = {},
			held_in_hand = {},
			exchange_options = {},
			misc = {},
		},
	},
	rarity = 3,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	calc_dollar_bonus = function(self, card)
		if card.config.extra.end_of_round.money then
			return card.config.extra.end_of_round.money
		end
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card)
		G.E_MANAGER:add_event(Event({}))
	end,
	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local main_end = {}
		local seen = false
		if next(cae.joker_main) then
			seen = true
			local entries = {}
			for _, entry in ipairs({
				"chips",
				"xchips",
				"mult",
				"xmult",
			}) do
				if cae.joker_main[entry] then
					entries[#entries + 1] = { vars = { cae.joker_main[entry] }, key = entry }
				end
			end
			main_end[#main_end + 1] = build_nyarlathotep_entries(entries, 2)
		end
		if next(cae.individual) then
			seen = true
			local entries = {}
			for _, entry in ipairs({
				"chips",
				"xchips",
				"mult",
				"xmult",
				"dollars",
			}) do
				if cae.individual[entry] then
					entries[#entries + 1] = { vars = { cae.individual[entry] }, key = entry }
				end
			end
			main_end[#main_end + 1] = build_nyarlathotep_entries(entries, 3)
		end
		if next(cae.held_in_hand) then
			seen = true
			local entries = {}
			for _, entry in ipairs({
				"chips",
				"xchips",
				"mult",
				"xmult",
				"dollars",
			}) do
				if cae.held_in_hand[entry] then
					entries[#entries + 1] = { vars = { cae.individual[entry] }, key = entry }
				end
			end
			main_end[#main_end + 1] = build_nyarlathotep_entries(entries, 3)
		end
		if next(cae.misc) then
			seen = true
			local entries = {}
			for _, key in ipairs(cae.misc) do
				local entry = Wormhole.TEAM_MEOW.nyarlathotep_exchanges[key]
				local vars = entry.loc_vars and entry:loc_vars(card) or {}
				entries[#entries + 1] = {
					vars = vars,
					key = entry.key,
				}
			end
			main_end[#main_end + 1] = build_nyarlathotep_entries(entries, 1)
		end
		if not seen then
			return {
				key = "j_worm_nyarlathotep_blank",
			}
		end
		return {
			main_end = main_end,
		}
	end,
	calculate = function(self, card, context)
		local cae = card.ability.extra
		local rets = {}
		if context.joker_main then
			rets[#rets + 1] = cae.joker_main
		end
		if context.individual and context.cardarea == G.play then
			rets[#rets + 1] = cae.individual
		end
		if context.individual and context.cardarea == G.hand then
			rets[#rets + 1] = cae.held_in_hand
		end
		if next(cae.misc) then
			for _, entry in ipairs(cae.misc) do
			end
			rets[#rets + 1] = {}
		end
		return SMODS.merge_effects(rets)
	end,
})

---@class NyarlathotepExchange
---@field key string
---@field cost integer
---@field reward fun(self: NyarlathotepExchange, card: Card): nil
---@field in_pool fun(self: NyarlathotepExchange, card: Card): boolean?
---@field config table
---@field loc_vars fun(self: NyarlathotepExchange, card: Card): table
---@field calculate fun(self: NyarlathotepExchange, card: Card, context: CalcContext): table?
---@field misc? boolean

---@class NyarlathotepExchangeArgs
---@field key string
---@field cost? integer
---@field reward? fun(self: NyarlathotepExchange, card: Card): nil
---@field in_pool? fun(self: NyarlathotepExchange, card: Card): boolean?
---@field config? table
---@field loc_vars? fun(self: NyarlathotepExchange, card: Card): table?
---@field calculate? fun(self: NyarlathotepExchange, card: Card, context: CalcContext): table?
---@field misc? boolean

---@type NyarlathotepExchange[]
Wormhole.TEAM_MEOW.nyarlathotep_exchanges_list = {}
---@type table<string, NyarlathotepExchange>
Wormhole.TEAM_MEOW.nyarlathotep_exchanges = {}

---@param args NyarlathotepExchangeArgs
---@return NyarlathotepExchange
function nyarlathotep_exchange(args)
	local final_key = "exc_" .. SMODS.current_mod.prefix .. "_" .. args.key
	local ex = {
		key = final_key,
		cost = args.cost or 1,
		reward = args.reward or function(self, card) end,
		in_pool = args.in_pool or function(self, card)
			return true
		end,
		config = args.config or {},
		calculate = args.calculate or function(self, card, context) end,
		misc = args.misc,
	}
	Wormhole.TEAM_MEOW.nyarlathotep_exchanges_list[#Wormhole.TEAM_MEOW.nyarlathotep_exchanges_list + 1] = ex
	Wormhole.TEAM_MEOW.nyarlathotep_exchanges[final_key] = ex
	return ex
end

function generate_exchange_item_ui(card, key)
	local desc_nodes = {}
	local ex_prototype = Wormhole.TEAM_MEOW.nyarlathotep_exchanges[key]
	local loc_res = ex_prototype:loc_vars(card) or {}
	local name_nodes = localize({ type = "name", key = key, set = "Other", vars = loc_res.vars or {} })
	localize({ type = "descriptions", key = key, set = "Other", nodes = desc_nodes, vars = loc_res.vars or {} })
	return {
		n = G.UIT.C,
		config = {
			align = "cm",
			colour = lighten(G.C.JOKER_GREY, 0.5),
			r = 0.1,
			emboss = 0.05,
			padding = 0.05,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cm",
					emboss = 0.05,
					r = 0.1,
					minw = 2.5,
					padding = 0.05,
					colour = lighten(G.C.BLACK, 0.2),
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { padding = 0.05 },
						nodes = name_nodes,
					},
					{
						n = G.UIT.R,
						config = {
							align = "cl",
							r = 0.1,
							padding = 0.05,
							emboss = 0.05,
							colour = G.C.WHITE,
						},
						nodes = { { n = G.UIT.R, config = { align = "cm", padding = 0.03 }, nodes = desc_nodes } },
					},
				},
			},
		},
	}
end

local default = nyarlathotep_exchange({
	key = "void",
	cost = 1,
	config = { mult = 10, xchips = 0.5 },
	reward = function(self, card)
		local cae = card.ability.extra
		cae.joker_main.mult = (cae.joker_main.mult or 0) + self.config.mult
		cae.joker_main.xchips = (cae.joker_main.xchips or 0) + self.config.xchips
	end,
	loc_vars = function(self, card)
		local cae = card.ability.extra
		return {
			vars = {
				self.config.mult,
				self.config.xchips,
				cae.joker_main.mult or 0,
				cae.joker_main.xchips or 0,
			},
		}
	end,
})

function Wormhole.TEAM_MEOW.generate_exchange_pool(card, seed)
	local results = {}
	local pool = {}
	for _, exchange in ipairs(Wormhole.TEAM_MEOW.nyarlathotep_exchanges_list) do
		if exchange:in_pool(card) then
			pool[#pool + 1] = exchange
		end
	end
	for i = 1, 3 do
		if #pool == 0 then
			results[#results + 1] = copy_table(default)
		else
			local index = pseudorandom(seed .. i, 1, #pool)
			results[#results + 1] = table.remove(pool, index)
		end
	end
	return results
end

function G.FUNCS.worm_meow_can_start_eldritch_encounter(e)
	local card = e.config.ref_table
	local locked = card:can_use_consumeable()
	if not locked and not card.debuff then
		e.config.colour = G.C.PURPLE
		e.config.button = "open_nyarlathotep_menu"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.open_nyarlathotep_menu(e)
	G.SETTINGS.paused = true
	Wormhole.TEAM_MEOW.in_nyarlathotep_exchange = true
	G.FUNCS.overlay_menu({
		definition = Wormhole.TEAM_MEOW.nyarlathotep_exchange_menu_UIdef(e.config.ref_table),
		config = {},
	})
end

local exit_overlay_menu_hook = G.FUNCS.exit_overlay_menu
function G.FUNCS.exit_overlay_menu(...)
	Wormhole.TEAM_MEOW.in_nyarlathotep_exchange = false
	return exit_overlay_menu_hook(...)
end

function Wormhole.TEAM_MEOW.nyarlathotep_exchange_menu_UIdef(card)
	local rows = {
		{
			n = G.UIT.R,
			config = {
				id = "overlay_menu_back_button",
				align = "cm",
				minw = 2.5,
				padding = 0.1,
				r = 0.1,
				hover = true,
				colour = G.C.ORANGE,
				button = "exit_overlay_menu",
				shadow = true,
				focus_args = { nav = "wide", button = "b" },
			},
			nodes = {
				{
					n = G.UIT.R,
					config = { align = "cm", padding = 0, no_fill = true },
					nodes = {
						{
							n = G.UIT.T,
							config = {
								text = localize("b_back"),
								scale = 0.5,
								colour = G.C.UI.TEXT_LIGHT,
								shadow = true,
							},
						},
					},
				},
			},
		},
	}
	return {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			minw = G.ROOM.T.w * 5,
			minh = G.ROOM.T.h * 5,
			padding = 0.1,
			r = 0.1,
			colour = { G.C.GREY[1], G.C.GREY[2], G.C.GREY[3], 0.7 },
		},
		nodes = {
			{
				n = G.UIT.R,
				config = { r = 0.1, colour = G.C.JOKER_GREY, padding = 0.05, align = "cm" },
				nodes = {
					{
						n = G.UIT.C,
						config = { colour = G.C.L_BLACK, r = 0.1, padding = 0.2, align = "cm" },
						nodes = rows,
					},
				},
			},
		},
	}
end

local highlight_hook = Card.highlight
function Card:highlight(is_highlighted, ...)
	local ret = highlight_hook(self, is_highlighted, ...)
	local obj = self.config.center
	if self.area == G.jokers and is_highlighted and obj.key == "j_worm_nyarlathotep" then
		---@type UIBox
		self.children.mul_joker_use_button = Wormhole.TEAM_MEOW.create_nyarlathotep_menu_button(self)
	end
	return ret
end

local buttons_hook = SMODS.DrawSteps["tags_buttons"].func
SMODS.DrawSteps["tags_buttons"].func = function(card, layer)
	buttons_hook(card, layer)
	if card.children.meow_nyarlathotep_menu_button and card.highlighted then
		card.children.meow_nyarlathotep_menu_button:draw()
	end
end

Wormhole.TEAM_MEOW.create_nyarlathotep_menu_button = function(card)
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR, align = "cm" },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					r = 0.08,
					align = "cl",
					padding = 0.1,
					hover = true,
					shadow = true,
					colour = G.C.UI.BACKGROUND_INACTIVE,
					minw = 1.63,
					func = "worm_meow_can_start_eldritch_encounter",
					ref_table = card,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("k_meow_eldritch"),
									scale = 0.3,
									colour = G.C.UI.TEXT_LIGHT,
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("k_meow_encounter"),
									scale = 0.3,
									colour = G.C.UI.TEXT_LIGHT,
								},
							},
						},
					},
				},
			},
		},
	}
end

SMODS.Sound({
	key = "nyarlathotep_ambience_music",
	path = "nyarlathotep_ambience.ogg",
	volume = 0.9,
	pitch = 1,
	sync = setmetatable({}, {
		__index = function(_, _)
			return true
		end,
	}),
	select_music_track = function(self)
		if Wormhole.TEAM_MEOW.in_nyarlathotep_exchange then
			return 666
		end
	end,
})

SMODS.Sound({
	key = "nyarlathotep_insanity_music",
	path = "nyarlathotep_insanity.ogg",
	volume = 0.6,
	pitch = 1,
	sync = setmetatable({}, {
		__index = function(_, _)
			return true
		end,
	}),
	select_music_track = function(self)
		if (G.GAME.meow_sanity_lost or 0) > 10 then
			return 666
		end
	end,
})
