-- SMODS.Atlas {
--     key = "util_extras",
--     path = "util-modders/extra.png",
--     px = 71,
--     py = 95
-- }

SMODS.Joker {
    key = "util_cargo_space",
    -- atlas = "util_extras",
    pos = { x = 0, y = 0 },
    add_to_deck = function(self, card, from_debuff)
        for i,v in ipairs(SMODS.find_card("j_worm_util_cargo_space")) do
            if v ~= card then return end
        end
        for k,v in ipairs(G.I.CARD) do
            if (v.ability and v.ability.set) == "util_Spaces" then
                if not v.ability.util_cargo_spaced then
                    v.ability.util_cargo_spaced = true
                    v.ability.extra_slots_used = v.ability.extra_slots_used - 1
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for i,v in ipairs(SMODS.find_card("j_worm_util_cargo_space")) do
            if v ~= card then return end
        end
        for k,v in ipairs(G.I.CARD) do
            if (v.ability and v.ability.set) == "util_Spaces" then
                if v.ability.util_cargo_spaced then
                    v.ability.util_cargo_spaced = false
                    v.ability.extra_slots_used = v.ability.extra_slots_used + 1
                end
            end
        end
    end,
}

SMODS.Voucher {
    key = "util_better_craftmanship",
    -- atlas = "util_extras",
    pos = { x = 1, y = 0 },
}

SMODS.Voucher {
    key = "util_dealer_contact",
    -- atlas = "util_extras",
    pos = { x = 2, y = 0 },
    requires = { 'v_worm_util_better_craftmanship' },
}
