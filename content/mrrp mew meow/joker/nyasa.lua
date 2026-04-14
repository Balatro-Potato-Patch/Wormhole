SMODS.Joker {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'SarcPot'},
    ppu_coder = {'Minty'},
	key = 'mrrp_nyasa',
	atlas = "mrrp", pos = {x=0, y=3},
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

	config = {
        extra = {
            edition="e_negative",
            odds = 20
        }
    },
	loc_vars = function (self, info_queue, card)
        local luck, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "worm_mrrp_nasa", false)
        if not (card.edition and card.edition.negative) then
            info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        end
		return {
			vars = {
				localize({type='name_text', set="Edition", key=card.ability.extra.edition}),
                luck, odds
			}
		}
	end,

	calculate = function(self, card, context)
		if context.setting_blind then
            local negative = SMODS.pseudorandom_probability(card, "worm_mrrp_nasa", 1, card.ability.extra.odds)
            if negative or #G.jokers.cards + (G.GAME.joker_buffer or 0) < G.jokers.config.card_limit then
                SMODS.add_card{
                    attributes = {"space"},
                    edition = card.ability.extra.edition,
                    stickers = {
                        card.ability.extra.sticker
                    },
                    force_stickers = true
                }
                return nil, true
            end
        end
	end
}