SMODS.Consumable{
	key = "tlr_const_perseus",
	set = 'worm_tlr_constellation',
	atlas = "tlr_const",
	pos = {x=0, y=1},
	config = {
		disable = {1, 2, 1, 2}
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.disable[card.ability.tier]}}
	end,
	can_use = function (self, card) return true end,
	use = function (self, card, area, copier)
		if card.ability.tier < 3 then
			G.GAME.worm_tlr_const_disable_hands = card.ability.disable[card.ability.tier]
		else
			G.GAME.worm_tlr_const_disable_blinds = card.ability.disable[card.ability.tier]
		end
		SMODS.calculate_effect({message = "Applied!"}, card)
	end
}