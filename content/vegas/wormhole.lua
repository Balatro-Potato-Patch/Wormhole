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
    name = "Sn0vvBall",
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
	key = "vegas_exoplanets",
	path = "vegas/exoplanets.png",
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
			"level of played {C:attention}poker hand",
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
	key = "gravity_assist",
	loc_txt = {
		name = "Gravity Assist",
		text = {
			"{C:green}#1# in #2#{} chance to create an",
			"{C:attention}inferior{} {C:blue}Planet{} Card",
			"when a {C:blue}Planet{} Card is used",
			"{C:inactive}(Must have room)"
		}
	},
	config = { extra = { odds = 2 }},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'gravityassist')
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
		if context.using_consumeable and context.consumeable.ability.set == ("Planet") and SMODS.pseudorandom_probability(card, 'gravityassist', 1, card.ability.extra.odds) then
			local key = context.consumeable.config.center.key
			local hand_type = nil
			local order = 0
			for i = 1, #G.P_CENTER_POOLS.Planet do
				if key == G.P_CENTER_POOLS.Planet[i].key then
					if not G.GAME.hands[G.P_CENTER_POOLS.Planet[i].config.hand_type] then return end --protecting against any modded planet cards with no hand_type
					hand_type = G.GAME.hands[G.P_CENTER_POOLS.Planet[i].config.hand_type]
					order = hand_type.order
				end
			end
			local hands_lower_equal = {}
			if hand_type then
				for i = 1, #G.P_CENTER_POOLS.Planet do
					if G.GAME.hands[G.P_CENTER_POOLS.Planet[i].config.hand_type].order > order then
						hands_lower_equal[#hands_lower_equal + 1] = G.GAME.hands[G.P_CENTER_POOLS.Planet[i].config.hand_type]
					end
				end
				if #hands_lower_equal == 0 then return end --if the used planet was the lowest order, do nothing
				local chosen_hand = pseudorandom_element(hands_lower_equal, 'gravityassist')
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
						if _planet and #G.consumeables.cards + G.GAME.consumeable_buffer < (G.consumeables.config.card_limit + 1) then
							SMODS.add_card({ key = _planet })
							SMODS.calculate_effect({message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet}, card)
						end
						G.GAME.consumeable_buffer = 0
						return true
					end
				}))
			end
        end
	end
}

SMODS.Joker{
	key = "astronaut",
	loc_txt = {
		name = "Astronaut",
		text = {
			"{C:money}$#1#{} for each level",
			"of the {C:attention}final hand"
		}
	},
	config = { extra = { dollars = 1 }},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 0, y = 1},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Jammbo"},
	ppu_artist = {"Ben Roffey"},
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                dollars = G.GAME.hands[context.scoring_name].level
            }
        end
	end
}

