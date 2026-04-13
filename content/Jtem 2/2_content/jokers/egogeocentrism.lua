SMODS.Atlas({
	key = "jtem2_egogeocentrism",
	path = "Jtem 2/jokers/ego.png",
	px = 71,
	py = 95,
})

SMODS.Joker({
	key = "jtem2_egogeocentrism",

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
	ppu_artist = { "missingnumber" },

	rarity = 2,
	cost = 7,

	blueprint_compat = true,
	eternal_compat = true,
	rental_compat = true,

	atlas = "jtem2_egogeocentrism",
	pos = { x = 0, y = 0 },

	config = {
		extra = {
			odds = 2,
		},
	},

	loc_vars = function(self, info_queue, card)
		local nominator, denominator =
			SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "jtem2_egogeocentrism")
		return {
			vars = {
				localize("Full House", "poker_hands"),
				localize("King", "ranks"),
				nominator,
				denominator,
			},
		}
	end,

	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
		then
			if
				context.scoring_name == "Full House"
				and (context.other_card:get_id() == 13)
				and SMODS.pseudorandom_probability(card, "jtem2_egogeocentrism", 1, card.ability.extra.odds)
			then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				return {
					extra = {
						message = localize("k_plus_planet"),
						colour = G.C.SECONDARY_SET.Planet,
						message_card = card,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									SMODS.add_card({
										set = "Planet",
										key_append = "jtem2_egogeocentrism",
									})
									G.GAME.consumeable_buffer = 0
									return true
								end,
							}))
						end,
					},
				}
			end
		end
	end,
})

local old_set_consumeable_usage = set_consumeable_usage
function set_consumeable_usage(card, ...)
	if card.config.center_key and card.ability.consumeable then
		if card.config.center.set == "Planet" then
			G.E_MANAGER:add_event(Event({
				trigger = "immediate",
				func = function()
					G.E_MANAGER:add_event(Event({
						trigger = "immediate",
						func = function()
							G.GAME.worm_last_used_planet = card.config.center_key
							return true
						end,
					}))
					return true
				end,
			}))
		end
	end
	return old_set_consumeable_usage(card, ...)
end
