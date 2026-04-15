SMODS.Atlas({
	key = "jtem2_black_hole_seal",
	path = "Jtem 2/seals/black_hole_seal.png",
	px = 71,
	py = 95,
})


SMODS.Seal {
	key = "jtem2_black_hole",
	atlas = "jtem2_black_hole_seal",

	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "missingnumber" },
    badge_colour = HEX('ff4c00'),
	loc_vars = function (self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, 3, "jtem2_black_hole_seal_upgrade")
		local n2, d2 = SMODS.get_probability_vars(card, 1, 5, "jtem2_black_hole_seal_destroy")
		return {
			vars = {
				n, d, n2, d2
			}
		}
	end,
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },
	calculate = function (self, card, context)
		if context.before and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "jtem2_black_hole_seal_upgrade", 1, 3) then
			local visible_hands = WORM_JTEM.filter_table(G.handlist, function (hand, i)
				return SMODS.is_poker_hand_visible(hand)
			end, true, true)
			local hand_to_level_up = pseudorandom_element(visible_hands, "jtem2_black_hole_seal_poker_hand")
			return {
				level_up_hand = hand_to_level_up,
				level_up = 1,
			}
		end
		if context.destroy_card and context.destroy_card == card and context.cardarea == G.play 
			and SMODS.pseudorandom_probability(card, "jtem2_black_hole_seal_destroy", 1, 5) then
			return {
				remove = true
			}
		end
	end
}
