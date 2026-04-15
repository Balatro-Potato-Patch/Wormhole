SMODS.Joker {
    key = "riverboat_abandoned",
    config = {
        extra = {
            odds = 4
        }
    },
    rarity = 2,
    cost = 5,
    atlas = "worm_jokers",
    pos = { x = 7, y = 1 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_coder = { "blamperer" },
    ppu_artist = { "camo" },
    ppu_team = { "riverboat" },
    attributes = { "hand_type", "chance", "space", "modify_card", "enhancements" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["m_worm_riverboat_stardust"]
        return {
            vars = {
                SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "worm_riverboat_abandoned")
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            if SMODS.pseudorandom_probability(card, "worm_riverboat_abandoned", 1, card.ability.extra.odds, "worm_riverboat_abandoned") then
                local any_non_stardust = false
                for _, v in pairs(context.scoring_hand) do
                    if v.config.center_key ~= "m_worm_riverboat_stardust" then
                        any_non_stardust = true
                        break
                    end
                end
                if any_non_stardust and G.GAME.hands[context.scoring_name].level > 1 then
                    SMODS.upgrade_poker_hands {
                        hands = { context.scoring_name },
                        level_up = -1,
                        from = card
                    }
                    for _, v in pairs(context.scoring_hand) do
                        v:set_ability("m_worm_riverboat_stardust", nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}
