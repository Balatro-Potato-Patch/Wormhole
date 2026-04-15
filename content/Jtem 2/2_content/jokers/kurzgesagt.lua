SMODS.Atlas({
	key = "jtem2_kurzgesagt",
	path = "Jtem 2/jokers/kurzgesagt.png",
	px = 71,
	py = 95,
})

SMODS.Joker({
	atlas = "jtem2_kurzgesagt",
	key = "jtem2_kurzgesagt",
	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "aikoyori" },
	cost = 10,
	rarity = 3,
	blueprint_compat = false,
	config = {},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_jtem2_strange_card
		info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_jtem2_gravacard
		info_queue[#info_queue + 1] = G.P_CENTERS.m_worm_jtem2_neutron_card
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			for _, scored_card in ipairs(context.scoring_hand) do
				if
					next(SMODS.get_enhancements(scored_card))
					and not scored_card.debuff
					and not scored_card.vampired
				then
					local ench = SMODS.get_enhancements(scored_card)
					if ench["m_steel"] then
						scored_card:set_ability("m_worm_jtem2_strange_card", nil, true)
					elseif ench["m_gold"] then
						scored_card:set_ability("m_worm_jtem2_gravacard", nil, true)
					elseif ench["m_stone"] then
						scored_card:set_ability("m_worm_jtem2_neutron_card", nil, true)
					end
					G.E_MANAGER:add_event(Event({
						func = function()
							scored_card:juice_up()
							return true
						end,
					}))
				end
			end
		end
	end,
})
