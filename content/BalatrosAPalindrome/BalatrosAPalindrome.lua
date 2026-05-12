--sendDebugMessage("BalatrosAPalindrome loading!")

SMODS.DynaTextEffect {
	key = "bap_text_funny",
	func = function(self, index, letter)
		letter.scale = (math.sin((G.TIMERS.REAL * 4.0 + index) * 1.9443) + 1.0) * 0.25 + 0.9
		letter.offset = { x = 0.0, y = math.sin((G.TIMERS.REAL * 4.0 + index)) * 10.0 }
		--letter.r = math.sin((G.TIMERS.REAL*4.0 + index)*1.9443) * math.pi / 7
	end
}


SMODS.Atlas {
	-- Key for code to find it with
	key = "Palindrome",
	-- The name of the file, for the code to pull the atlas from
	path = "BalatrosAPalindrome/Palindrome.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}


PotatoPatchUtils.Team({ name = "BalatrosAPalindrome", colour = G.C.BLUE, short_credit = true, credit_rows = {4} })
PotatoPatchUtils.Developer({ team = "BalatrosAPalindrome", name = "Nogardagem", loc = true, atlas = 'worm_Palindrome', pos = { x = 0, y = 4 }, soul_pos = { x = 1, y = 4 } })
PotatoPatchUtils.Developer({ team = "BalatrosAPalindrome", name = "NerdyBread42", loc = true, atlas = 'worm_Palindrome', pos = { x = 1, y = 3 } })
PotatoPatchUtils.Developer({ team = "BalatrosAPalindrome", name = "IzzyWizz", loc = true, atlas = 'worm_Palindrome', pos = { x = 2, y = 4 } })
PotatoPatchUtils.Developer({ team = "BalatrosAPalindrome", name = "Knightingale0", loc = true, atlas = 'worm_Palindrome', pos = { x = 1, y = 2 } })


SMODS.Shader {
	ppu_team = { "BalatrosAPalindrome" },
	key = 'bap_shader_void',
	path = 'bap_shader_void.fs',
	-- card can be nil if sprite.role.major is not Card
}

-- Void card edition
SMODS.Edition {
	ppu_team = { "BalatrosAPalindrome" },
	key = 'bap_void',
	shader = 'worm_bap_shader_void',
	config = { chips = -25 },
	in_shop = false,
	weight = 0,
	extra_cost = 5,
	never_scores = true,
	sound = { sound = "negative", per = 1.5, vol = 0.1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { self.config.chips } }
	end,
	get_weight = function(self)
		return self.weight
	end,
	draw = function(self, card, layer)
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' and (card.config.center.discovered or card.bypass_discovery_center or (card.area.config.type == "title" and card.config.center == G.P_CENTERS.c_base)) then
			card.children.center:draw_shader('worm_bap_shader_void', nil, card.ARGS.send_to_shader)
			if card.children.front and card.config.center_key ~= "m_stone" then
				card.children.front:draw_shader('worm_bap_shader_void', nil, card.ARGS.send_to_shader)
			end
			--card.children.center:draw_shader('negative_shine', nil, card.ARGS.send_to_shader)
		end
	end,
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.hand then
			return {
				chips = card.edition.chips
			}
		end
	end
}

-- The Abyss
SMODS.Consumable {
	ppu_team = { "BalatrosAPalindrome" },
	key = 'bap_abyss',
	set = 'Tarot',
	atlas = 'Palindrome',
	pos = { x = 2, y = 0 },
	config = { extra = { money = 15, cards = 5 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_bap_void
		return { vars = { card.ability.extra.money, card.ability.extra.cards } }
	end,
	use = function(self, card, area, copier)
		-- give money
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('timpani')
				card:juice_up(0.3, 0.5)
				ease_dollars(card.ability.extra.money, true)
				return true
			end
		}))

		--add cards
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.7,
			func = function()
				local cards = {}
				for i = 1, card.ability.extra.cards do
					local _rank = pseudorandom_element(SMODS.Ranks, 'abyss_create').card_key
					local _suit = pseudorandom_element(SMODS.Suits, 'abyss_create').key

					cards[i] = SMODS.add_card({
						--area = G.hand,
						suit = _suit,
						rank = _rank,
						--enhancement = "m_worm_bap_void",
						edition = "e_worm_bap_void"
					})
				end
				SMODS.calculate_context({ playing_card_added = true, cards = cards })
				return true
			end
		}))

		delay(0.3)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 1
	end
}

-- Void hand
SMODS.PokerHand {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_void",
	visible = false,
	mult = 7,
	chips = 200,
	l_mult = 2,
	l_chips = 25,
	example = {
		{ 'S_A', true, edition = "e_worm_bap_void" },
		{ 'D_Q', true, edition = "e_worm_bap_void" },
		{ 'D_9', true, edition = "e_worm_bap_void" },
		{ 'C_4', true, edition = "e_worm_bap_void" },
		{ 'D_3', true, edition = "e_worm_bap_void" }
	},
	evaluate = function(parts, hand)
		if #hand ~= 5 then
			return {}
		end

		for _, card in ipairs(hand) do
			if not card.edition or card.edition.key ~= 'e_worm_bap_void' then
				return {}
			end
		end

		return { hand }
	end
}

