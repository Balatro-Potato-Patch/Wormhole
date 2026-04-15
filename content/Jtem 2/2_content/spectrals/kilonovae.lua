SMODS.Atlas({
	key = "jtem2_kilonovae",
	path = "Jtem 2/spectrals/kilonovae.png",
	px = 71,
	py = 95,
})

SMODS.Consumable {
	key = "jtem2_kilonovae",
	atlas = "jtem2_kilonovae",
	set = "Spectral",
	config = {
        max_highlighted = 2,
	},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				card.ability.max_highlighted
			}
		}
	end,
	use = function (self, card, area, copier)
		WORM_JTEM.do_things_to_card(G.hand.highlighted,function (card, index)
			card:juice_up(0.3, 0.5)
			if card.seal == "worm_jtem2_black_hole" then
				card:set_seal("worm_jtem2_supermassive_black_hole", nil, true)
			elseif card.seal ~= "worm_jtem2_supermassive_black_hole" then
				card:set_seal("worm_jtem2_black_hole", nil, true)
			end
		end)
	end
}