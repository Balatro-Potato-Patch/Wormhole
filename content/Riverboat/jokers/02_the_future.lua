-- The Future
SMODS.Joker({
    key = 'riverboat_the_future',
    atlas = 'worm_jokers',
    pos = { x = 1, y = 0 },
    rarity = 'worm_cosmic',
    cost = 20,
    blueprint_compat = true,
    discovered = true,
    ppu_artist = { "fooping" },
    ppu_coder = { "fooping" },
    ppu_team = { "riverboat" },
    attributes = { "xmult" },
    loc_vars = function(self, info_queue, card)
        local hands = G.GAME and G.GAME.hands_played or 0
        local bought = G.GAME and G.GAME.worm_jokers_bought or 0
        local paired = get_pair_status()

        if paired then
            local exponent = 1 + (bought * 0.1)
            return {
                key = self.key .. '_paired',
                vars = { hands, bought, exponent }
            }
        end
        return { vars = { number_format(math.max(1, bought)) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local hands = G.GAME and G.GAME.hands_played or 0
            local bought = G.GAME and G.GAME.worm_jokers_bought or 0
            local paired = get_pair_status()

            local x_mult = bought
            if paired then
                local exponent = 1 + (bought * 0.1)
                x_mult = to_big(math.max(1, hands)) ^ exponent
            end

            if to_big(x_mult) > to_big(1) then
                return {
                    message = localize({ type = 'variable', key = 'a_xmult', vars = { number_format(x_mult) } }),
                    Xmult_mod = x_mult
                }
            end
        end
    end
})
