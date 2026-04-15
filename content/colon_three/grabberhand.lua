if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "ct_grabberhand",
    atlas = "ct_jokers",
    pos = { x = 4, y = 0 },
    config = { extra = { hands = 0, } },
    rarity = 2,
    cost = 5,
    attributes = { "hands", },
    ppu_artist = { "notmario" },
    ppu_coder = { "notmario" },
    ppu_team = { ":3" },

    loc_vars = function(self, q, card)
        q[#q+1] = { key = "worm_clean_up_reminder", set="Other", specific_vars = { } }
        q[#q+1] = G.P_CENTERS.m_worm_ct_junk_card
        return { vars = { card.ability.extra.hands } }
    end,
    calculate = function(self, card, context)
        if context.worm_c3_cleanup_cost then
            local new_costs = {}
            for cost, v in pairs(context.valid_costs) do
                if v and cost > 1 then new_costs[#new_costs + 1] = cost - 1 end
            end
            for _, cost in ipairs(new_costs) do
                context.valid_costs[cost] = true
            end
        end
        if context.worm_c3_cleanup then
			card.ability.extra.hands = card.ability.extra.hands + 1
        end
        if context.setting_blind and not context.blueprint and card.ability.extra.hands ~= 0 then
			ease_hands_played(card.ability.extra.hands)
            card.ability.extra.hands = 0
        end
    end
}
