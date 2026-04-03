--[[

Wormhole Mod - Team People I Found On The Street In Las Vegas (People Found In Vegas for short :D)

Jammbo
h0l
Ben Roffey (Reson8r)

]]

--Potato Patch Credits
PotatoPatchUtils.Team{
	name = "People Found In Vegas",
	colour = HEX("73fdff")
}

PotatoPatchUtils.Developer{
	name = "Jammbo",
	colour = G.C.GREEN,
	team = "People Found In Vegas",
	atlas = "worm_vegas_credits",
	pos = {x = 0, y = 0},
	soul_pos = {x = 0, y = 1}
}

PotatoPatchUtils.Developer{
	name = "h0l",
	colour = G.C.MONEY,
	team = "People Found In Vegas" --[[,
	atlas = "worm_vegas_credits",
	pos = {x = 1, y = 0},
	soul_pos = {x = 1, y = 1}]]
}

PotatoPatchUtils.Developer{
	name = "Ben Roffey",
	colour = G.C.CHIPS,
	team = "People Found In Vegas",
	atlas = "worm_vegas_credits",
	pos = {x = 2, y = 0},
	soul_pos = {x = 2, y = 1}
}

--Atlas
SMODS.Atlas{
	key = "vegas_credits",
	path = "vegas/credits.png",
	px = 71,
	py = 95
}

SMODS.Atlas{
	key = "vegas_jokers",
	path = "vegas/jokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas{
	key = "vegas_blinds",
	path = "vegas/blinds.png",
	px = 34,
	py = 34
}

--Jokers
SMODS.Joker{
	key = "orbit",
	loc_txt = {
		name = "Orbit",
		text = {
			"Gains {C:mult}+#1#{} Mult when",
			"scoring a {C:attention}#2#",
			"{C:inactive}Rank decreases after scoring",
			"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
		}
	},
	config = { extra = { gain = 1, rank = 14, current = 0}},
	loc_vars = function(self, info_queue, card)
		local rank = card.ability.extra.rank
		local text
		if rank == 14 then
			text = "Ace"
		elseif rank == 13 then
			text = "King"
		elseif rank == 12 then
			text= "Queen"
		elseif rank == 11 then
			text = "Jack"
		else
			text = rank
		end
		return { vars = {card.ability.extra.gain, text, card.ability.extra.current}}
	end,
	atlas = "vegas_jokers",
	pos = {x = 0, y = 0},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = false,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Ben Roffey"},
	ppu_artist = {"Ben Roffey", "Jammbo"}, --no
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:get_id() == card.ability.extra.rank then
				card.ability.extra.current = card.ability.extra.current + card.ability.extra.gain
				card.ability.extra.rank = card.ability.extra.rank - 1
				if card.ability.extra.rank < 2 then card.ability.extra.rank = 14 end
				return {
					message = "Upgraded!",
					colour = G.C.MULT,
					message_card = card
				}
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.current
			}
		end
	end
}

SMODS.Joker{
	key = "spaghettification",
	loc_txt = {
		name = "Spaghettification",
		text = {
			"{C:green}#1# in #2#{} chance to {C:attention}downgrade",
			"level of played {C:attention} poker hand",
			"Gains {C:attention}double{} the Mult lost",
			"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
		}
	},
	config = { extra = { odds = 4, current = 0 }},
	loc_vars = function(self, info_queue, card)
		local numerator = 1
		if G.GAME then numerator = G.GAME.probabilities.normal end
		return { vars = { numerator, card.ability.extra.odds, card.ability.extra.current}}
	end,
	atlas = "vegas_jokers",
	pos = {x = 1, y = 0},
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = false,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Ben Roffey"},
	ppu_artist = {"Ben Roffey", "Jammbo"},
	calculate = function(self, card, context)
		if context.before then
			if pseudorandom('spaghettification') < G.GAME.probabilities.normal/card.ability.extra.odds then
				if G.GAME.hands[context.scoring_name].level > -1 then
					local startingMult = G.GAME.hands[context.scoring_name].mult
					level_up_hand(card, context.scoring_name, nil, -1)
					local endingMult = G.GAME.hands[context.scoring_name].mult
					if endingMult < startingMult then
						card.ability.extra.current = card.ability.extra.current + (startingMult - endingMult) * 2
						return {
							message = "+" .. (startingMult - endingMult) * 2,
							colour = G.C.MULT,
							message_card = card
						}
					end
				end
			end
		end
		if context.joker_main then
			return { mult = card.ability.extra.current}
		end
	end
}

