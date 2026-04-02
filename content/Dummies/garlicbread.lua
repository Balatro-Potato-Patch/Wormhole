-- So we sent Garlic Bread into space... then ate it.

SMODS.Atlas {
	key = "DummiesGarlicBread",
	path = "Dummies/garlicbread.png",
	px = 71,
	py = 95
}

SMODS.Joker{
	key = 'dum_garlicbread',
	config = { extra = { pc = 0, pcm = 6 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.pc, card.ability.extra.pcm } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'DummiesGarlicBread',
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
			if not context.blueprint then
				if card.ability.extra.pc < card.ability.extra.pcm then
					card.ability.extra.pc = (card.ability.extra.pc or 0) + 1
					SMODS.calculate_effect({ message = tostring(card.ability.extra.pc) }, card)
				end
			end
			
			if card.ability.extra.pc >= card.ability.extra.pcm then
				local ctx = context
				card.ability.extra.pc = 0
				return { func = function()
					update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 }, { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
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
					update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.9,
						func = function()
							play_sound('tarot1')
							card:juice_up(0.8, 0.5)
							return true
						end
					}))
					update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
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
					update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
					delay(1.3)
					SMODS.upgrade_poker_hands({ from = ctx.retrigger_joker or ctx.blueprint_card or card, instant = true })
					update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 }, { mult = 0, chips = 0, handname = '', level = '' })
				end }
			end
		end
	end,
	pixel_size = { w = 69, h = 61 },
	ppu_coder = { "theonegoofali" },
    ppu_team = { "dummies" },
}