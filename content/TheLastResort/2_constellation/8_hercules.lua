SMODS.Consumable{
	set = "worm_tlr_constellation",
	atlas = "tlr_const",
	pos = {x = 0, y = 6},
	config = {
		blind = nil
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.blind}}
	end,
	reset_blind = function(self, card)
		local blind = "bl_final_heart"
		card.ability.blind = blind -- i forgot how to get blinds
		card:juice_up()
	end,
	set_ability = function (self, card, initial, delay_sprites)
		if card.ability.tier == 4 then
			self:reset_blind(card)
		end
	end,
	calculate = function (self, card, context)
		if context.end_of_round and context.main_eval then
			if card.ability.tier == 4 then
				self:reset_blind(card)
				return {
					message = localize("k_reset")
				}
			end
		end
	end,
	can_use = function (self, card)
		return G.STATE == G.STATES.SHOP
	end,
	use = function (self, card, area, copier)
		
	end
}