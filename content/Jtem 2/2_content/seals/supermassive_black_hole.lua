SMODS.Atlas({
	key = "jtem2_supermassive_black_hole_seal",
	path = "Jtem 2/seals/supermassive_black_hole_seal.png",
	px = 71,
	py = 95,
})

SMODS.Seal({
	key = "jtem2_supermassive_black_hole",
	atlas = "jtem2_supermassive_black_hole_seal",

	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "missingnumber", "aikoyori" },
	badge_colour = HEX("333c64"),

	config = {
		levelup_odds = 3,
		destroy_odds = 5,
	},

	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(
			card,
			1,
			card.ability.seal.levelup_odds,
			"jtem2_supermassive_black_hole_seal_upgrade"
		)
		local n2, d2 = SMODS.get_probability_vars(
			card,
			1,
			card.ability.seal.destroy_odds,
			"jtem2_supermassive_black_hole_seal_destroy"
		)
		return {
			vars = {
				n,
				d,
				n2,
				d2,
			},
		}
	end,
	sound = { sound = "generic1", per = 1.2, vol = 0.4 },
	calculate = function(self, card, context)
		if
			context.before
			and context.cardarea == G.play
			and SMODS.pseudorandom_probability(
				card,
				"jtem2_supermassive_black_hole_seal_upgrade",
				1,
				card.ability.seal.levelup_odds
			)
		then
			return {
				level_up = 1,
			}
		end
		if
			context.destroy_card
			and context.destroy_card == card
			and context.cardarea == G.play
			and SMODS.pseudorandom_probability(
				card,
				"jtem2_supermassive_black_hole_seal_destroy",
				1,
				card.ability.seal.destroy_odds
			)
		then
			return {
				remove = true,
			}
		end
	end,
})