-- Nothing planet card
SMODS.Consumable {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_nothing",
	set = 'Planet',
	cost = 3,
	atlas = 'Palindrome',
	pos = { x = 0, y = 0 },
	config = { hand_type = "worm_bap_void" },
	in_pool = function(self, args)
		return SMODS.is_poker_hand_visible("worm_bap_void")
	end,
	loc_vars = function(self, info_queue, card)
		if not SMODS.is_poker_hand_visible("worm_bap_void") then
			return {
				vars = {
					"0",
					"Nothing??",
					"0",
					"0",
					colours = { G.C.UI.TEXT_DARK }
				}
			}
		end

		return {
			vars = {
				G.GAME.hands[card.ability.hand_type or 'High Card'].level,
				"Void Hand",
				G.GAME.hands[card.ability.hand_type or 'High Card'].l_mult,
				G.GAME.hands[card.ability.hand_type or 'High Card'].l_chips,
				colours = { (G.GAME.hands[card.ability.hand_type or 'High Card'].level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[card.ability.hand_type or 'High Card'].level)]) }
			}
		}
	end,
	can_use = function(self, card)
		if not SMODS.is_poker_hand_visible("worm_bap_void") then
			card.ability.hand_type = ""
		else
			card.ability.hand_type = "worm_bap_void"
		end
		return SMODS.is_poker_hand_visible("worm_bap_void")
	end
}

-- Milky Way
SMODS.Joker {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_milky_way",
	blueprint_compat = true,
	eternal_compat = false,
	rarity = 2,
	cost = 5,
	atlas = 'Palindrome',
	pos = { x = 1, y = 1 },
	config = { extra = { hands_left = 10 } },
	attributes = { "generation", "planet", "space" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands_left } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					if G.consumeables.config.card_limit > #G.consumeables.cards then
						play_sound('timpani')
						SMODS.add_card({ set = 'Planet', key_append = "bap_milky_way" })
						card:juice_up(0.3, 0.5)
					end
					return true
				end
			}))

			if context.blueprint then return end

			if card.ability.extra.hands_left - 1 <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
				G.GAME.pool_flags.bap_milky_drank = true;
				return {
					message = "Drank!",
					colour = G.C.FILTER
				}
			else
				card.ability.extra.hands_left = card.ability.extra.hands_left - 1
				return {
					message = card.ability.extra.hands_left .. '',
					colour = G.C.FILTER
				}
			end
		end
	end,
	in_pool = function(self, args) -- equivalent to `no_pool_flag = 'vremade_gros_michel_extinct'`
		return not G.GAME.pool_flags.bap_milky_drank
	end
}

-- Andromeda
SMODS.Joker {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_andromeda",
	blueprint_compat = true,
	eternal_compat = false,
	rarity = 2,
	cost = 6,
	atlas = 'Palindrome',
	pos = { x = 1, y = 2 },
	config = { extra = { money_per = 1 } },
	attributes = { "economy", "hands", "hand_type", "space" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money_per } }
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
			local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
			juice_card_until(card, eval, true)
		end

		if context.final_scoring_step and G.GAME.current_round.hands_played == 0 then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) +
			G.GAME.hands[context.scoring_name].level                                             -- ripped from business card
			return {
				dollars = G.GAME.hands[context.scoring_name].level,
				func = function() -- This is for timing purposes, this goes after the dollar modification
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.dollar_buffer = 0
							return true
						end
					}))
				end
			}
		end
	end,
	in_pool = function(self, args) -- equivalent to `yes_pool_flag = 'vremade_gros_michel_extinct'`
		return G.GAME.pool_flags.bap_milky_drank
	end
}

-- Solar Panels
SMODS.Joker {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_solar_panel",
	blueprint_compat = true,
	eternal_compat = false,
	rarity = 1,
	cost = 5,
	atlas = 'Palindrome',
	pos = { x = 0, y = 1 },
	config = { extra = { s_mult = 4, suitOne = 'Diamonds', s_chips = 25, suitTwo = 'Hearts' }, },
	attributes = { "suit", "hearts", "mult", "diamonds", "chips", "space" },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		ret = {}
		if context.individual and context.cardarea == G.play and
			context.other_card:is_suit(card.ability.extra.suitTwo) then
			ret.mult = card.ability.extra.s_mult
		end
		if context.individual and context.cardarea == G.play and
			context.other_card:is_suit(card.ability.extra.suitOne) then
			ret.chips = card.ability.extra.s_chips
		end
		return ret
	end
}

-- Artemis 3
SMODS.Joker {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_artemis_3",
	blueprint_compat = true,
	eternal_compat = false,
	rarity = 2,
	cost = 6,
	atlas = 'Palindrome',
	pos = { x = 0, y = 3 },
	config = {},
	attributes = { "generation", "editions", "tarot", "space" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_moon
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
					SMODS.add_card {
						set = 'Tarot',
						key = 'c_moon',
						key_append = 'bap_artemis_3', -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
						edition = "e_negative"
					}
					G.GAME.consumeable_buffer = 0
					return true
				end)
			}))
			return {
				message = localize('k_plus_tarot'),
				colour = G.C.SECONDARY_SET.Tarot,
			}
		end
	end
}


