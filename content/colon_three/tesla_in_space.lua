if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "tesla_in_space",
    --atlas = "ct_jokers",
    --pos = { x = 0, y = 0 },
    config = { extra = { dollars = 2, } },
    rarity = 1,
    cost = 4,
    attributes = { "space", "economy", },
    --ppu_artist = {},
    ppu_coder = { "notmario" },
    ppu_team = { ":3" },

    perishable_compat = false,

    loc_vars = function(self, q, card)
        q[#q+1] = { key = "worm_clean_up_reminder", set="Other", specific_vars = { } }
        q[#q+1] = G.P_CENTERS.m_worm_junk_card
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.worm_c3_cleanup then
            local r = {}
            for _, _ in pairs(context.cards) do
                r[#r + 1] = { dollars = card.ability.extra.dollars }
            end
            return SMODS.merge_effects(r)
        end
    end
}
