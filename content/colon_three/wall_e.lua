if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "wall_e",
    --atlas = "ct_jokers",
    --pos = { x = 0, y = 0 },
    config = { extra = { } },
    rarity = 2,
    attributes = { "space", "passive", },
    --ppu_artist = {},
    ppu_coder = { "notmario" },
    ppu_team = { ":3" },

    loc_vars = function(self, q, card)
        q[#q+1] = { key = "worm_clean_up_reminder", set="Other", specific_vars = { } }
        q[#q+1] = G.P_CENTERS.m_worm_junk_card
        return { vars = { } }
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
    end
}
