SMODS.Atlas {
    key = 'wowsignalatlas',
    px = 71,
    py = 95,
    path = 'team-eudaimonia/wowsignal.png',
}

SMODS.Joker {
    key = "wowsignal",
    atlas = 'wowsignalatlas',
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    discovered = true,
    config = {extra = {numerator = 1, denominator = 4, chipsmin = 20, chipsmax = 50, wowmin = 2, wowmax = 5}},
    ppu_coder = {'Typ0'},
    ppu_artist = {'LasagnaFelidae'},
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator)
    end,
    calculate = function(self, card, context)
        if context.joker_main  
            if SMODS.pseudorandom_probability(card, 'wowsignalprob', card.ability.extra.numerator, card.ability.extra.denominator) then
                return {
                    message = 'Wow!',
                    xchips = SMODS.pseudorandom_probability(card, 'wowsignalwow', card.ability.extra.wowmin, card.ability.extra.wowmax)
                }
            else
                return {
                    chips = SMODS.pseudorandom_probability(card, 'wowsignalchips', card.ability.extra.chipsmin, card.ability.extra.chipsmax)
                }
            end
        end
    end
}