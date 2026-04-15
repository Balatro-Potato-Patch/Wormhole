SMODS.Joker {
	key = 'acme_stargazing',

	atlas = 'ACME_jokers',
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	pos = { x = 0, y = 1 },
	ppu_coder = { 'RadiationV2' },
	ppu_artist = { 'FlameThrowerFIM' },
	config = {
		extra = {
			played_hand = "Full House",
			odds = 2
		},
	},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.played_hand, center.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
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