SMODS.Joker{
	key = "chthonian",
	loc_txt = {
		name = "Chthonian Planet",
		text = {
			"If {C:attention}first discard{} of",
			"round is {C:attention}#1#{} cards, make",
			"{C:attention}both{} cards {C:attention}Stone{}"
		}
	},
	config = { extra = { size = 2 }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return { vars = { card.ability.extra.size }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 4, y = 1},
	rarity = 1,
	cost = 6,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Jammbo"},
	ppu_artist = {"Jammbo"},
	calculate = function(self, card, context)
		if context.discard and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 2 and context.other_card then
            if (context.other_card == context.full_hand[1]) or (context.other_card == context.full_hand[2]) then
				context.other_card:set_ability("m_stone", nil, true)
			end
			return{
				message = "Look! Rocks!"
			}
        end
	end
}

SMODS.Joker{
    key = "goldielocks",
    loc_txt = {
        name = "Goldielocks",
        text = {
            "Retriggers middle card in",
			"hand {C:attention}#2#{} times or",
			"Retriggers both middle cards in",
			"hand {C:attention}#1#{} time each"
        }
    },
    config = { extra = { repetitions = 1, repetitions_odd = 2 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions, card.ability.extra.repetitions_odd }}
    end,
    atlas = "vegas_jokers",
    pos = {x = 4, y = 0},
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_team = {"People Found In Vegas"},
    ppu_coder = {"Sn0vvBall"},
    ppu_artist = {"Sn0vvBall"},
    calculate = function(self, card, context)
		local MidNum = nil
		local IsOdd = false
		if context.repetition and context.cardarea == G.play and context.other_card then
			MidNum = #context.scoring_hand/2
            if math.fmod(#context.scoring_hand, 2) == 0  then
                IsOdd = false
            else
                IsOdd = true
            end
			if IsOdd == true then
				if context.other_card == context.scoring_hand[MidNum + 0.5] then
					return {
						repetitions = card.ability.extra.repetitions_odd
					}
				end
			end
			if IsOdd == false then
				if context.other_card == context.scoring_hand[MidNum] or context.other_card == context.scoring_hand[MidNum + 1] then
					return {
						repetitions = card.ability.extra.repetitions
					}
				end
			end
		end
    end
}

local space_roulette
space_roulette = function(card, time, index)

	G.jokers.cards[index]:flip()
	play_sound("cardSlide1")

	newtime = time * (pseudorandom("vegas") * 0.5 + 1)
	newindex = index + 1
	if newindex > #G.jokers.cards then newindex = 1 end

	if newindex ~= index then
		G.jokers.cards[newindex]:flip()
		play_sound("cardSlide1")
	end

	if newtime < 0.5 then
		G.E_MANAGER:add_event(Event{
			blockable = false,
			blocking = false,
			pause_force = true,
			no_delete = true,
			trigger = 'after',
			delay = newtime,
			func = function()
				space_roulette(card, newtime, newindex)
				return true
			end
		})
		return true
	end

	if card.facing == "front" then
		G.E_MANAGER:add_event(Event{
			trigger = 'after',
			delay = 0.5,
			func = function()
				SMODS.calculate_effect(
				{ 
					dollars = card.ability.gain * #G.jokers.cards
				}, card)
				return true
			end
		})
	else
		G.E_MANAGER:add_event(Event{
			trigger = 'after',
			delay = 0.5,
			func = function()
				SMODS.calculate_effect(
				{ 
					message = "Unlucky!",
					colour = G.C.ATTENTION
				}, 
				card)
				return true
			end
		})
		
	end

	G.E_MANAGER:add_event(Event{
		blockable = false,
		blocking = false,
		pause_force = true,
		no_delete = true,
		trigger = 'after',
		delay = 1,
		func = function()
			play = false
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].facing == "back" then
					G.jokers.cards[i]:flip()
					play = true
				end
			end
			if play then play_sound("cardSlide1") end
			return true
		end
	})

	return true
end

spacerouletteinfo = {
	key = "SpaceRoulette",
	set = "Other"
}

SMODS.Joker{
	key = "vegas",
	loc_txt = {
		name = "Space Vegas",
		text = {
			"At the start of the",
			"round, play {C:attention}space roulette",
			"If {C:attention}this{} Joker lands face up,",
			"gain {C:money}$#1#{} for each {C:attention}Joker{}"
		}
	},
	config = { gain = 6},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = spacerouletteinfo
		return { vars = { card.ability.gain }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 1, y = 1},
	rarity = 1,
	cost = 5,
	blueprint_compat = false,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Ben Roffey"},
	ppu_artist = {"Ben Roffey", "Jammbo"},
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			G.E_MANAGER:add_event(Event{
				blockable = false,
				blocking = false,
				pause_force = true,
				no_delete = true,
				trigger = 'after',
				delay = 1,
				func = function()
					if #G.jokers.cards > 1 then
						for i = 2, #G.jokers.cards do
							G.jokers.cards[i]:flip()
						end
					end
					space_roulette(card, 0.01, 1)
					return true
				end
			})
		end
	end
}

SMODS.Joker{
	key = "wormhole",
	loc_txt = {
		name = "Wormhole",
		text = {
			"Adds a {C:dark_edition}Negative{} copy of any",
			"{C:attention}Consumable{} to the bottom of",
			"your {C:attention}deck{} when it is used"
		}
	},
	config = { sets = { "Tarot", "Planet", "Spectral" }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
		return { vars = {  }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 2, y = 1},
	soul_pos = {x = 3, y = 1},
	rarity = 4,
	cost = 20,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Ben Roffey"},
	ppu_artist = {"Ben Roffey"},
	calculate = function(self, card, context)
		if context.using_consumeable then
			SMODS.add_card({ key = context.consumeable.config.center.key, edition = "e_negative", area = G.deck})
			for i = 1, #self.config.sets do
				if context.consumeable.ability.set == self.config.sets[i] then
					return { message = "Wormhole!", colour = G.C.SECONDARY_SET.Tarot }
				end
			end
			self.config.sets[#self.config.sets + 1] = context.consumeable.ability.set --keeps track of any modded sets
		end
		if context.drawing_cards and not context.blueprint then
			G.E_MANAGER:add_event(Event{
				trigger = 'after',
				blockable = true,
				blocking = false,
				delay = 2,
				func = function()
					local remove = {}
					for i = 1, #G.hand.cards do
						for j = 1, #self.config.sets do
							if G.hand.cards[i].ability and G.hand.cards[i].ability.set and G.hand.cards[i].ability.set == self.config.sets[j] then --if the card is actually a consumable card,
								SMODS.add_card({ key = G.hand.cards[i].config.center.key, edition = "e_negative", area = G.consumeable}) --create a copy in the consumeable area
								remove[#remove + 1] = i -- mark the card for removal
							end
						end
					end
					for i = #remove, 1, -1 do
						if i < #G.hand.cards then
							G.hand.cards[remove[i]]:remove() --remove the marked cards from the hand
						end
					end
					return true
				end
			})
		end
	end
}

SMODS.Joker{
	key = "inthesky",
	loc_txt = {
		name = "Diamonds in the Sky",
		text = {
			"First {C:attention}#1#{} scored {V:1}Diamond{} cards",
			"in {C:attention}first{} played hand become {C:dark_edition}Negative{}"
		}
	},
	config = { extra = { cards = 2, suit = 'Diamonds' }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = 1}}
		return { vars = { card.ability.extra.cards, colours = { G.C.SUITS['Diamonds'] } } }
	end,
	atlas = "vegas_jokers",
	pos = {x = 0, y = 2},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Jammbo"},
	ppu_artist = {"Jammbo"},
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            local amount = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if amount < card.ability.extra.cards then
					if scored_card:is_suit(card.ability.extra.suit) and not scored_card.edition then
                    	scored_card:set_edition('e_negative', true)
						amount = amount + 1
					end
                end
            end
        end
	end
}

SMODS.Joker{
	key = "observable",
	loc_txt = {
		name = "Observable Universe",
		text = {
			"{C:dark_edition}Negative{} playing cards held",
			"in hand give {X:red,C:white}X#1#{} Mult"
		}
	},
	config = { extra = { xmult = 1.5 }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = 1}}
		return { vars = { card.ability.extra.xmult }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 0, y = 4},
	rarity = 3,
	cost = 7,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Jammbo"},
	ppu_artist = {},
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card.edition and context.other_card.edition.negative then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
	end,
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if playing_card.edition and playing_card.edition.negative then
                return true
            end
        end
        return false
    end
}

--Shader for Blip by Ben Roffey
--See CRTshutoff.fs
local CRT_shutoff
CRT_shutoff = SMODS.ScreenShader{
	key = "CRTshutoff",
	path = "CRTshutoff.fs",
	order = 10,
	startTime = -2.0,
	apply = false,
	send_vars = function(self)
		return{
			startTime = self.startTime,
			time = G.TIMERS.REAL
		}
	end,
	should_apply = function(self)
		return self.apply
	end
}

SMODS.Joker{
	key = "Big Blip",
	loc_txt = {
		name = "The Big Blip",
		text = {
			"When Blind {C:red}failed{}",
			"restart your run with",
			"the same {C:green}Seed{}"
		}
	},
	config = { extra = {  }},
	loc_vars = function(self, info_queue, card)
		return { vars = {  }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 1, y = 2},
	rarity = 2,
	cost = 7,
	blueprint_compat = false,
	discovered = true,
	eternal_compat = false,
	perishable_compat = false,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Sn0vvBall", "Ben Roffey"},
	ppu_artist = {"Sn0vvBall"},
	calculate = function(self, card, context)
		local GameSeed = G.GAME.pseudorandom.seed
		local GameSeeded = G.GAME.seeded -- Store whether or not this run was seeded
		local GameStake = G.GAME.stake
		local GameChallange = G.GAME.challenge
		if context.end_of_round and context.game_over and context.main_eval then
			--instead of calling G.FUNCS.start_run(e, args), just do what it does and set the seed after run creation
			CRT_shutoff.startTime = G.TIMERS.REAL
			CRT_shutoff.apply = true
			G.SETTINGS.paused = true 
			G.E_MANAGER:clear_queue() 
			G.FUNCS.wipe_on() 
			G.E_MANAGER:add_event(Event({
			no_delete = true,
			func = function()
				G:delete_run()
				return true
			end
			}))
			G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			no_delete = true,
			func = function()
				G:start_run({stake = GameStake, seed = GameSeed, challenge = GameChallange})
				G.GAME.seeded = GameSeeded -- Set the new run to the same value as earlier
				return true
			end
			}))
			G.FUNCS.wipe_off()
			G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 2,
			blocking = false,
			no_delete = true,
			func = function()
				CRT_shutoff.apply = false
				return true
			end
			}))
        end
	end
}

