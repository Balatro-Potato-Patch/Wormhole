SMODS.Joker{
    key = 'cheese_moon',
    config = {extra = {hands_left = 8, odds = 2}},
    rarity = 2,
    cost = 6,
    atlas = 'stewjokers',
    pos = {x=0, y=1},
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,

    loc_vars = function (self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_cheese_moon')
        return{
            vars = {card.ability.extra.hands_left, numerator, denominator}
        }      
    end,

    calculate = function (self, card, context)

        if context.destroy_card then 
            if context.cardarea == G.play and context.destroy_card == context.scoring_hand[#context.scoring_hand] and
            SMODS.pseudorandom_probability(card, 'worm_cheese_moon', 1, card.ability.extra.odds) then
                return{
                    remove = true,
                    delay = 0.4
                }
            end
        end

        if context.after and not context.blueprint then
            if card.ability.extra.hands_left - 1 <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                    return{
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                else
                    card.ability.extra.hands_left = card.ability.extra.hands_left - 1
                        return{
                            message = card.ability.extra.hands_left .. '',
                            colour = G.C.FILTER
                        }
                end
        end

    end
}