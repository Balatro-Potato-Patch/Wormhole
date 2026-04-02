--[[

Wormhole Mod - Team People I Found On The Street In Las Vegas (Vegas for short :D)

Jammbo
h0l
Ben Roffey (Reson8r)

]]

--Potato Patch Credits
PotatoPatchUtils.Team{
	name = "Vegas",
	colour = HEX("73fdff")
}

PotatoPatchUtils.Developer{
	name = "Jammbo",
	colour = G.C.MULT,
	team = "Vegas" --[[,
	atlas = "worm_vegas_credits",
	pos = {x = 0, y = 0},
	soul_pos = {x = 0, y = 1}]]
}

PotatoPatchUtils.Developer{
	name = "h0l",
	colour = G.C.MONEY,
	team = "Vegas" --[[,
	atlas = "worm_vegas_credits",
	pos = {x = 1, y = 0},
	soul_pos = {x = 1, y = 1}]]
}

PotatoPatchUtils.Developer{
	name = "Ben Roffey",
	colour = G.C.CHIPS,
	team = "Vegas",
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

--Jokers
SMODS.Joker{
	key = "orbit",
	loc_txt = {
		name = "Orbit",
		text = {
			"Gains {C:mult}+#1#{} Mult when",
			"scoring a {C:attention}#2#",
			"Rank decreases after scoring",
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
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"Vegas"},
	ppu_coder = {"Ben Roffey"},
	ppu_artist = {"Ben Roffey"}, --Placeholder?
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
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
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"Vegas"},
	ppu_coder = {"Ben Roffey"},
	ppu_artist = {},
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
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"Vegas"},
	ppu_coder = {},
	ppu_artist = {},
	calculate = function(self, card, context)
		
	end
}
]]