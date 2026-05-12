SMODS.Atlas({
	key = "stargaze_deck",
	px = 71,
	py = 95,
	path = "Stargaze/deck.png"
})

local function nope(back)
	G.E_MANAGER:add_event(Event {
		blocking = false,
		func = function(n)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.06 * G.SETTINGS.GAMESPEED,
				blockable = false,
				blocking = false,
				func = function()
					play_sound('tarot2', 0.76, 0.4); return true
				end
			}))
			play_sound('tarot2', 1, 0.4)
			return true
		end
	})
	SMODS.calculate_effect({ message = localize('k_nope_ex'), colour = G.C.SECONDARY_SET.Tarot }, back)
end

SMODS.Back({
	key = "sg_cosmos",
	pos = { x = 0, y = 0 },
	atlas = "stargaze_deck",
	ppu_coder = { "FALATRO" },
	ppu_artist = { "KaitlynTheStampede", "DanielDeisar" },
	ppu_team = { "Stargaze" },
	unlocked = true,
	config = { extra = { num = 1, den = 2 } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { self.config.extra.num, self.config.extra.den }
		}
	end,

	calculate = function(self, back, context)
		if context.using_consumeable and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			if context.consumeable and context.consumeable.ability and context.consumeable.ability.set == "Planet" then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						local num, den = self.config.extra.num, self.config.extra.den

						local r = SMODS.pseudorandom_probability(
							back,
							"cosmos_roll_" .. G.GAME.round_resets.ante,
							num, den,
							"worm_cosmos_deck"
						)
						if not r then
							nope(G.deck.cards[1])
							return true
						end

						local polled = SMODS.poll_object({ types = { "Tarot", "Spectral" } })
						if polled ~= "UNAVAILABLE" then
							SMODS.add_card({
								key = polled,
								discover = true,
								bypass_discovery_center = true,
								key_append = "cosmos_roll",
								area = G.consumeables
							})
						else -- This is ridiculously unlikely
							nope(G.deck.cards[1])
						end
                        G.GAME.consumeable_buffer = 0
						return true
					end
				}))
			end
		end
	end,

	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				SMODS.add_card({ key = "j_space", edition = "e_negative" })
				return true
			end
		}))
	end
})