SMODS.Joker{
	key = "bigbang",
	loc_txt = {
		name = "The Big Bang Theory",
		text = {
			"Sell {C:attention}#1#{} Jokers to store",
			"enough compacted energy to",
			"create a {V:1}Legendary{} Joker"
		}
	},
	config = { extra = {JokerCount = 0, JokerNeed = 15}},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.JokerNeed, colours = {G.C.RARITY.Legendary} }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 2, y = 2},
	rarity = 3,
	cost = 5,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Sn0vvBall"},
	ppu_artist = {"Sn0vvBall"},
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == 'Joker' then
			card.ability.extra.JokerCount = card.ability.extra.JokerCount + 1
			if card.ability.extra.JokerCount == 15 then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						play_sound('timpani')
						SMODS.add_card({ set = 'Joker', legendary = true })
						check_for_unlock { type = 'spawn_legendary' }
						card:remove()
						return true
					end
				}))
				delay(0.6)
				SMODS.calculate_effect({message = "Bazinga!", card})
			end
		card.ability.extra.JokerNeed = 15 - card.ability.extra.JokerCount
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
	config = { extra = {  }},
	loc_vars = function(self, info_queue, card)
		return { vars = {  }}
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
			"poker hands by 1",
			"{s:0.8}Created by team {s:0.8,V:1}People Found In Vegas{}",
			"{s:0.8}Code & Art by {s:0.8,C:chips}Ben Roffey{}"
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
	loc_vars = function()
		return { vars = {colours = {HEX("73fdff")}}}
	end,
	collection_loc_vars = function(self)
		return { vars = {colours = {HEX("73fdff")}}}
	end,
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