SMODS.Joker{
	key = "hubble",
	loc_txt = {
		name = "Hubble Space Telescope",
		text = {
			"{C:attention}+#2#{} Hand Size",
			"Gains {C:attention}+#1#{} Hand Size for",
			"every {C:attention}#4#{} {C:blue}Planet{} Cards used",
			"{C:attention}#3#{} {C:inactive}Planet Cards left"
		}
	},
	config = { extra = { h_size = 1, h_size_gain = 1, counter = 3, max = 3 }},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.h_size_gain, card.ability.extra.h_size, card.ability.extra.counter, card.ability.extra.max }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 2, y = 0},
	rarity = 2,
	cost = 6,
	blueprint_compat = false,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Jammbo"},
	ppu_artist = {"Jammbo"},
	calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == ("Planet") then
			if card.ability.extra.counter == 1 then
				G.hand:change_size(-card.ability.extra.h_size)
				card.ability.extra.h_size = card.ability.extra.h_size + card.ability.extra.h_size_gain
				G.hand:change_size(card.ability.extra.h_size)
				card.ability.extra.counter = card.ability.extra.max
				return {
					message = "Upgrade!"
				}
			end
			card.ability.extra.counter = card.ability.extra.counter - 1
        end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end
}

SMODS.Joker{
	key = "inferior_planet",
	loc_txt = {
		name = "Inferior Planet",
		text = {
			"{C:green}#1# in #2#{} chance to create an",
			"{C:attention}inferior{} {C:blue}Planet{} Card",
			"when a {C:blue}Planet{} Card is used",
			"{C:inactive}(Must have room)"
		}
	},
	config = { extra = { odds = 2 }},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'inferiorplanet')
        return { vars = { numerator, denominator } }
	end,
	atlas = "vegas_jokers",
	pos = {x = 3, y = 0},
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Jammbo"},
	ppu_artist = {"Jammbo"},
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == ("Planet") and SMODS.pseudorandom_probability(card, 'inferiorplanet', 1, card.ability.extra.odds) then
			local key = context.consumeable.config.center.key
			local hand_type = nil
			local order = 0
			for i = 1, #G.P_CENTER_POOLS.Planet do
				if key == G.P_CENTER_POOLS.Planet[i].key then
					hand_type = G.GAME.hands[G.P_CENTER_POOLS.Planet[i].config.hand_type]
					order = hand_type.order
				end
			end
			local hands_lower_equal = {}
			if hand_type and hand_type.key ~= 'High Card' then
				for i = 1, #G.P_CENTER_POOLS.Planet do
					if G.GAME.hands[G.P_CENTER_POOLS.Planet[i].config.hand_type].order > order then
						hands_lower_equal[#hands_lower_equal + 1] = G.GAME.hands[G.P_CENTER_POOLS.Planet[i].config.hand_type]
					end
				end
				local chosen_hand = pseudorandom_element(hands_lower_equal, 'inferior')
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = function()
						local _planet = nil
						for k, v in pairs(G.P_CENTER_POOLS.Planet) do
							if v.config.hand_type == chosen_hand.key then
								_planet = v.key
							end
						end
						if _planet then

							SMODS.add_card({ key = _planet })
						end
						G.GAME.consumeable_buffer = 0
						return true
					end
				}))
				return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }
			end
        end
	end
}

--[[
SMODS.Joker{
	key = "template",
	loc_txt = {
		name = "Template",
		text = {
			"Description"
		}
	},
	config = { extra = { }},
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,
	atlas = "vegas_jokers",
	pos = {x = 0, y = 0},
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {},
	ppu_artist = {},
	calculate = function(self, card, context)
		
	end
}
]]

--Blinds
SMODS.Blind{
	key = "whitehole",
	loc_txt = {
		name = "White Hole",
		text = {
			"Decrease level of all",
			"poker hands by 1"
		}
	},
	atlas = "vegas_blinds",
	pos = {x = 0, y = 0},
	discovered = true,
	boss = {showdown = true},
	dollars = 8,
    mult = 2,
	boss_colour = HEX("c3c3c3"),
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Ben Roffey"},
	ppu_artist = {"Ben Roffey"},
	calculate = function(self, blind, context)
		if context.before then
			update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
				play_sound('tarot1')
				blind:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = true
				return true end }))
			update_hand_text({delay = 0}, {mult = '-', StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				blind:juice_up(0.8, 0.5)
				return true end }))
			update_hand_text({delay = 0}, {chips = '-', StatusText = true})
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
				play_sound('tarot1')
				blind:juice_up(0.8, 0.5)
				G.TAROT_INTERRUPT_PULSE = nil
				return true end }))
			update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='-1'})
			delay(1.3)
			for k, v in pairs(G.GAME.hands) do
				level_up_hand(blind, k, true, -1)
			end
			update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
		end
	end
}