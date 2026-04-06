if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "quantum_tunneling",
    --atlas = "ct_jokers",
    --pos = { x = 0, y = 0 },
    rarity = 2,
    attributes = { "mod_chance", "scaling", },
    --ppu_artist = {},
    ppu_coder = { "nxkoo" },
    ppu_team = { ":3" },

    perishable_compat = true,
    blueprint_compat = false,
    eternal_compat = true,

    config = {
        extra = {
            denom_mod = 1,
            denom_mod_mod = 0.1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                SMODS.signed(-card.ability.extra.denom_mod), card.ability.extra.denom_mod_mod
            }
        }
    end,

    calculate = function(self, card, context)

        if context.worm_c3_cleanup then
			card.ability.extra.scale_by = card.ability.extra.denom_mod_mod * #context.cards
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "denom_mod",
                scalar_value = "scale_by",
                message_colour = G.C.GREEN,
            })
        end

        if context.mod_probability and not context.blueprint then
			local new_denominator = context.denominator
			if context.denominator >= 1 then
				new_denominator = math.max(1,
                    context.denominator - card.ability.extra.denom_mod
                )
			end
			return {
				denominator = new_denominator,
			}
        end

    end
}