local TIMERTIME = 2*60 --for DynaTextEffect to read, set to HeatDeath.config.extra.current 

SMODS.DynaTextEffect {
    key = "vegas_timer",
    func = function (self, index, letter)
		local minutes = math.floor(TIMERTIME/60)
		local seconds = TIMERTIME - minutes*60
		if TIMERTIME > 59 then 
			letter.colour = G.C.WHITE 
		else
			letter.colour = G.C.RED
		end
		if index == 1 then
			letter.letter:set(tostring(minutes))
		elseif index == 3 then
			letter.letter:set(tostring(math.floor(seconds/10)))
		elseif index == 4 then
			letter.letter:set(tostring(seconds%10)) 
		end
    end
}

--Sound Synthesis for Heat Death Blind
local rate      = 44100 -- samples per second
local length    = 25  -- seconds
local totalSamples = math.floor(length*rate)
local soundData = love.sound.newSoundData(totalSamples, rate, 16, 1)
for i=0, soundData:getSampleCount() - 1 do
	frequency = math.random() * 2 - 1 -- noise
	volume = i / (totalSamples - 1) --volume ramp increasing smoothly from 0 to 1
	soundData:setSample(i, frequency * volume) 
end
local source = love.audio.newSource(soundData)
local function noise(volume) 
	source:setVolume(volume or 0.5)
	source:play() 
end

local function create_space_cutscene() --UI function
    return {
        n=G.UIT.ROOT, 
        config={align = 'cm', colour = G.C.CLEAR}, 
        nodes={
            {n=G.UIT.O, config={id = 'jimbo_spot', object = Moveable(0,0,G.CARD_W*1.1, G.CARD_H*1.1)}}
        }
    }
end

local function lose_the_game(quipvalue)
	--modified from game.lua Game:update_game_over(dt) --- display game over screen
	remove_save()

	if G.GAME.round_resets.ante <= G.GAME.win_ante then
		if not G.GAME.seeded and not G.GAME.challenge then
			inc_career_stat('c_losses', 1)
			set_deck_loss()
			set_joker_loss()
		end
	end

	play_sound('negative', 0.5, 0.7)
	play_sound('whoosh2', 0.9, 0.7)

	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu{
		definition = create_UIBox_game_over(),
		config = {no_esc = true}
	}
	G.ROOM.jiggle = G.ROOM.jiggle + 3
        
	if G.GAME.round_resets.ante <= G.GAME.win_ante then --Only add Jimbo to say a quip if the game over happens when the run is lost
            local Jimbo = nil
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0,
                blocking = false,
                func = (function()
                    if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot') then 
                        Jimbo = Card_Character({x = 0, y = 5})
						Jimbo.children.card:set_sprites(G.P_CENTERS.j_space)
                        local spot = G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot')
                        spot.config.object:remove()
                        spot.config.object = Jimbo
                        Jimbo.ui_object_updated = true
                        Jimbo:add_speech_bubble('lq_'..quipvalue, nil, {quip = true}) --quip is generated during the cutscene, so copied here
						Jimbo.children.speech_bubble.states.visible = true
                        end
                    return true
                end)
            }))
        end
	--