-- Space Walk
SMODS.Joker {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_space_walk",
	blueprint_compat = true,
	eternal_compat = false,
	rarity = 3,
	cost = 8,
	atlas = 'Palindrome',
	pos = { x = 2, y = 4 },
	config = { extra = { jokers = 5 } },
	attributes = { "generation", "editions", "joker", "space" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_space
		return { vars = { card.ability.extra.jokers } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then --and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			--G.GAME.joker_buffer = G.GAME.joker_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.4,
				func = (function()
					SMODS.add_card {
						set = 'Joker',
						key = 'j_space',
						key_append = 'bap_space_walk', -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
						edition = "e_negative"
					}
					--G.GAME.joker_buffer = 0

					return true
				end)
			}))
			if card.ability.extra.jokers - 1 <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = "Walked!",
					colour = G.C.FILTER
				}
			end
			card.ability.extra.jokers = card.ability.extra.jokers - 1
			return {
				message = card.ability.extra.jokers .. '',
				colour = G.C.FILTER
			}
		end
	end
}


-- Vacuum
SMODS.Joker {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_vacuum",
	blueprint_compat = true,
	eternal_compat = false,
	rarity = 2,
	cost = 5,
	atlas = 'Palindrome',
	pos = { x = 1, y = 3 },
	config = { extra = { x_mult = 2 } },
	attributes = { "xmult", "editions", "space" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_bap_void
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local has_void = false

			for index = 1, #context.full_hand do
				local playing_card = context.full_hand[index]

				if playing_card.edition and playing_card.edition.worm_bap_void then
					has_void = true
					break
				end
			end
			if has_void then
				return {
					x_mult = card.ability.extra.x_mult
				}
			end
		end
	end,
}

-- Space Worm
SMODS.Joker {
	ppu_team = { "BalatrosAPalindrome" },
	key = "bap_space_worm",
	blueprint_compat = true,
	rarity = 3,
	cost = 7,
	atlas = 'Palindrome',
	pos = { x = 0, y = 2 },
	config = { extra = { x_mult = 1.0, inc_mult = 0.25 } },
	attributes = { "destroy_card", "xmult", "scaling", "space" },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.inc_mult, card.ability.extra.x_mult, colours = { Wormhole.badge_colour, Wormhole.badge_text_colour } } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			local my_pos = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					my_pos = i
					break
				end
			end

			if my_pos and G.jokers.cards[my_pos + 1] and string.find(G.jokers.cards[my_pos + 1].config.center_key, "worm") and not SMODS.is_eternal(G.jokers.cards[my_pos + 1], card) and not G.jokers.cards[my_pos + 1].getting_sliced then
				local sliced_card = G.jokers.cards[my_pos + 1]
				sliced_card.getting_sliced = true -- Make sure to do this on destruction effects
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					func = function()
						G.GAME.joker_buffer = 0
						-- See note about SMODS Scaling Manipulation on the wiki
						card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.inc_mult
						card:juice_up(0.8, 0.8)
						sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
						play_sound('slice1', 0.96 + math.random() * 0.08)
						return true
					end
				}))
				return {
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult + card.ability.extra.inc_mult } },
					colour = G.C.RED,
					no_juice = true
				}
			else
				if my_pos and G.jokers.cards[my_pos + 1] then
					return {
						message = localize{ type = "name_text", set = "Joker", key = G.jokers.cards[my_pos + 1].config.center_key }
					}
				end
			end
		end
		if context.joker_main then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
	end
}

-- Worm
SMODS.Joker {
	ppu_team = { "BalatrosAPalindrome" },
	key = 'bap_regular_worm',
	blueprint_compat = true,
	rarity = 1,
	cost = 4,
	atlas = 'Palindrome',
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	config = { extra = { x_mult = 1.0, inc_x_mult = 0.10 } },
	attributes = { "scaling", "xmult", "editions", "space" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_bap_void
		return { vars = { card.ability.extra.inc_x_mult, card.ability.extra.x_mult } }
	end,
	in_pool = function(self, args)
		for k,v in ipairs(G.playing_cards) do
			if v.edition and v.edition == 'e_worm_bap_void' then
				return true
			end
		end
		return false
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local voids = {}
			for _, card in ipairs(context.full_hand) do
				if card.edition and card.edition.key == 'e_worm_bap_void' then
					--print("Hello World")
					voids[#voids + 1] = card
					G.E_MANAGER:add_event(Event({
						func = function()
							card:set_edition(nil, true)
							card:juice_up()
							return true
						end
					}))
				end
			end

			if #voids > 0 then
				-- See note about SMODS Scaling Manipulation on the wiki
				card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.inc_x_mult * #voids
				return {
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
					colour = G.C.MULT
				}
			end
		end
		if context.joker_main then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
	end
}
