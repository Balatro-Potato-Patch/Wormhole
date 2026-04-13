SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
    --ppu_artist = {'SarcPot'},
    ppu_coder = {'Aure'},
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
	attributes = {'space','mult','scaling'},
	config = {
        extra = {
            mult = 0,
            mult_mod = 14,
        }
    },
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				(card.ability.extra.mult_mod < 0 and "" or "+") .. card.ability.extra.mult_mod,
				(card.ability.extra.mult < 0 and "" or "+") .. card.ability.extra.mult
			}
		}
	end,

	calculate = function(self, card, context)
		if context.ending_shop and G.GAME.mrrp_capitalism_active and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_table = card.ability.extra,
				scalar_value = "mult_mod"
			})
			return nil, true
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end
}