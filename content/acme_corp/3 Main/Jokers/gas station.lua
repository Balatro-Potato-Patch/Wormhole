SMODS.Joker{
	key = 'acme_gas_station',
	atlas = 'ACME_jokers',
	rarity = 3,
	cost = 6,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	pos = {x = 1, y = 1},
	ppu_coder = {'Youh'},
	ppu_artist = {'FlameThrowerFIM'},
	config = {
		extra = {
			lose_level = 1,
			xmult_scale = 0.2,
			xmult = 1
		},
	},
	loc_vars = function(self,info_queue,center)
		return{vars = {center.ability.extra.xmult_scale,
		center.ability.extra.xmult}}
	end,
	calculate = function(self,card,context)
		if context.before then
			if not context.blueprint and 
				G.GAME.hands[context.scoring_name].level > 1 then
					unlockedHands = G.GAME.hands
					local names = {}
					for k, v in ipairs(G.handlist) do
						if G.GAME.hands[v] and G.GAME.hands[v].visible then names[#names+1] = v end
					end
					local rand = pseudorandom_element(names,'acme_gas_station')
					SMODS.upgrade_poker_hands{
						hands = {context.scoring_name},
						level_up = -1,
						from = card,
						instant = true
					}
					SMODS.scale_card(card,{
						ref_table = card.ability.extra,
						ref_value = "xmult",
						scalar_value = "xmult_scale",
					})
					SMODS.upgrade_poker_hands{
						hands = {rand},
						level_up = 1,
						from = card,
					}
			end
		end
		if context.joker_main then
			return {xmult = card.ability.extra.xmult}
		end
	end
}
