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
				"money",
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
				"money",
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
			for _, entry in ipairs(cae.misc) do
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
})

---@class NyarlathotepExchange
---@field key string
---@field cost integer
---@field reward fun(self: NyarlathotepExchange, card: Card): nil
---@field in_pool fun(self: NyarlathotepExchange, card: Card): boolean?
---@field config table
---@field loc_vars fun(self: NyarlathotepExchange, card: Card): table

---@class NyarlathotepExchangeArgs
---@field key string
---@field cost? integer
---@field reward? fun(self: NyarlathotepExchange, card: Card): nil
---@field in_pool? fun(self: NyarlathotepExchange, card: Card): boolean?
---@field config? table
---@field loc_vars? fun(self: NyarlathotepExchange, card: Card): table?

---@type NyarlathotepExchange[]
Wormhole.TEAM_MEOW.nyarlathotep_exchanges = {}

---@param args NyarlathotepExchangeArgs
---@return NyarlathotepExchange
function nyarlathotep_exchange(args)
	local ex = {
		key = "exc_" .. SMODS.current_mod.prefix .. "_" .. args.key,
		cost = args.cost or 1,
		reward = args.reward or function(self, card) end,
		in_pool = args.in_pool or function(self, card)
			return true
		end,
		config = args.config or {},
	}
	Wormhole.TEAM_MEOW.nyarlathotep_exchanges[#Wormhole.TEAM_MEOW.nyarlathotep_exchanges + 1] = ex
	return ex
end

local default = nyarlathotep_exchange({
	key = "greed",
	cost = 2,
	config = { money = 2 },
	reward = function(self, card)
		card.ability.extra.end_of_round.money = (card.ability.extra.end_of_round.money or 0) + self.config.money
	end,
	loc_vars = function(self, card)
		return {
			vars = {
				self.config.money,
				card.ability.extra.end_of_round.money or 0,
			},
		}
	end,
})

function Wormhole.TEAM_MEOW.generate_exchange_pool(card, seed)
	local results = {}
	local pool = {}
	for _, exchange in ipairs(Wormhole.TEAM_MEOW.nyarlathotep_exchanges) do
		if exchange:in_pool(card) then
			pool[#pool + 1] = exchange
		end
	end
	for i = 1, 3 do
		if #pool == 0 then
			results[#results + 1] = default
		else
			local index = pseudorandom(seed .. i, 1, #pool)
			results[#results + 1] = table.remove(pool, index)
		end
	end
	return results
end

function G.FUNCS.worm_meow_can_start_eldritch_encounter(e)
	local card = e.config.ref_table
	local obj = card.config.center
	local locked = (G.play and #G.play.cards > 0)
		or G.CONTROLLER.locked
		or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)
			and not (G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT)
	if not locked and not card.debuff then
		e.config.colour = G.C.GREEN
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	end
end

function G.FUNCS.open_nyarlathotep_menu(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({})
end

function Wormhole.TEAM_MEOW.nyarlathotep_exchange_menu_UIdef() end