end

local function tags_visible(bool)
	for i = 1, #G.HUD_tags do
		G.HUD_tags[i].states.visible = bool
	end
end

local float_in 
float_in = function(Jimbo, times) --sends the jimbo spinning across the screen. apologies for abusing the event manager this way!!
	if not times then return end
	if not Jimbo then return end
	if times > 0 then
		times = times - 1
		G.E_MANAGER:add_event(Event {
			blockable = false,
			blocking = false,
			pause_force = true,
			no_delete = true,
			trigger = "after",
			delay = 0.01,
			func = function()
				Jimbo.T.x = Jimbo.T.x + 0.03
				Jimbo.T.y = Jimbo.T.y - 0.03
				Jimbo.T.r = Jimbo.T.r - 0.02
				float_in(Jimbo, times)
				return true
			end
		})
	end
end

local adjust_time
adjust_time = function(heatdeath)
	local speed = G.SETTINGS.GAMESPEED
	if speed < heatdeath.config.extra.gamespeed then
		heatdeath.config.extra.gamespeed = heatdeath.config.extra.gamespeed / 2
		heatdeath.config.extra.current = math.floor(heatdeath.config.extra.current * heatdeath.config.gamespeed_factor)
		TIMERTIME = heatdeath.config.extra.current
		adjust_time(heatdeath)
		return
	end
	if speed > heatdeath.config.extra.gamespeed then
		heatdeath.config.extra.gamespeed = heatdeath.config.extra.gamespeed * 2
		heatdeath.config.extra.current = math.floor(heatdeath.config.extra.current / heatdeath.config.gamespeed_factor)
		TIMERTIME = heatdeath.config.extra.current
		adjust_time(heatdeath)
		return
	end
end

