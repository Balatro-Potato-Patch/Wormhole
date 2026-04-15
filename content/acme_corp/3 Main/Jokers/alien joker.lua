SMODS.Joker {
	key = 'acme_alien_joker',

	atlas = 'ACME_jokers',
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	pos = { x = 0, y = 0 },
	ppu_coder = { 'RadiationV2' },
	ppu_artist = { 'FlameThrowerFIM' },
	config = {
		extra = {
			level = 2,
			mult = 2
		},
	},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.level, center.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and
			G.GAME.hands[context.scoring_name].level > card.ability.extra.level then
			return {
				x_mult = card.ability.extra.level
			}
		end
	end
}
