local function build_nyarlathotep_entries(all_entries, max_cols, no_commas, all_rows)
	max_cols = max_cols or 3
	local entries_to_organize = {}
	for _, e in ipairs(all_entries) do
		local desc_nodes = {}
		localize({
			type = "other",
			key = e.no_auto_key and e.key or ("worm_meow_nyarlathotep_" .. e.key),
			nodes = desc_nodes,
			vars = e.vars or {},
		})
		for _, row in ipairs(desc_nodes) do
			entries_to_organize[#entries_to_organize + 1] = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = row,
			}
		end
	end
	local comma_node = {}
	localize({
		type = "other",
		key = "worm_meow_nyarlathotep_commas",
		nodes = comma_node,
		vars = {},
	})
	local comma_row = {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = comma_node[1],
	}
	local comma_row_with_space = {
		n = G.UIT.R,
		config = { align = "cm" },
		nodes = comma_node[2],
	}
	local rows = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {},
		},
	}
	for i, e in ipairs(entries_to_organize) do
		table.insert(rows[#rows].nodes, { n = G.UIT.C, config = { align = "cm" }, nodes = { e } })
		if i ~= #entries_to_organize then
			if i % max_cols == 0 then
				if not no_commas then
					table.insert(rows[#rows].nodes, { n = G.UIT.C, config = { align = "cm" }, nodes = { comma_row } })
				end
				rows[#rows + 1] = {
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {},
				}
			elseif not no_commas then
				table.insert(rows[#rows].nodes, { n = G.UIT.C, config = { align = "cm" }, nodes = { comma_row_with_space } })
			end
		end
	end
	for _, r in ipairs(rows) do
		all_rows[#all_rows + 1] = r
	end
end

SMODS.Joker({
	key = "meow_nyarlathotep",
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
	atlas = "meow_jokers",
	pos = { x = 1, y = 0 },
	cost = 8,
	attributes = { "cat", "space", "spacetart", "xblindsize", "mult", "xchips", "economy", "scaling" },
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	calc_dollar_bonus = function(self, card) end,
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
			build_nyarlathotep_entries(entries, 2, nil, main_end)
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
			build_nyarlathotep_entries({ { key = "on_score" } }, 1, nil, main_end)
			build_nyarlathotep_entries(entries, 3, nil, main_end)
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
					entries[#entries + 1] = { vars = { cae.held_in_hand[entry] }, key = entry }
				end
			end
			build_nyarlathotep_entries({ { key = "held_in_hand" } }, 1, nil, main_end)
			build_nyarlathotep_entries(entries, 3, nil, main_end)
		end
		if next(cae.misc) then
			seen = true
			local entries = {}
			for _, power in ipairs(cae.misc) do
				local entry = Wormhole.TEAM_MEOW.nyarlathotep_exchanges[power.key]
				local vars = entry.loc_vars and entry:loc_vars(card, power.amt) or {}
				entries[#entries + 1] = {
					vars = vars.vars,
					key = entry.key,
					no_auto_key = true,
				}
			end
			build_nyarlathotep_entries(entries, 1, true, main_end)
		end
		if not seen then
			return {
				key = "j_worm_meow_nyarlathotep_blank",
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
			for _, power in ipairs(cae.misc) do
				local entry = Wormhole.TEAM_MEOW.nyarlathotep_exchanges[power.key]
				rets[#rets + 1] = entry:calculate(card, context, power.amt) or {}
			end
		end
		return SMODS.merge_effects(rets)
	end,
	add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			G.GAME.meow_sanity_lost = G.GAME.meow_sanity_lost or 0
			card.ability.extra.exchange_options =
				Wormhole.TEAM_MEOW.generate_exchange_pool(card, "nyarlathotep_exchanges")
		end
	end,
	ppu_team = { "meow" },
	ppu_coder = { "thunderedge" },
	ppu_artist = { "silverautumn" },
})

---@class NyarlathotepExchange
---@field key string
---@field cost integer
---@field reward fun(self: NyarlathotepExchange, card: Card): nil
---@field in_pool fun(self: NyarlathotepExchange, card: Card, amt: number?): boolean?
---@field config table
---@field loc_vars fun(self: NyarlathotepExchange, card: Card, amt: number?): table
---@field calculate fun(self: NyarlathotepExchange, card: Card, context: CalcContext, amt: number?): table?
---@field misc? boolean

---@class NyarlathotepExchangeArgs
---@field key string
---@field cost? integer
---@field reward? fun(self: NyarlathotepExchange, card: Card): nil
---@field in_pool? fun(self: NyarlathotepExchange, card: Card, amt: number?): boolean?
---@field config? table
---@field loc_vars? fun(self: NyarlathotepExchange, card: Card, amt: number?): table?
---@field calculate? fun(self: NyarlathotepExchange, card: Card, context: CalcContext, amt: number): table?
---@field misc? boolean

---@type NyarlathotepExchange[]
Wormhole.TEAM_MEOW.nyarlathotep_exchanges_list = {}
---@type table<string, NyarlathotepExchange>
Wormhole.TEAM_MEOW.nyarlathotep_exchanges = {}

---@param args NyarlathotepExchangeArgs
---@return NyarlathotepExchange
local function nyarlathotep_exchange(args)
	local final_key = "exc_" .. SMODS.current_mod.prefix .. "_meow_" .. args.key
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
		loc_vars = args.loc_vars or function(self, card) end,
	}
	Wormhole.TEAM_MEOW.nyarlathotep_exchanges_list[#Wormhole.TEAM_MEOW.nyarlathotep_exchanges_list + 1] = ex
	Wormhole.TEAM_MEOW.nyarlathotep_exchanges[final_key] = ex
	return ex
end

local function generate_exchange_item_ui(card, option)
	local desc_nodes = {}
	local cost_nodes = {}
	local ex_prototype = Wormhole.TEAM_MEOW.nyarlathotep_exchanges[option.key]
	local amt = nil
	for _, power in ipairs(card.ability.extra.misc) do
		if power.key == option.key then
			amt = power.amt
		end
	end
	local loc_res = ex_prototype:loc_vars(card, amt) or {}
	local name_nodes = localize({ type = "name", key = option.key, set = "Other", vars = loc_res.vars or {} })
	localize({ type = "other", key = option.key, nodes = desc_nodes, vars = loc_res.vars or {} })

	if ex_prototype.cost > 0 then
		localize({ type = "other", key = "exc_worm_meow_sanity_cost", nodes = cost_nodes, vars = { ex_prototype.cost } })
	elseif ex_prototype.cost < 0 then
		localize({
			type = "other",
			key = "exc_worm_meow_sanity_gain",
			nodes = cost_nodes,
			vars = { -ex_prototype.cost },
		})
	else
		localize({ type = "other", key = "exc_worm_meow_sanity_free", nodes = cost_nodes, vars = {} })
	end

	local desc = {}
	for _, v in ipairs(desc_nodes) do
		desc[#desc + 1] = { n = G.UIT.R, config = { align = "cm" }, nodes = v }
	end
	local cost = {}
	for _, v in ipairs(cost_nodes) do
		cost[#cost + 1] = { n = G.UIT.R, config = { align = "cm" }, nodes = v }
	end
	local infobox = {
		n = G.UIT.R,
		config = {
			align = "cm",
			colour = lighten(G.C.JOKER_GREY, 0.5),
			r = 0.12,
			emboss = 0.07,
			padding = 0.05,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					align = "cm",
					r = 0.1,
					minw = 2.5,
					padding = 0.07,
					colour = lighten(G.C.BLACK, 0.2),
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { padding = 0.05, align = "cm" },
						nodes = name_nodes,
					},
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							r = 0.1,
							padding = 0.05,
							emboss = 0.05,
							colour = G.C.WHITE,
							minw = 2.4,
						},
						nodes = { { n = G.UIT.R, config = { align = "cm", padding = 0.03 }, nodes = desc } },
					},
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							r = 0.1,
							padding = 0.05,
							emboss = 0.05,
							colour = G.C.WHITE,
							minw = 2.4,
						},
						nodes = { { n = G.UIT.R, config = { align = "cm", padding = 0.03 }, nodes = cost } },
					},
				},
			},
		},
	}
	exchanged_table = {
		localize("k_worm_meow_exchange"),
		localize("k_worm_meow_exchanged"),
	}
	return {
		n = G.UIT.C,
		config = { padding = 0.1, align = "cm" },
		nodes = {
			infobox,
			{
				n = G.UIT.R,
				config = {
					r = 0.1,
					padding = 0.1,
					hover = true,
					shadow = true,
					align = "cm",
					colour = G.C.ORANGE,
					ref_table = card,
					button = "worm_meow_exchange_reward",
					exchange_option = option,
					func = "worm_meow_can_exchange_reward",
				},
				nodes = {
					{
						n = G.UIT.T,
						config = {
							ref_table = setmetatable({}, {
								__index = function(_, _)
									return exchanged_table[option.is_exchanged and 2 or 1]
								end,
							}),
							ref_value = "is_exchanged",
							scale = 0.4,
							colour = G.C.UI.TEXT_LIGHT,
						},
					},
				},
			},
		},
	}
end

function G.FUNCS.worm_meow_exchange_reward(e)
	local card = e.config.ref_table
	local exchange = Wormhole.TEAM_MEOW.nyarlathotep_exchanges[e.config.exchange_option.key]
	if exchange.misc then
		local found = false
		for _, power in ipairs(card.ability.extra.misc) do
			if power.key == e.config.exchange_option.key then
				power.amt = power.amt + 1
				found = true
			end
		end
		if not found then
			card.ability.extra.misc[#card.ability.extra.misc + 1] = { key = exchange.key, amt = 1 }
		end
	end
	exchange:reward(card)
	G.GAME.meow_sanity_lost = math.max(0, G.GAME.meow_sanity_lost + exchange.cost)
	e.config.exchange_option.is_exchanged = true
	local element = G.OVERLAY_MENU:get_UIE_by_ID("meow_exchanges")
	element.config.object:remove()
	element.config.object = UIBox({
		definition = Wormhole.TEAM_MEOW.generate_exchanges_UIdef(card),
		config = { type = "cm", parent = element },
	})
	element.UIBox:recalculate()
end

function G.FUNCS.worm_meow_can_exchange_reward(e)
	local exchanged = e.config.exchange_option.is_exchanged

	local exchange = Wormhole.TEAM_MEOW.nyarlathotep_exchanges[e.config.exchange_option.key]
	local can_afford = G.GAME.meow_sanity_lost + exchange.cost >= 0

	if exchanged or not can_afford then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		e.config.colour = G.C.ORANGE
		e.config.button = "worm_meow_exchange_reward"
	end
end

--[[
To make an exchange for Nyarlathotep:

Check NyarlathotepExchangeArgs above for the parameters.
If you define a calc function, it will not trigger unless you set
misc = true within the exchange. Its loc entry should be put under
descriptions.Other["exc_mod prefix_meow_your key here"].
loc_vars does not support info_queue - in order to display info
about a particular center object, use {T:center_key} within the
localization entry. Exchange options also don't support scaling
the option itself.

reward is called when the exchange button is pressed. card represents
Nyarlathotep, which allows you to modify Nyarlathotep's values.
The following functionality is handled by Nyarlathotep, and you don't
need to make a calc function for these effects:
joker_main - chips, xchips, mult, xmult
held_in_hand - dollars, chips, xchips, mult, xmult
individual (when card is scored) - dollars, chips, xchips, mult, xmult
See below for examples.

amt is only passed into calculate and loc_vars if misc is truthy.
amt is for stacking purposes and to prevent duplicate loc entries.
]]

local default = nyarlathotep_exchange({
	key = "void",
	cost = 1,
	config = { mult = 10, xchips = 0.5 },
	reward = function(self, card)
		local cae = card.ability.extra
		cae.joker_main.mult = (cae.joker_main.mult or 0) + self.config.mult
		cae.joker_main.xchips = (cae.joker_main.xchips or 1) + self.config.xchips
	end,
	loc_vars = function(self, card)
		local cae = card.ability.extra
		return {
			vars = {
				self.config.mult,
				self.config.xchips,
				cae.joker_main.mult or 0,
				cae.joker_main.xchips or 1,
			},
		}
	end,
})

nyarlathotep_exchange({
	key = "greed",
	cost = 1,
	config = { money = 30 },
	reward = function(self, card)
		ease_dollars(self.config.money)
	end,
	loc_vars = function(self, card)
		return {
			vars = {
				self.config.money,
			},
		}
	end,
})

nyarlathotep_exchange({
	key = "remembrance",
	cost = 2,
	config = { antes = 1 },
	reward = function(self, card)
		ease_ante(-self.config.antes)
		G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
		G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - self.config.antes
		G.GAME.meow_remembrance_exchanged = true
	end,
	loc_vars = function(self, card)
		return {
			vars = {
				self.config.antes,
				self.config.antes > 1 and localize("k_worm_meow_plural") or "",
			},
		}
	end,
	in_pool = function(self, card, amt)
		return not G.GAME.meow_remembrance_exchanged
	end,
})

nyarlathotep_exchange({
	key = "gluttony",
	cost = 1,
	config = { extracted_mult = 5, extracted_chips = 5 },
	reward = function(self, card)
		local cae = card.ability.extra

		cae.individual.chips = self.config.extracted_chips + (cae.individual.chips or 0)
		cae.individual.mult = self.config.extracted_mult + (cae.individual.mult or 0)
	end,
	loc_vars = function(self, card)
		local cae = card.ability.extra
		return {
			vars = {
				self.config.extracted_mult,
				self.config.extracted_chips,
				cae.individual.mult or 0,
				cae.individual.chips or 0,
			},
		}
	end,
})

nyarlathotep_exchange({
	key = "sloth",
	cost = 2,
	config = { sloth_xchips = 0.1 },
	reward = function(self, card)
		local cae = card.ability.extra

		cae.held_in_hand.xchips = self.config.sloth_xchips + (cae.held_in_hand.xchips or 1)
	end,
	loc_vars = function(self, card)
		local cae = card.ability.extra
		return {
			vars = {
				self.config.sloth_xchips,
				cae.held_in_hand.xchips or 1,
			},
		}
	end,
})

nyarlathotep_exchange({
	key = "acceptance",
	cost = -1,
	config = { xchips_retained = 0.75 },
	reward = function(self, card)
		local cae = card.ability.extra

		cae.joker_main.xchips = self.config.xchips_retained * (cae.joker_main.xchips or 1)
	end,
	loc_vars = function(self, card)
		local cae = card.ability.extra
		return {
			vars = {
				self.config.xchips_retained * 100,
				cae.joker_main.xchips or 1,
			},
		}
	end,
	in_pool = function(self, card, amt)
		return G.GAME.meow_sanity_lost > 0
	end,
})

nyarlathotep_exchange({
	key = "reward",
	cost = 0,
	config = {},
	reward = function(self, card)
		ease_dollars(G.GAME.meow_sanity_lost)
	end,
	loc_vars = function(self, card)
		return {
			vars = {
				G.GAME.meow_sanity_lost,
			},
		}
	end,
	in_pool = function(self, card, amt)
		return G.GAME.meow_sanity_lost > 0
	end,
})

nyarlathotep_exchange({
	key = "silence",
	cost = -2,
	config = {},
	reward = function(self, card)
		if G.jokers.cards[#G.jokers.cards].config.center.key == "j_worm_meow_nyarlathotep" then
			G.jokers.cards[#G.jokers.cards - 1]:juice_up(0.8, 0.8)
			G.jokers.cards[#G.jokers.cards - 1]:add_sticker("eternal", true)
			SMODS.debuff_card(G.jokers.cards[#G.jokers.cards - 1], true, "meow_nyarlathotep_silence")
		else
			G.jokers.cards[#G.jokers.cards]:juice_up(0.8, 0.8)
			G.jokers.cards[#G.jokers.cards]:add_sticker("eternal", true)
			SMODS.debuff_card(G.jokers.cards[#G.jokers.cards], true, "meow_nyarlathotep_silence")
		end
	end,
	loc_vars = function(self, card) end,
	in_pool = function(self, card, amt)
		return G.GAME.meow_sanity_lost > 0 and #G.jokers.cards > 1
	end,
})

nyarlathotep_exchange({
	key = "silhouette",
	cost = 3,
	config = { xchips = 2 },
	reward = function(self, card)
		local cae = card.ability.extra
		cae.joker_main.xchips = (cae.joker_main.xchips or 1) + self.config.xchips
		G.E_MANAGER:add_event(Event({
			func = function()
				play_sound("tarot1")
				local candidates = {}
				for _, j in ipairs(G.jokers.cards) do
					if j.config.center.key ~= "j_worm_meow_nyarlathotep" then
						table.insert(candidates, j)
					end
				end
				local jokertoflip = #candidates > 0
						and pseudorandom_element(candidates, pseudoseed("meow_nyarlathotep"))
					or nil
				if jokertoflip then
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.3,
						blockable = false,
						func = function()
							jokertoflip:flip()
							return true
						end,
					}))
				end
				return true
			end,
		}))
	end,
	loc_vars = function(self, card)
		local cae = card.ability.extra
		return {
			vars = {
				self.config.xchips,
				cae.joker_main.xchips or 1,
			},
		}
	end,
	in_pool = function(self, card, amt)
		return #G.jokers.cards > 1
	end,
})

nyarlathotep_exchange({
	key = "dread",
	cost = -2,
	config = {},
	reward = function(self, card)
		local showdowns = {} --filters so it's only the showdown blinds
		for k, v in pairs(G.P_BLINDS) do
			if v.boss and v.boss.showdown then
				showdowns[k] = true
			end
		end
		for k, v in pairs(G.GAME.banned_keys) do --makes sure not to include disabled/banned blinds
			if showdowns[k] then
				showdowns[k] = nil
			end
		end
		local ignore, boss = pseudorandom_element(showdowns, "nyarlathotep_dread") --boss to reroll into
		G.E_MANAGER:add_event(Event({
			func = function()
				play_sound("worm_meowDread", 1 + 0.5 * (math.random() - 0.5), 0.6)
				G.FORCE_BOSS = boss
				G.from_boss_tag = true
				G.FUNCS.reroll_boss()
				G.E_MANAGER:add_event(Event({ --infinite showdown prevention
					func = function()
						G.FORCE_BOSS = nil
						return true
					end,
				}))
				return true
			end,
		}))
	end,
	loc_vars = function(self, card) end,
	in_pool = function(self, card, amt)
		local is_in_blind = G.GAME.blind.in_blind
		return not is_in_blind
	end,
})

nyarlathotep_exchange({
	key = "macabre",
	cost = -3,
	config = { destroy = 3, mult = 30 },
	reward = function(self, card)
		local destroy = {}
		local cae = card.ability.extra
		for i = #G.jokers.cards, 2, -1 do
			local j = math.random(i)
			G.jokers.cards[i], G.jokers.cards[j] = G.jokers.cards[j], G.jokers.cards[i]
		end
		destroy = { G.jokers.cards[1], G.jokers.cards[2], G.jokers.cards[3] }
		SMODS.destroy_cards(destroy)
		cae.joker_main.mult = (cae.joker_main.mult or 0) + self.config.mult
	end,
	loc_vars = function(self, card)
		local cae = card.ability.extra
		return {
			vars = {
				self.config.destroy,
				self.config.mult,
				cae.joker_main.mult or 0,
			},
		}
	end,
	in_pool = function(self, card, amt)
		return #G.jokers.cards > 3
	end,
})

nyarlathotep_exchange({
	key = "foresight",
	cost = 3,
	config = {},
	misc = true,
	loc_vars = function(self, card, amt)
		return {
			vars = {
				amt or 1,
				(amt or 1) > 1 and localize("k_worm_meow_plural") or "",
			},
		}
	end,
	calculate = function(self, card, context, amt)
		if context.end_of_round and context.main_eval and context.beat_boss and not context.game_over then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + amt
			for _ = 1, amt do
				G.E_MANAGER:add_event(Event({
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card({
									set = "Tarot",
									key_append = "meow_nyarlathotep",
									edition = "e_negative",
								})
								G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
								return true
							end,
						}))
						SMODS.calculate_effect({ message = localize("k_plus_tarot"), colour = G.C.PURPLE }, card)
						return true
					end,
				}))
			end
		end
	end,
})

nyarlathotep_exchange({
	key = "apparition",
	cost = 2,
	config = {},
	misc = true,
	loc_vars = function(self, card, amt)
		return {
			vars = {
				amt or 1,
				(amt or 1) > 1 and localize("k_worm_meow_plural") or "",
			},
		}
	end,
	calculate = function(self, card, context, amt)
		if context.skip_blind then
			local created = math.min(amt, G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer))
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + created
			for _ = 1, created do
				G.E_MANAGER:add_event(Event({
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card({
									set = "Spectral",
									key_append = "meow_nyarlathotep",
								})
								G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
								return true
							end,
						}))
						SMODS.calculate_effect({ message = localize("k_plus_tarot"), colour = G.C.PURPLE }, card)
						return true
					end,
				}))
			end
		end
	end,
})

nyarlathotep_exchange({
	key = "conquest",
	cost = 4,
	config = { xmult = 0.2 },
	reward = function(self, card)
		local cae = card.ability.extra
		cae.held_in_hand.xmult = self.config.xmult + (cae.held_in_hand.xmult or 1)
		cae.individual.xmult = self.config.xmult + (cae.individual.xmult or 1)
	end,
	loc_vars = function(self, card)
		local cae = card.ability.extra
		return {
			vars = {
				self.config.xmult,
				cae.held_in_hand.xmult or 1,
				cae.individual.xmult or 1,
			},
		}
	end,
})


function Wormhole.TEAM_MEOW.generate_exchange_pool(card, seed)
	local results = {}
	local pool = {}
	for _, exchange in ipairs(Wormhole.TEAM_MEOW.nyarlathotep_exchanges_list) do
		local amt = nil
		if next(card.ability.extra.misc) then
			for _, power in ipairs(card.ability.extra.misc) do
				if power.key == exchange.key then
					amt = power.amt
					break
				end
			end
		end
		if exchange:in_pool(card, amt) then
			pool[#pool + 1] = exchange.key
		end
	end
	for i = 1, 3 do
		if #pool == 0 then
			results[#results + 1] = { key = default.key, exchanged = false }
		else
			local index = pseudorandom(seed .. i, 1, #pool)
			results[#results + 1] = { key = table.remove(pool, index), exchanged = false }
		end
	end
	return results
end

function G.FUNCS.worm_meow_can_start_eldritch_encounter(e)
	local card = e.config.ref_table
	local can_use = card:can_use_consumeable()
	if can_use then
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
	G.GAME.meow_sanity_lost = G.GAME.meow_sanity_lost or 0
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

function G.FUNCS.worm_meow_reroll_exchanges(e)
	G.E_MANAGER:add_event(Event({
		func = function()
			ease_dollars(-5)
			return true
		end,
	}))
	local card = e.config.ref_table
	card.ability.extra.exchange_options = Wormhole.TEAM_MEOW.generate_exchange_pool(card, "nyarlathotep_exchanges")
	local element = G.OVERLAY_MENU:get_UIE_by_ID("meow_exchanges")
	element.config.object:remove()
	element.config.object = UIBox({
		definition = Wormhole.TEAM_MEOW.generate_exchanges_UIdef(card),
		config = { type = "cm", parent = element },
	})
	element.UIBox:recalculate()
end

function G.FUNCS.worm_meow_can_reroll_exchanges(e)
	if G.GAME.dollars >= G.GAME.bankrupt_at + 5 then
		e.config.button = "worm_meow_reroll_exchanges"
		e.config.colour = G.C.GREEN
	else
		e.config.button = nil
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	end
end

function Wormhole.TEAM_MEOW.generate_exchanges_UIdef(card)
	local exchanges = {}
	for _, exchange in ipairs(card.ability.extra.exchange_options) do
		exchanges[#exchanges + 1] = generate_exchange_item_ui(card, exchange)
	end
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.BLACK, padding = 0.1, r = 0.1 },
		nodes = {
			{
				n = G.UIT.R,
				config = { padding = 0.1, align = "cm" },
				nodes = exchanges,
			},
		},
	}
end

function G.FUNCS.meow_can_appease(e)
	local card = e.config.ref_table
	if #card.tarts > 0 and G.GAME.meow_sanity_lost > 0 then
		e.config.button = "meow_appease"
		e.config.colour = G.C.PURPLE
	else
		e.config.button = nil
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	end
end

function G.FUNCS.meow_appease(e)
	local card = e.config.ref_table
	play_sound("worm_meowChomp", 1 + 0.5 * (math.random() - 0.5), 0.6)
	local count = math.min(G.GAME.meow_sanity_lost, #card.tarts)
	G.GAME.meow_sanity_lost = G.GAME.meow_sanity_lost - count
	for _ = 1, count do
		table.remove(card.tarts)
	end
end

function Wormhole.TEAM_MEOW.nyarlathotep_exchange_menu_UIdef(card)
	local rows = {
		{
			n = G.UIT.R,
			config = { align = "cm", padding = 0.1, r = 0.1 },
			nodes = {
				{
					n = G.UIT.C,
					config = {
						align = "cm",
					},
					nodes = {
						{
							n = G.UIT.R,
							config = {
								align = "cm",
								minw = 2,
								minh = 1.5,
								colour = G.C.GREEN,
								ref_table = card,
								r = 0.1,
								hover = true,
								shadow = true,
								emboss = 0.05,
								padding = 0.05,
								func = "worm_meow_can_reroll_exchanges",
								button = "worm_meow_reroll_exchanges",
								detailed_tooltip = {
									set = "Other",
									key = "worm_meow_reroll_tooltip",
								},
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("k_reroll"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = { text = "$5", colour = G.C.UI.TEXT_LIGHT, scale = 0.7 },
										},
									},
								},
							},
						},
						{
							n = G.UIT.R,
							config = { minh = 0.1 },
						},
						{
							n = G.UIT.R,
							config = {
								align = "cm",
								minw = 2,
								minh = 1.5,
								colour = G.C.PURPLE,
								ref_table = card,
								r = 0.1,
								hover = true,
								shadow = true,
								emboss = 0.05,
								padding = 0.05,
								func = "meow_can_appease",
								button = "meow_appease",
								detailed_tooltip = {
									set = "Other",
									key = "worm_meow_appease_tooltip",
								},
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("k_worm_meow_appease1"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.5,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("k_worm_meow_appease2"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.325,
											},
										},
									},
								},
							},
						},
					},
				},
				{
					n = G.UIT.C,
					config = { align = "cm" },
					nodes = {
						{
							n = G.UIT.O,
							config = {
								id = "meow_exchanges",
								linked_card = card,
								object = UIBox({
									definition = Wormhole.TEAM_MEOW.generate_exchanges_UIdef(card),
									config = { type = "cm" },
								}),
							},
						},
					},
				},
			},
		},
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.C,
					config = { padding = 0.1, align = "cm" },
					nodes = {
						{
							n = G.UIT.R,
							config = { align = "cm" },
							nodes = {
								{
									n = G.UIT.C,
									config = { align = "cm", padding = 0.1, colour = G.C.BLACK, emboss = 0.05, r = 0.1 },
									nodes = {
										{
											n = G.UIT.R,
											config = { align = "cm" },
											nodes = {
												{
													n = G.UIT.T,
													config = {
														text = localize("k_worm_meow_money"),
														scale = 0.4,
														colour = G.C.UI.TEXT_LIGHT,
													},
												},
											},
										},
										{
											n = G.UIT.R,
											config = {
												align = "cm",
												colour = lighten(G.C.BLACK, 0.1),
												r = 0.1,
												padding = 0.1,
												minh = 0.8,
											},
											nodes = {
												{
													n = G.UIT.O,
													config = {
														object = DynaText({
															string = {
																{
																	ref_table = G.GAME,
																	ref_value = "dollars",
																	prefix = localize("$"),
																},
															},
															colours = { G.C.MONEY },
															font = G.LANGUAGES["en-us"].font,
															shadow = true,
															spacing = 2,
															bump = true,
															scale = 0.7,
														}),
														id = "dollar_text_UI",
													},
												},
											},
										},
									},
								},
								{
									n = G.UIT.C,
									config = { minw = 0.1 },
								},
								{
									n = G.UIT.C,
									config = { align = "cm", padding = 0.1, colour = G.C.BLACK, emboss = 0.05, r = 0.1 },
									nodes = {
										{
											n = G.UIT.R,
											config = { align = "cm" },
											nodes = {
												{
													n = G.UIT.T,
													config = {
														text = localize("k_worm_meow_sanity"),
														scale = 0.4,
														colour = G.C.UI.TEXT_LIGHT,
													},
												},
											},
										},
										{
											n = G.UIT.R,
											config = {
												align = "cm",
												colour = lighten(G.C.BLACK, 0.1),
												r = 0.1,
												padding = 0.1,
												minh = 0.8,
											},
											nodes = {
												{
													n = G.UIT.O,
													config = {
														object = DynaText({
															string = {
																{ ref_table = G.GAME, ref_value = "meow_sanity_lost" },
															},
															colours = { G.C.PURPLE },
															font = G.LANGUAGES["en-us"].font,
															shadow = true,
															rotate = true,
															spacing = 2,
															scale = 0.7,
														}),
													},
												},
											},
										},
									},
								},
								{
									n = G.UIT.C,
									config = { minw = 0.1 },
								},
								{
									n = G.UIT.C,
									config = { align = "cm", padding = 0.1, colour = G.C.BLACK, emboss = 0.05, r = 0.1 },
									nodes = {
										{
											n = G.UIT.R,
											config = { align = "cm" },
											nodes = {
												{
													n = G.UIT.T,
													config = {
														text = localize("k_worm_meow_blind_size_mult"),
														scale = 0.4,
														colour = G.C.UI.TEXT_LIGHT,
													},
												},
											},
										},
										{
											n = G.UIT.R,
											config = {
												align = "cm",
												colour = lighten(G.C.BLACK, 0.1),
												r = 0.1,
												padding = 0.1,
												minh = 0.8,
											},
											nodes = {
												{
													n = G.UIT.O,
													config = {
														object = DynaText({
															string = {
																{
																	ref_table = setmetatable({}, {
																		__index = function(_, _)
																			return math.pow(
																				1.25,
																				G.GAME.meow_sanity_lost
																			)
																		end,
																	}),
																	ref_value = "meow_sanity_lost",
																	prefix = "X",
																},
															},
															colours = { G.C.ORANGE },
															font = G.LANGUAGES["en-us"].font,
															shadow = true,
															bump = true,
															spacing = 2,
															scale = 0.7,
														}),
													},
												},
											},
										},
									},
								},
							},
						},
						{
							n = G.UIT.R,
							config = { align = "cm", padding = 0.1 },
							nodes = {
								{
									n = G.UIT.T,
									config = {
										text = localize("k_worm_meow_sanity_blind_mult"),
										scale = 0.4,
										colour = G.C.UI.TEXT_LIGHT,
									},
								},
							},
						},
					},
				},
			},
		},
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
	if self.area == G.jokers and is_highlighted and obj.key == "j_worm_meow_nyarlathotep" then
		---@type UIBox
		self.children.meow_nyarlathotep_menu_button = UIBox({
			definition = Wormhole.TEAM_MEOW.create_nyarlathotep_menu_button(self),
			config = { align = "cl", offset = { x = 0.3, y = 0 }, parent = self },
		})
	elseif self.children.meow_nyarlathotep_menu_button then
		self.children.meow_nyarlathotep_menu_button:remove()
		self.children.meow_nyarlathotep_menu_button = nil
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
					button = "open_nyarlathotep_menu",
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
									text = localize("k_worm_meow_eldritch"),
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
									text = localize("k_worm_meow_encounter"),
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
	path = "TeamMeow/nyarlathotep_ambience.ogg",
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
	path = "TeamMeow/nyarlathotep_insanity.ogg",
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

SMODS.ScreenShader({
	key = "insanity",
	order = 1,
	path = "TeamMeow/insanity.fs",
	send_vars = function(self)
		return {
			insanity = G.GAME.meow_sanity_lost or 0,
			time = G.TIMERS.REAL,
		}
	end,
	should_apply = function(self)
		return (G.GAME.meow_sanity_lost or 0) > 0
	end,
})
