SMODS.Joker {
	key = 'nasahiring',
	atlas = "mrrp_j", pos = {x=3, y=0},
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	config = {extra = {edition="e_negative", sticker="rental", joker="j_space"}},
	loc_vars = function (self, info_queue, card)
		return {
			vars = {
				localize({type='name_text', set="Edition", key=card.ability.extra.edition}),
				localize({type='name_text', set="Other", key=card.ability.extra.sticker}),
				localize({type='name_text', set="Joker", key=card.ability.extra.joker})
			}
		}
	end,

	calculate = function(self, card, context)
		if context.setting_blind then
            SMODS.add_card{
                key = card.ability.extra.joker,
                edition = card.ability.extra.edition,
                stickers = {
                    card.ability.extra.sticker
                },
                force_stickers = true
            }
        end
	end
}