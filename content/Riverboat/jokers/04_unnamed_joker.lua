SMODS.Joker {
    key = "riverboat_test",
    config = {
        extra = {
            score_mult = 10
        }
    },
    rarity = 1,
    cost = 5,
    atlas = "jokers",
    pos = { x = 2, y = 0 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_coder = {"blamperer"},
    ppu_team = {"riverboat"},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.score_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            local hand_for_planet = context.consumeable.ability.hand_type
            local hand_info = G.GAME.hands[hand_for_planet]
            local hand_chips = hand_info.l_chips
            local hand_mult = hand_info.l_mult

            SMODS.calculate_effect({ score = card.ability.extra.score_mult * hand_chips * hand_mult }, card)

            if G.GAME.chips >= G.GAME.blind.chips then
                if G.GAME.current_round.hands_played <= 0 then
                    check_for_unlock { type = "riverboat_instaplanet" }
                end
                -- G.E_MANAGER:add_event(Event({
                --     func = function()
                --         G.STATE = G.STATES.NEW_ROUND
                --         G.STATE_COMPLETE = false
                --         G:update_new_round(0)
                --         -- end_round()
                --         return true
                --     end
                -- }))
                G.STATE = G.STATES.HAND_PLAYED
                G.STATE_COMPLETE = true
                end_round()
            end
        end
    end
}
