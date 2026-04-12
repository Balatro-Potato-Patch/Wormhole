----------------------------------------------
------------MOD CODE -------------------------

--[[
SMODS.Atlas { key = "mrrp_j",
	path = "mrrp mew meow/mrrp-Jokers.png",
	px = 71, py = 95,
}

SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
    ppu_coder = {'someone lolz'},
	key = 'NAME',
	atlas = "mrrp",
	pos = {
		x=4,
		y=5
	},
	rarity = R,
	cost = C,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = {'space'},

	config = {
		extra = {
			money = 40
		}
	},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				card.ability.extra.money
			}
		}
	end,

	calculate = function(self, card, context)
		
	end
}

Card.is_3 = Card.is_3 or function(self, bypass_debuff)
	if self.debuff and not bypass_debuff then return false
	elseif self:get_id() == 3 then return 1 end
end

SMODS.Joker {
	key = 'aliencat',
	atlas = "mrrp_j", pos = {x=2, y=0},
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {extra = {odds = 3, rank = "3"}},
	loc_vars = function (self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_aliencat')
		return {
			vars = {
				numerator,
				denominator,
				localize(card.ability.extra.rank, "ranks"),
				localize("planet", "labels")
			}
		}
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card and context.other_card:is_3() then
			for i=1, context.other_card:is_3() do
				if SMODS.pseudorandom_probability(card, 'worm_aliencat_' .. i, 1, card.ability.extra.odds)
				and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({func=function()
						SMODS.add_card({set="Planet"})
						G.GAME.consumeable_buffer = 0
						return true
					end}))
					SMODS.calculate_effect({
						message = localize('k_plus_planet'),
						colour = G.C.SECONDARY_SET.Planet,
						effect = true,
					}, card)
				end
			end
		end
	end
}

SMODS.Joker {
	key = 'asteroidmine',
	atlas = "mrrp_j", pos = {x=1, y=0},
	rarity = 2,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {extra = {money = 1, hands={}}},
	loc_vars = function (self, info_queue, card)
		return {vars = {card.ability.extra.money}}
	end,

	calculate = function(self, card, context)
		if (not context.blueprint) and context.poker_hand_changed and context.old_level and context.new_level and context.scoring_name and not card.ability.extra.hands[context.scoring_name] then
			card.ability.extra.hands[context.scoring_name] = true
			return {
				message = localize("k_active_ex"),
				colour = G.C.SECONDARY_SET.Planet
			}
		end
		if context.individual and context.cardarea == G.play and context.scoring_name and card.ability.extra.hands[context.scoring_name] then
			return {
				dollars = card.ability.extra.money,
				colour = G.C.MONEY
			}
		end
		if (not context.blueprint) and context.end_of_round and context.main_eval and not context.game_over then
			card.ability.extra.hands = {}
			return {
				message = localize('k_reset'),
				colour = G.C.SECONDARY_SET.Planet
			}
		end
	end
}

SMODS.Joker {
	key = 'cookiecat',
	atlas = "mrrp_j", pos = {x=4, y=0},
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,

	config = {extra = {level = 6, level_mod = 1}},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				card.ability.extra.level,
				(card.ability.extra.level_mod > 0 and "-" or "+") .. card.ability.extra.level_mod
			}
		}
	end,

	calculate = function(self, card, context)
		if context.before then
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.SECONDARY_SET.Planet,
				func = function()
					SMODS.upgrade_poker_hands({hands=context.scoring_name, level_up=card.ability.extra.level, from=card})
				end
			}
		end
		if context.after then
			SMODS.upgrade_poker_hands({hands=context.scoring_name, level_up=-card.ability.extra.level, from=card})
			if card.ability.extra.level - card.ability.extra.level_mod <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = localize("k_eaten_ex"),
				}
			else
				SMODS.scale_card(card, {
					ref_value = "level",
					scalar_value = "level_mod",
					operation = '-',
					message_key = "a_level_minus",
					message_colour = G.C.SECONDARY_SET.Planet
				})
			end
		end
	end
}

