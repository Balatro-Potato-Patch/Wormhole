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
	pos = {x = 0, y = 4},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Jammbo"},
	ppu_artist = {},
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                dollars = G.GAME.hands[context.scoring_name].level
            }
        end
	end
}

SMODS.Joker{
	key = "icegiant",
	loc_txt = {
		name = "Ice Giant",
		text = {
			"If {C:attention}final discard{} of",
			"round is {C:attention}#1#{} card, make",
			"the {C:attention}first{} card {C:attention}Glass{}"
		}
	},
	config = { extra = { size = 2 }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		return { vars = { card.ability.extra.size }}
	end,
	atlas = "vegas_jokers",
	pos = {x = 0, y = 4},
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	ppu_team = {"People Found In Vegas"},
	ppu_coder = {"Jammbo"},
	ppu_artist = {},
	calculate = function(self, card, context)
		if context.discard and G.GAME.current_round.discards_left == 1 and #context.full_hand == 2 and context.other_card then
            if (context.other_card == context.full_hand[1]) or (context.other_card == context.full_hand[2]) then
				context.other_card:set_ability("m_glass", nil, true)
			end
			return{
				message = "It's ice, I promise"
			}
        end
	end
}

SMODS.Joker{
    key = "goldielocks",
    loc_txt = {
        name = "Goldielocks",
        text = {
            "If the played hand has an",
			"{C:attention}odd{} number of playing cards,",
			"retrigger the {C:attention}middle{} card {C:attention}#2#{} times",
			"If the played hand has an",
			"{C:attention}even{} number of playing cards,",
			"retrigger the {C:attention}middle 2{} cards {C:attention}#1#{} time",
        }
    },
    config = { extra = { repetitions = 1, repetitions_odd = 2 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions, card.ability.extra.repetitions_odd }}
    end,
    atlas = "vegas_jokers",
    pos = {x = 4, y = 0},
    rarity = 1,
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

local TIMERTIME = 2*60 --for DynaTextEffect to read, set to HeatDeath.config.time

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
local length    = 25  -- 0.03125 seconds
local soundData = love.sound.newSoundData(math.floor(length*rate), rate, 16, 1)
for i=0, soundData:getSampleCount() - 1 do
	soundData:setSample(i, math.random(0, 20000)) -- noise
end
local source = love.audio.newSource(soundData)
local function noise(volume) 
	source:setVolume(volume or 0.5)
	source:play() 
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
					TIMERTIME = 2*60
					heatdeath.config.time = 2*60
					heatdeath.config.timing = false
					source:stop()
					return true
				end
				
				--countdown
				heatdeath.config.time = heatdeath.config.time - 1
				TIMERTIME = heatdeath.config.time

				--play a sound
				if heatdeath.config.time % 2 == 0 then
					play_sound("worm_vegas_tick")
				else
					play_sound("worm_vegas_tock")
				end

				if heatdeath.config.time == 20 then
					noise(0.0) --Play noise starting at volume 0
				elseif heatdeath.config.time < 20 then
					source:setVolume((20 - heatdeath.config.time) * 0.005) --Increase the volume subtly each second
				end
				
				if heatdeath.config.time == 0 then
					
					--lose
					source:stop()

					G.STATE = G.STATES.GAME_OVER --Slow down the music
					G.GAME.blind.config.blind = heatdeath --Set this for correct reason for death

					--copied from game.lua Game:update_game_over(dt): display game over screen
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
							delay = 2.5,
							blocking = false,
							func = (function()
								if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot') then 
									Jimbo = Card_Character({center = G.P_CENTERS.j_space}) --Trying to find space joker here, but doesn't work?
									local spot = G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot')
									spot.config.object:remove()
									spot.config.object = Jimbo
									Jimbo.ui_object_updated = true
									Jimbo:add_speech_bubble('lq_'..math.random(1,10), nil, {quip = true})
									Jimbo:say_stuff(5)
									end
								return true
							end)
						}))
					end
					--

					--Reset variables for next time Heat Death shows up
					TIMERTIME = 2*60
					heatdeath.config.time = 2*60
					heatdeath.config.timing = false

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
			"{E:worm_vegas_timer}#1#:#2#"
		}
	},
	config = {time = 2*60, timing = false},
	loc_vars = function(self)
		local minutes = math.floor(self.config.time/60)
		local seconds = self.config.time - minutes*60
		
		if self.config.timing == false then
			TIMERTIME = self.config.time

			self.config.timing = true
			heatdeath_timer(self)
		end

		return { vars = { minutes, string.format("%02d", seconds) }}
	end,
	collection_loc_vars = function(self)
		return { vars = {2, "00"}}
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
			self.config.time = 2*60
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
		self.config.time = 2*60
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
		name = "Expansion",
		text = {
			"Add {C:purple}Negative{} effect to up",
			"to {C:attention}#1#{} selected cards in hand"
		}
	},
    pos = { x = 4, y = 4 },
	discovered = true,
    config = { max_highlighted = 2 },
	ppu_team = {"People Found In Vegas"},
    ppu_coder = {"Jammbo"},
    ppu_artist = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
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

--Deck (Test)
SMODS.Back {
	key = "singularity",
    loc_txt = {
        name = "Singularity Deck",
        text = {
            "Start with {C:chips}Banner{},",
			"and {C:blue}Planet Merchant{}",
			"Hands start at level {C:attention}0"
        }
    },
	config = { jokers = { "j_banner" }, vouchers = { "v_planet_merchant" } },
    atlas = "vegas_jokers",
    pos = {x = 0, y = 4},
	discovered = true,
	unlocked = true,
	apply = function(self, back)
		local args = { level_up = -1, instant = true }
        SMODS.upgrade_poker_hands(args)
	end
}