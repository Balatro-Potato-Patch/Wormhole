

SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Shinku'},
    ppu_coder = {'Minty'},
	key = 'mrrp_cats_eye_nebula',
	atlas = "mrrp",
	pos = {
		x=1,
		y=3
	},
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    attributes = {'space', "cat"},

	config = {
		extra = {
			chips = 75,
            fall = 3,
            levels = 2
		}
	},
	loc_vars = function (self, info_queue, card)
        local chips = card.ability.extra.chips
        local fall = card.ability.extra.fall
		return {
			vars = {
				Wormhole.mrrp_signed(chips),
				Wormhole.mrrp_signed(fall, true),
				card.ability.extra.levels,
			}
		}
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and card.ability.extra.chips > 0 and not context.blueprint then
            return {
                func = function ()
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "chips",
                        scalar_value = "fall",
                        operation = "-",
                        scaling_message = {
                            message = localize("k_flaring"),
                            colour = G.C.CHIPS,
                            delay = 0.5
                        }
                    })
                end
            }
        end

        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.after and card.ability.extra.chips <= 0 and not context.blueprint and not card.getting_sliced then
            card.getting_sliced = true
            local sign = card.ability.extra.levels >= 0 and "+" or "-"
            G.E_MANAGER:add_event(Event{
                func = function ()
                    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                        { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            play_sound('tarot1')
                            card:juice_up(0.8, 0.5)
                            G.TAROT_INTERRUPT_PULSE = true
                            return true
                        end
                    }))
                    update_hand_text({ delay = 0 }, { mult = sign, StatusText = true })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.9,
                        func = function()
                            play_sound('tarot1')
                            card:juice_up(0.8, 0.5)
                            return true
                        end
                    }))
                    update_hand_text({ delay = 0 }, { chips = sign, StatusText = true })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.9,
                        func = function()
                            play_sound('tarot1')
                            card:juice_up(0.8, 0.5)
                            G.TAROT_INTERRUPT_PULSE = nil
                            return true
                        end
                    }))
                    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = sign..math.abs(card.ability.extra.levels) })
                    delay(1.3)
                    SMODS.upgrade_poker_hands({ instant = true, level_up = card.ability.extra.levels })
                    update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                        { mult = 0, chips = 0, handname = '', level = '' })

                    SMODS.destroy_cards(card, nil, nil, true)
                    return true
                end
            })
            return { no_retrigger = true }
        end
	end
}