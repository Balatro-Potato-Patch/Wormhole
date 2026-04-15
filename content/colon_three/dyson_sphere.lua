if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "ct_dyson_sphere",
    atlas = "ct_jokers",
    pos = { x = 1, y = 0 },
    config = { extra = { mult = 0, mult_per = 1 } },
    cost = 8,
    rarity = 2,
    attributes = { "space", "mult", "scaling", },
    ppu_artist = { "notmario" },
    ppu_coder = { "notmario" },
    ppu_team = { ":3" },

    perishable_compat = false,

    loc_vars = function(self, q, card)
        q[#q+1] = { key = "worm_clean_up_reminder", set="Other", specific_vars = { } }
        q[#q+1] = G.P_CENTERS.m_worm_ct_junk_card
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_per } }
    end,
    calculate = function(self, card, context)
        if context.worm_c3_cleanup then
			card.ability.extra.scale_by = card.ability.extra.mult_per * #context.cards
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "mult",
				scalar_value = "scale_by",
				message_key = "a_mult",
                message_colour = G.C.MULT,
			})
        end
        if context.joker_main and card.ability.extra.mult ~= 0 then
            return { mult = card.ability.extra.mult }
        end
    end
}
