SMODS.Atlas({
	key = "jtem2_operation_plumbbob",
	path = "Jtem 2/jokers/lol bye.png",
	px = 71,
	py = 95,
})

SMODS.Joker({
	atlas = "jtem2_operation_plumbbob",
	key = "jtem2_operation_plumbbob",

	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "missingnumber" },

	cost = 7,
	rarity = 3,

	blueprint_compat = false,

	config = {
		extras = {
			do_it_once = 0,
		},
	},
	loc_vars = function(self, info_queue, card) end,
	calculate = function(self, card, context)
		if context.hand_drawn then
			card.ability.extras.do_it_once = 0
		end
		if context.destroy_card then
			local all_planets = WORM_JTEM.filter_table(G.consumeables.cards, function(c, i, l)
				return c.ability and c.ability.set == "Planet" and not c.getting_sliced
			end, true, true)
			if context.destroy_card and context.destroy_card.area == G.play and #all_planets > 0 then
				return {
					remove = true,
					func = function()
						card.ability.extras.do_it_once = (card.ability.extras.do_it_once or 0) + 1
						if card.ability.extras.do_it_once == 1 then
							WORM_JTEM.simple_event_add(function()
								local pick_a_planet = pseudorandom_element(all_planets, "worm_jtem2_plumbbob_planet")
								SMODS.destroy_cards({ pick_a_planet })
								return true
							end)
						end
					end,
				}
			end
		end
	end,
})
