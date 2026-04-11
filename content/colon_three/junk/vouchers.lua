if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

-- CUT CONTENT But im leaving it in the code

SMODS.Atlas {
    path = "colon_three/vouchers.png",
    key = "ct_vouchers",
    px = 71, py = 95
}

SMODS.Voucher {
    key = "fuel_efficiency",
    atlas = "ct_vouchers",
    pos = { x = 0, y = 0, },

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
    end,
}

SMODS.Voucher {
    key = "the_final_frontier",
    atlas = "ct_vouchers",
    pos = { x = 1, y = 0, },
    requires = { "v_worm_fuel_efficiency" },
    config = { extra = { total_cards = 10, current_cards = 0, } },
    
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_worm_junk_card
        return { vars = { card.ability.extra.total_cards, card.ability.extra.current_cards, } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_worm_junk_card") then
            card.ability.extra.current_cards = card.ability.extra.current_cards + 1
            if card.ability.extra.current_cards >= card.ability.extra.total_cards then
                card.ability.extra.current_cards = card.ability.extra.current_cards - card.ability.extra.total_cards
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    return {
                        message = localize('k_plus_planet'),
                        colour = G.C.SECONDARY_SET.Planet,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        set = 'Planet',
                                        key_append = 'final_frontier'
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                            return true
                        end
                    }
                end
            else
                return {
                    message = card.ability.extra.current_cards.."/"..card.ability.extra.total_cards,
                    colour = Wormhole.COLON_THREE.C.JunkSet
                }
            end
        end
    end,
}