--Recursive Event for Heat Death Blind
local heatdeath_timer 
heatdeath_timer = function(heatdeath)
    G.E_MANAGER:add_event(Event {
        blockable = false,
        blocking = false,
        pause_force = true,
        no_delete = true,
        trigger = "after",
        delay = 1,
        func = function()
			if heatdeath.config.timing then
				
				--stop if Heat Death is rerolled
				if G.GAME.round_resets.blind_choices.Boss ~= "bl_worm_heatdeath" then
					TIMERTIME = heatdeath.config.time
					heatdeath.config.extra.current = heatdeath.config.time
					heatdeath.config.timing = false
					source:stop()
					return true
				end
				
				adjust_time(heatdeath) --gamespeed check

				--countdown
				heatdeath.config.extra.current = heatdeath.config.extra.current - 1
				TIMERTIME = heatdeath.config.extra.current

				--play a sound
				if heatdeath.config.extra.current % 2 == 0 then
					play_sound("worm_vegas_tick")
				else
					play_sound("worm_vegas_tock")
				end

				if heatdeath.config.extra.current == 20 then --display 20 second warning
					attention_text({
						scale = 0.7, text = "0:20", colour = G.C.MULT, maxw = 12, hold = 1, align = 'cm', offset = {x = 0,y = -1},major = G.play
					})
				end

				if heatdeath.config.extra.current <= 20 then --start the noise sound
					if source:isPlaying() == false then	
						noise(0.1) --Play noise at volume 0.1 (any more and it is too loud! it ramps up from 0, reaching 0.1 after 20 seconds)
					end
					
				end

				if heatdeath.config.extra.current <= 10 and heatdeath.config.extra.current > 0 then --display a warning every second
					local minutes = math.floor(heatdeath.config.extra.current/60)
					local seconds = heatdeath.config.extra.current - minutes*60
					disp_text = minutes..":".. string.format("%02d", seconds)
					attention_text({
						scale = 0.7, text = disp_text, colour = G.C.MULT, maxw = 12, hold = 1, align = 'cm', offset = {x = 0,y = -1},major = G.play
					})
					if G.GAME.blind.config.blind.key == "bl_worm_heatdeath" then
						G.GAME.blind.children.animatedSprite.T.scale = G.GAME.blind.children.animatedSprite.T.scale * 1.5 --makes the blind chip bigger, appearing to consume the screen
					end
				end
				
				if heatdeath.config.extra.current == 0 then ------------ IF TIMER REACHES 0
					
					heatdeath.config.timing = false --stop the timer
					heatdeath.config.game_over_override = true --stops the timer from restarting until after the game over screen is displayed

					ease_background_colour({new_colour = G.C.BLACK}) --turn the screen black (in case player was not on the boss blind)
					if G.GAME.blind.config.blind.key == "bl_worm_heatdeath" then
						G.GAME.blind.children.animatedSprite.T.scale = 60 --fully black background if on the boss blind
					end

					source:stop() --stop the noise
					restoreVolume = G.SETTINGS.SOUND.music_volume
					G.SETTINGS.SOUND.music_volume = 0 -- mute all music
					G.STATE = G.STATES.GAME_OVER --Slow down the music for game over
					restoreSFX = G.SETTINGS.SOUND.game_sounds_volume
					G.SETTINGS.SOUND.game_sounds_volume = 0 --mute all sfx

					G.hand.states.visible = false --make cardareas invisible
					G.jokers.states.visible = false
					G.consumeables.states.visible = false
					G.deck.states.visible = false
					if G.buttons then G.buttons:remove() end
					tags_visible(false)
					G.HUD.states.visible = false
					if G.GAME.blind.config.blind.key ~= "bl_worm_heatdeath" then 
						G.HUD_blind.states.visible = false
					end

					G.GAME.blind.config.blind = heatdeath --Set this for correct reason for death

					G.FUNCS.overlay_menu{ --Create an overlay menu with a jimbo spot
						definition = create_space_cutscene(),
						config = {no_esc = true}
					}
					local spot = G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot')
					spot.config.object:remove()

					--Add particles in the background (stars)
					spot.particles = Particles(0, 0, 0, 0, {
						timer = 0.03,
						scale = 0.1,
						speed = 0.1,
						lifespan = 2,
						attach = spot,
						colours = {G.C.WHITE},
						fill = true
					})
					spot.particles.T.x = 0
					spot.particles.T.y = 0
					spot.particles.T.w = 20 --fill the screen
					spot.particles.T.h = 10

					Jimbo = Card_Character({y = 15}) --Create a space joker offscreen
					Jimbo.children.card:set_sprites(G.P_CENTERS.j_space)
					Jimbo.children.particles:remove() --default particles are red/orange

					--have Space Joker float up 
					float_in(Jimbo, 1000)

					quipvalue = math.random(1,10)

					G.E_MANAGER:add_event(Event{ --After some more time, space jimbo says a quip
						blockable = false,
						blocking = false,
						pause_force = true,
						no_delete = true,
						trigger = 'after',
						delay = 4,
						func = function()
							G.SETTINGS.SOUND.game_sounds_volume = restoreSFX
							Jimbo:add_speech_bubble('lq_'..quipvalue, nil, {quip = true})
							Jimbo:say_stuff(5)
							return true
						end
					})

					--display the usual death screen after some time
					G.E_MANAGER:add_event(Event{
						blockable = false,
						blocking = false,
						pause_force = true,
						no_delete = true,
						trigger = 'after',
						delay = 11,
						func = function()
							Jimbo:remove() --jimbo is off screen now
							lose_the_game(quipvalue) --display game over menu, spawns a space joker with the same quip
							G.hand.states.visible = true --restore visibiliy and volume
							G.jokers.states.visible = true
							G.consumeables.states.visible = true
							G.deck.states.visible = true
							tags_visible(true)
							G.HUD.states.visible = true
							G.HUD_blind.states.visible = true
							G.SETTINGS.SOUND.music_volume = restoreVolume --unmute the music for the game over screen
							heatdeath.config.game_over_override = false --reset override 
							return true
						end
					})

					--Reset variables for next time Heat Death shows up
					TIMERTIME = heatdeath.config.time
					heatdeath.config.extra.current = heatdeath.config.time
					heatdeath.config.timing = false
					heatdeath.config.extra.gamespeed = heatdeath.config.base_speed

					return true
				end

				--repeat
				heatdeath_timer(heatdeath)
				return true
			end
        end
    })
end

SMODS.Sound{
	key = "vegas_tick",
	path = "vegas/tick.wav"
}

SMODS.Sound{
	key = "vegas_tock",
	path = "vegas/tock.wav"
}