SMODS.Joker {
	key = 'countdown',
	atlas = "mrrp_j", pos = {x=0, y=0},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {extra = {hand="Straight"}},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				localize(card.ability.extra.hand, "poker_hands")
			}
		}
	end,

	calculate = function(self, card, context)
		if context.before and context.poker_hands and next(context.poker_hands[card.ability.extra.hand]) then
			local onewithoutfaces = true
			for num,combo in ipairs(context.poker_hands[card.ability.extra.hand]) do
				onewithoutfaces = true
				for _,pcard in ipairs(combo) do
					if pcard.base and pcard.base.id then
						for k,v in pairs(SMODS.Ranks) do
							if v.id == pcard.base.id then
								if v.face then onewithoutfaces = false end
								break
							end
						end
					end
					if not onewithoutfaces then break end
				end
				if onewithoutfaces then break end
			end
			if onewithoutfaces then
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.SECONDARY_SET.Planet,
					level_up = 1,
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'felicette',
	atlas = "mrrp_j", pos = {x=3, y=0},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {extra = {chips = 0, chips_mod = 14, hands={}}},
	loc_vars = function (self, info_queue, card)
		local chips = card.ability.extra.chips
		local upgrades = 0
		local scalar = card.ability.extra.chips_mod
		local indeck = false
		for _,v in pairs(SMODS.get_card_areas('jokers')) do
			if card.area == v then
				indeck = true
			end
		end
		if not indeck then
			for _,v in pairs(G.GAME.hands) do
				if v.level and v.level > 1 then
					upgrades = upgrades + 1
				end
			end
		end
		return {
			vars = {
				scalar,
				not indeck and upgrades*scalar or chips,
			}
		}
	end,

	add_to_deck = function(self, card, from_debuff)
		for k,v in pairs(G.GAME.hands) do
			if v.level and v.level > 1 then
				card.ability.extra.hands[k] = true
				SMODS.scale_card(card, {
					ref_value = "chips",
					scalar_value = "chips_mod",
					no_message = true,
				})
			end
		end
	end,

	calculate = function(self, card, context)
		if context.poker_hand_changed and context.old_level and context.new_level and not context.blueprint then
			if context.new_level > 1 and not card.ability.extra.hands[context.scoring_name] then
				card.ability.extra.hands[context.scoring_name] = true
				SMODS.scale_card(card, {
					ref_value = "chips",
					scalar_value = "chips_mod",
					message_colour = G.C.SECONDARY_SET.Planet,
				})
			elseif context.new_level <= 1 and card.ability.extra.hands[context.scoring_name] then
				card.ability.extra.hands[context.scoring_name] = nil
				local scable = {["chips_mod"] = -card.ability.extra.chips_mod}
				SMODS.scale_card(card, {
					ref_value = "chips",
					scalar_table = scable,
					scalar_value = "chips_mod",
					scaling_message = {
						message = localize("k_downgrade_ex"),
						colour = G.C.SECONDARY_SET.Planet,
					}
				})
			end
		end
		if context.joker_main and card.ability.extra.chips ~= 0 then
			return {
				chips = card.ability.extra.chips
			}
		end
	end
}
]]

--[[
SMODS.Joker {
	key = 'goldilocks',
	atlas = "mrrp_j", pos = {x=1, y=0},
	rarity = 2,
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,

	config = {extra = {hand="Three of a Kind", enh="m_gold", seal="Gold"}},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				card.ability.extra.hand,
				localize({type='name_text', set="Enhanced", key=card.ability.extra.enh}),
				card.ability.extra.seal
			}
		}
	end,

	calculate = function(self, card, context)
		
	end
}

SMODS.Joker {
	key = 'capitalism',
	atlas = "mrrp_j", pos = {x=1, y=0},
	rarity = 2,
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,

	config = {extra = {mult = 0, mult_mod = 14}},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				(card.ability.extra.mult_mod < 0 and "-" or "+") .. card.ability.extra.mult_mod,
				(card.ability.extra.mult < 0 and "-" or "+") .. card.ability.extra.mult
			}
		}
	end,

	calculate = function(self, card, context)
		
	end
}

SMODS.Joker {
	key = "tanabata",
	atlas = "mrrp_j", pos = {x=3, y=0}
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.joker_main and not context.before and not context.after and not (context.blueprint_card or card).getting_sliced then
			local jacks = 0
			local queens = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 12 then queens = queens + 1 end
				if context.scoring_hand[i]:get_id() == 11 then jacks = jacks + 1 end
			end
			if kings >= 1 and queens >= 1 then
				SMODS.create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, 'tanabata', function(new_card)
					play_sound("polychrome1",2,0.5)
					card:juice_up(0.3, 0.5)
				end)
				return {}
			end
		end
	end
}) ; Code ported from Prism's Happily Ever After and modified
--]]
----------------------------------------------
------------MOD CODE END----------------------