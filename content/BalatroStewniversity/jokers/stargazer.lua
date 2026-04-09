SMODS.Joker{
    key = 'stargazer',
    config = {extra = {price = 5, scored = 5, scored_remaining = 5}},
    rarity = 1,
    cost = 5,
    atlas = 'stewjokers',
    pos = {x=2, y=1},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        return{
            vars = {card.ability.extra.price, card.ability.extra.scored, card.ability.extra.scored_remaining}
        }
    end,

    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit('Diamonds')
            and not context.blueprint then
            if card.ability.extra.scored_remaining <= 1 then
                card.ability.extra.scored_remaining = card.ability.extra.scored
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
                card:set_cost()
                return{ --i tried finding a neat way to have the text pop up on the joker and not the card but im out of ideas
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            else
                card.ability.extra.scored_remaining = card.ability.extra.scored_remaining - 1
                return nil, true
            end
        end
    end
}