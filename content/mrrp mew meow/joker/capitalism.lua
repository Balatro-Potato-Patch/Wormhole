SMODS.Joker {
	key = 'capitalism',
	atlas = "mrrp",
    pos = {
        x=4,
        y=5
    },
	rarity = 2,
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,

	config = {
        extra = {
            mult = 0,
            mult_mod = 14
        }
    },
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				(card.ability.extra.mult_mod < 0 and "-" or "+") .. card.ability.extra.mult_mod,
				(card.ability.extra.mult < 0 and "-" or "+") .. card.ability.extra.mult
			}
		}
	end,

	calculate = function(self, card, context)
		
	end
}