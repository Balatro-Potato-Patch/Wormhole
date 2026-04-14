SMODS.Joker {
	ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'SarcPot'},
    ppu_coder = {'Minty'},
	key = 'mrrp_staging',
	atlas = "mrrp", pos = {x=3, y=2},
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = {'space'},

	config = {
        extra = {
            xmult = 1,
            xmult_gain = 0.1,
            xmult_base = 1
        }
    },
	loc_vars = function (self, info_queue, card)
		return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.xmult
            }
        }
	end,

	calculate = function(self, card, context)
		if context.discard then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_gain",
                message_key = "a_xmult",
                message_colour = G.C.RED,
                message_delay = 0.2,
            })
            return nil, true
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.xmult = card.ability.extra.xmult_base
            return {
                message = localize("k_reset")
            }
        end
	end
}