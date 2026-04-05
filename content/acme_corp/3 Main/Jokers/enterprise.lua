SMODS.Joker{
	key = 'ACME_enterprise',
	loc_txt = {
		name = "Enterprise Joker",
		text = {
			'Gain {C:chips}+#1# chips{} for',
			'{C:attention}unique{} {C:planet}planet{} card',
			'used',
			'{C:inactive}(Currently {C:chips}+#2#{}){}'
		},	
	},
	atlas = 'ACME_jokers',
	rarity = 1,
	cost = 4,
	in_pool = function(self,wawa,wawa2)
		allow_duplicates = false
		return true
    end,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	pos = {x = 3, y = 0},
	config = { 
		extra = {
			chip_gain = 20}
		},
	loc_vars = function(self,info_queue,center)
		local planets_used = 0
		for k, v in pairs(G.GAME.consumeable_usage) do if v.set == "Planet" then planets_used = planets_used + 1 end end
		return{vars = {center.ability.extra.chip_gain,center.ability.extra.chip_gain * planets_used}}
	end,
	calculate = function(self,card,context)
		local planets_used = 0
		for k, v in pairs(G.GAME.consumeable_usage) do if v.set == "Planet" then planets_used = planets_used + 1 end end
		
		if context.joker_main then
			return {chips = card.ability.extra.chip_gain * planets_used}
		end
	end,
}