SMODS.Blind{
	key = "heatdeath",
	loc_txt = {
		name = "Heat Death",
		text = {
			"{E:worm_vegas_timer}#1#:#2#",
			"{s:0.8}Created by team {s:0.8,V:1}People Found In Vegas{}",
			"{s:0.8}Code & Art by {s:0.8,C:chips}Ben Roffey{}"
		}
	},
	config = {time = 2*60, timing = false, game_over_override = false, gamespeed_factor = 1.5, base_speed = 4, extra = {gamespeed = 4, current = 2*60}},
	loc_vars = function(self)
		adjust_time(self)
		local minutes = math.floor(self.config.extra.current/60)
		local seconds = self.config.extra.current - minutes*60
		
		if self.config.timing == false and self.config.game_over_override == false then
			TIMERTIME = self.config.extra.current

			self.config.timing = true
			heatdeath_timer(self)
		end

		return { vars = { minutes, string.format("%02d", seconds), colours = {HEX("73fdff")} }}
	end,
	get_loc_debuff_text = function(self)
		local minutes = math.floor(self.config.extra.current/60)
		local seconds = self.config.extra.current - minutes*60
		disp_text = minutes..":".. string.format("%02d", seconds)
		return {
			disp_text
		}
	end,
	collection_loc_vars = function(self)
		adjust_time(self)
		local minutes = math.floor(self.config.extra.current/60)
		local seconds = self.config.extra.current - minutes*60
		return { vars = { minutes, string.format("%02d", seconds), colours = {HEX("73fdff")} }}
	end,
	atlas = "vegas_blinds",
	pos = {x = 0, y = 1},
	discovered = true,
	boss = {min = 1},
	dollars = 5,
    mult = 2,
	boss_colour = HEX("000000"),
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Ben Roffey"},
	ppu_artist = {"Ben Roffey"},
	calculate = function(self, blind, context)
		if context.end_of_round then
			self.config.timing = false
			self.config.extra.current = self.config.time
			self.config.extra.gamespeed = self.config.base_speed
			G.GAME.blind.children.animatedSprite.T.scale = 1
			if source then 
				source:stop()
			end
		end
	end,
	disable = function(self)
		self.config.timing = false
		if source then 
			source:stop()
		end
	end,
	defeat = function(self)
		self.config.timing = false
		self.config.extra.current = self.config.time
		self.config.extra.gamespeed = self.config.base_speed
		G.GAME.blind.children.animatedSprite.T.scale = 1
		if source then 
			source:stop()
		end
	end
}

--Consumeables
SMODS.Consumable {
    key = 'expanse',
    set = 'Spectral',
	loc_txt = {
		name = "Expanse",
		text = {
			"Add {C:dark_edition}Negative{} to up",
			"to {C:attention}#1#{} selected playing cards"
		}
	},
	atlas = "vegas_jokers",
    pos = { x = 4, y = 3 },
	pixel_size = { w = 69 },
	discovered = true,
    config = { max_highlighted = 2 },
	ppu_team = {"People Found In Vegas"},
    ppu_coder = {"Jammbo"},
    ppu_artist = {"Jammbo"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = 1}}
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                G.hand.highlighted[1]:set_edition("e_negative", true)
                card:juice_up(0.3, 0.5)
				if #G.hand.highlighted == 2 then
					G.hand.highlighted[2]:set_edition("e_negative", true)
					card:juice_up(0.3, 0.5)
				end
                return true
            end
        }))
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.PokerHand{
	key = "keplerhand",
	chips = 4,
	mult = 1, 
	l_chips = 0,
	l_mult = 0,
	example = {},
	visible = false,
	evaluate = function(parts, hand)
		return false
	end,
	loc_txt = {},
	no_collection = true
}
SMODS.Consumable {
    key = 'kepler',
    set = 'Planet',
	loc_txt = {
		name = "Kepler-186 f",
		text = {
			"Permanently adds {C:white,X:mult}X#1#{} Mult",
			"to {C:attention}#2#{} selected cards in hand"
		}
	},
	atlas = "vegas_exoplanets",
	set_card_type_badge = function(self, card, badges)
 		badges[#badges] = create_badge("Exoplanet", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1 )
 	end,
    pos = { x = 0, y = 0 },
	discovered = true,
    config = { xmult = 0.1, max_highlighted = 2, hand_type = "worm_keplerhand"},
	ppu_team = {"People Found In Vegas"},
    ppu_coder = {"Ben Roffey"},
    ppu_artist = {"Ben Roffey"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.xmult, card.ability.max_highlighted } }
    end,
	select_card = "consumeables",
	can_use = function(self, card)
		return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
    use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				delay = (i - 1) * 0.2,
				func = function()
					SMODS.calculate_effect({
						message = localize('k_upgrade_ex'),
						colour = G.C.MULT
					}, G.hand.highlighted[i])
					return true
				end
			})
			G.hand.highlighted[i].ability.perma_x_mult = G.hand.highlighted[i].ability.perma_x_mult or 1
			G.hand.highlighted[i].ability.perma_x_mult = G.hand.highlighted[i].ability.perma_x_mult + card.ability.xmult
		end
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = #G.hand.highlighted * 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
}

