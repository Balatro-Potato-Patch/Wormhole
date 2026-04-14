SMODS.Atlas({
	key = "jtem2_black_hole_deck",
	path = "Jtem 2/decks/black_hole_deck.png",
	px = 71,
	py = 95,
})


SMODS.Back({
	key = "jtem2_black_hole_deck",
	atlas = "jtem2_black_hole_deck",
	ppu_team = { "jtem2" },
	ppu_artist = { "aikoyori" },
	calculate = function(self, back, context)
		-- todo: rework this so that it does something with the seal
		if context.end_of_round and context.main_eval and context.beat_boss and not context.game_over then
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
				{ handname = localize("k_all_hands"), chips = "...", mult = "...", level = "" }
			)
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.2,
				func = function()
					play_sound("tarot1")
					G.TAROT_INTERRUPT_PULSE = true
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { mult = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					return true
				end,
			}))
			update_hand_text({ delay = 0 }, { chips = "+", StatusText = true })
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.9,
				func = function()
					play_sound("tarot1")
					G.TAROT_INTERRUPT_PULSE = nil
					return true
				end,
			}))
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+1" })
			delay(1.3)
			SMODS.upgrade_poker_hands({ instant = true })
			update_hand_text(
				{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
				{ mult = 0, chips = 0, handname = "", level = "" }
			)
		end
	end,
})
