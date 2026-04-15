SMODS.Atlas({
	key = "jtem2_alien_alien",
	path = "Jtem 2/jokers/alien_alien.png",
	px = 71,
	py = 95,
	atlas_table = "ANIMATION_ATLAS",
	frames = 2,
	fps = 2,
})

SMODS.Joker({
	key = "jtem2_alien_alien",
	atlas = "jtem2_alien_alien",

	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "aikoyori" },

	rarity = 2,
	cost = 5,

	blueprint_compat = true,
	eternal_compat = true,
	rental_compat = true,

	config = {
		extras = {
			n = 1,
			d = 3,
		},
	},
	loc_vars = function(self, info_queue, card)
		local n, d =
			SMODS.get_probability_vars(card, card.ability.extras.n, card.ability.extras.d, "worm_jtem2_alien_alien")
		return {
			vars = {
				n,
				d,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable then
			if
				context.consumeable.config.center.set == "Planet"
				and SMODS.pseudorandom_probability(
					card,
					"worm_jtem2_alien_alien",
					card.ability.extras.n,
					card.ability.extras.d
				)
			then
				return {
					message = localize("k_plus_tarot"),
					func = function()
						WORM_JTEM.simple_event_add(function()
							SMODS.add_card({ set = "Tarot" })
							return true
						end, 0)
					end,
				}
			end
		end
	end,
})
