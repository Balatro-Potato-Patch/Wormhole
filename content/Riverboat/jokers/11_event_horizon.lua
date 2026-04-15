SMODS.Joker({
    key = 'riverboat_event_horizon',
    atlas = 'worm_jokers',
    pos = { x = 2, y = 1 },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    discovered = true,
    config = { extra = { x_mult = 1, gain = 0.2 } },
    ppu_coder = { "fooping" },
    ppu_artist = { "fooping" },
    ppu_team = { "riverboat" },
    attributes = { "xmult", "scaling", "reset", "space" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.x_mult > 1 then
            return {
                message = localize({ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }),
                Xmult_mod = card.ability.extra.x_mult
            }
        end

        if context.end_of_round and context.main_eval and not context.blueprint then
            if G.GAME.current_round.hands_played == 1 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.gain
                return {
                    message = 'Upgrade!',
                    colour = G.C.RED,
                    card = card
                }
            end
        end

        if context.after and not context.blueprint then
            if G.GAME.current_round.hands_played == 1 and not G.GAME.blind.main_eval then
                if card.ability.extra.x_mult > 1 then
                    card.ability.extra.x_mult = 1
                    return {
                        message = 'Reset',
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
    end
})
