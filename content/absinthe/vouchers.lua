SMODS.Voucher {
    key = 'abs_star_tap',
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    redeem = function(self, card)
        G.GAME.abs_drinks_rate = 2
    end
}

SMODS.Voucher {
    key = 'abs_on_the_house',
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    config = {
        extra = {
            chance = 1,
            odds = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.odds)
        return { vars = { num, denom } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            for k, v in pairs(G.consumeables.cards) do
                if v.ability.set == 'abs_drinks' and not v.ability.drink_values.filled and SMODS.pseudorandom_probability(card, 'abs_oth', card.ability.extra.chance, card.ability.extra.odds) then
                    v:abs_refill_drink()
                end
            end
        end
    end
}
