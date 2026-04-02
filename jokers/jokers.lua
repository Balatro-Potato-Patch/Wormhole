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
