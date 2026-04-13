SMODS.Joker{
	key = 'ACME_stargazing',
	loc_txt = {
		name = "Stargazing",
		text = {
			'If played {C:attention}hand{} is a {C:planet}#1#{},',
			'{C:green}1 in #2#{} chance to level it up'
		},
	},
	atlas = 'ACME_jokers',
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	pos = {x = 0, y = 1},
	ppu_coder = {'RadiationV2'},
	ppu_artist = {'FlameThrowerFIM'},
	config = {
		extra = {
			played_hand = "House",
			odds = 2
		},
	},
	loc_vars = function(self,info_queue,center)
		return{vars = {center.ability.extra.played_hand, center.ability.extra.odds}}
	end,
	calculate = function(self,card,context)
		if context.before and
		string.match(context.scoring_name, card.ability.extra.played_hand) and
		SMODS.pseudorandom_probability(card, 'acme_stargazing', 1, card.ability.extra.odds) then
			return {
				level_up = true,
				message = localize('k_level_up_ex')
			}
		end
	end
}
