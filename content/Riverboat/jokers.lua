-- The Past
SMODS.Joker({
    key = 'the_past',
    atlas = 'worm_jokers',
    pos = { x = 0, y = 0 },
    rarity = 'worm_cosmic',
    cost = 20,
    blueprint_compat = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local hands = G.GAME and G.GAME.hands_played or 0
        local bought = G.GAME and G.GAME.worm_jokers_bought or 0
        local paired = get_pair_status()

        if paired then
            return { key = self.key .. '_paired', vars = { hands, bought } }
        end
        return { vars = { hands } }
    end,
    calculate = function(self, card, context)
        -- Logic is handled via loc_vars and the Future's calculation
    end
})

-- The Future
SMODS.Joker({
    key = 'the_future',
    atlas = 'worm_jokers',
    pos = { x = 1, y = 0 },
    rarity = 'worm_cosmic',
    cost = 20,
    blueprint_compat = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local hands = G.GAME and G.GAME.hands_played or 0
        local bought = G.GAME and G.GAME.worm_jokers_bought or 0
        local paired = get_pair_status()
        
        if paired then
            return { 
                key = self.key .. '_paired', 
                vars = { math.max(1, hands * bought), hands, bought } 
            }
        end
        return { vars = { math.max(1, bought) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local hands = G.GAME and G.GAME.hands_played or 0
            local bought = G.GAME and G.GAME.worm_jokers_bought or 0
            local paired = get_pair_status()
            
            local x_mult = paired and (hands * bought) or bought

            if x_mult > 1 then
                return {
                    message = localize({type='variable', key='a_xmult', vars={x_mult}}),
                    Xmult_mod = x_mult
                }
            end
        end
    end
})

-- Ulala
SMODS.Joker({
    key = 'ulala',
    atlas = 'worm_jokers',
    pos = { x = 2, y = 0 },
    rarity = 2, -- Uncommon
    cost = 6,
    blueprint_compat = true,
    discovered = true,
    config = { extra = { mult = 0, gain = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local has_five = false
            if context.scoring_hand then
                for _, scoring_card in ipairs(context.scoring_hand) do
                    if scoring_card:get_id() == 5 then
                        has_five = true
                        break
                    end
                end
            end

            if has_five then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                return {
                    message = 'Upgrade!',
                    colour = G.C.MULT,
                    card = card
                }
            else
                if card.ability.extra.mult > 0 then
                    card.ability.extra.mult = 0
                    return {
                        message = 'Reset',
                        colour = G.C.MULT,
                        card = card
                    }
                end
            end
        end

        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize({type='variable', key='a_mult', vars={card.ability.extra.mult}})
            }
        end
    end
})

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