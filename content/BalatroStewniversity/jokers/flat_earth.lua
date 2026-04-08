SMODS.Joker{ --Flat Earth
    key = 'flat_earth',
    config = {extra = {chips = 0, chips_mod = 30,}},
    rarity = 1,
    cost = 4,
    atlas = 'stewjokers',
    pos = {x=1, y=1},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function (self, info_queue, card)
        return{
            vars = {card.ability.extra.chips, card.ability.extra.chips_mod}
        }
    end,

    calculate = function (self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local spade_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_suit('Spades') then spade_cards = spade_cards + 1
                end
            end
            if spade_cards > 0 then
                card.ability.extra.chips = card.ability.extra.chips + spade_cards * card.ability.extra.chips_mod
                return{
                    message = localize {type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}
                }
            end
        end
        --TO DO: make it so it updates when spades are suit changed out of
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}