SMODS.PokerHand{
	key = "gjhand",
	chips = 3,
	mult = 1, 
	l_chips = 0,
	l_mult = 0,
	example = {},
	visible = false,
	evaluate = function(parts, hand)
		return false
	end,
	loc_txt = {},
	no_collection = true
}
SMODS.Consumable {
    key = 'gj',
    set = 'Planet',
	loc_txt = {
		name = "GJ 504 b",
		label = "Exoplanet",
		text = {
			"Permanently adds {C:mult}+#1#{} Mult",
			"to {C:attention}#2#{} selected cards in hand"
		}
	},
	atlas = "vegas_exoplanets",
	set_card_type_badge = function(self, card, badges)
 		badges[#badges] = create_badge("Exoplanet", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1 )
 	end,
    pos = { x = 1, y = 0 },
	discovered = true,
    config = { mult = 1, max_highlighted = 2, hand_type = "worm_gjhand"},
	ppu_team = {"People Found In Vegas"},
    ppu_coder = {"Ben Roffey"},
    ppu_artist = {"Ben Roffey"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult, card.ability.max_highlighted } }
    end,
	select_card = "consumeables",
	can_use = function(self, card)
		return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
    use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				delay = (i - 1) * 0.2,
				func = function()
					SMODS.calculate_effect({
						message = localize('k_upgrade_ex'),
						colour = G.C.MULT
					}, G.hand.highlighted[i])
					return true
				end
			})
			G.hand.highlighted[i].ability.perma_mult = G.hand.highlighted[i].ability.perma_mult or 0
			G.hand.highlighted[i].ability.perma_mult = G.hand.highlighted[i].ability.perma_mult + card.ability.mult
		end
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = #G.hand.highlighted * 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
}

SMODS.PokerHand{
	key = "wasphand",
	chips = 2,
	mult = 1, 
	l_chips = 0,
	l_mult = 0,
	example = {},
	visible = false,
	evaluate = function(parts, hand)
		return false
	end,
	loc_txt = {},
	no_collection = true
}
SMODS.Consumable {
    key = 'wasp',
    set = 'Planet',
	loc_txt = {
		name = "Wasp J1407b",
		label = "Exoplanet",
		text = {
			"Permanently adds {C:chips}+#1#{} Chips",
			"to {C:attention}#2#{} selected cards in hand"
		}
	},
	atlas = "vegas_exoplanets",
	set_card_type_badge = function(self, card, badges)
 		badges[#badges] = create_badge("Exoplanet", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1 )
 	end,
    pos = { x = 2, y = 0 },
	discovered = true,
    config = { chips = 10, max_highlighted = 2, hand_type = "worm_wasphand"},
	ppu_team = {"People Found In Vegas"},
    ppu_coder = {"Ben Roffey"},
    ppu_artist = {"Ben Roffey"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips, card.ability.max_highlighted } }
    end,
	select_card = "consumeables",
	can_use = function(self, card)
		return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
    use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				delay = (i - 1) * 0.2,
				func = function()
					SMODS.calculate_effect({
						message = localize('k_upgrade_ex'),
						colour = G.C.CHIPS
					}, G.hand.highlighted[i])
					return true
				end
			})
			G.hand.highlighted[i].ability.perma_bonus = G.hand.highlighted[i].ability.perma_bonus or 0
			G.hand.highlighted[i].ability.perma_bonus = G.hand.highlighted[i].ability.perma_bonus + card.ability.chips
		end
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = #G.hand.highlighted * 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
}

--Deck (Test)
SMODS.Back {
	key = "colonist",
    loc_txt = {
        name = "Colonist Deck",
        text = {
            "Start with {C:chips}Banner{},",
			"and {C:blue}Planet Merchant{}",
			"Hands start at level {C:attention}0",
			"{s:0.8}Created by team {s:0.8,C:money}People Found In Vegas{}",
			"{s:0.8}Code & Art by {s:0.8,C:green}Jammbo{}"
        }
    },
	config = { jokers = { "j_banner" }, vouchers = { "v_planet_merchant" } },
    atlas = "vegas_jokers",
    pos = {x = 3, y = 3},
	discovered = true,
	unlocked = true,
	apply = function(self, back)
		local args = { level_up = -1, instant = true }
        SMODS.upgrade_poker_hands(args)
	end
}

