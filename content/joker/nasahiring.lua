SMODS.Joker {
	key = 'nasahiring',
	atlas = "mrrp_j", pos = {x=3, y=0},
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

    attributes = {
        "space",
        "generation",
        "joker"
    },

	config = {extra = {edition="e_negative", sticker="rental"}},
	loc_vars = function (self, info_queue, card)
        if not (card.edition and card.edition.negative) then
            info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        end
        if not (card.ability and card.ability.rental) then
            info_queue[#info_queue+1] = { set = "Other", key = "rental", specific_vars = { G.GAME.rental_rate or 3 } }
        end
		return {
			vars = {
				localize({type='name_text', set="Edition", key=card.ability.extra.edition}),
				localize({type='name_text', set="Other", key=card.ability.extra.sticker}),
			}
		}
	end,

	calculate = function(self, card, context)
		if context.setting_blind then
            SMODS.add_card{
                attributes = {"space"},
                edition = card.ability.extra.edition,
                stickers = {
                    card.ability.extra.sticker
                },
                force_stickers = true
            }
        end
	end
}