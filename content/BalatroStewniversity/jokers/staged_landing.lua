
SMODS.Joker{ --Staged Landing
    key = 'staged_landing',
    loc_txt = {
    name = 'Staged Landing',
    text = {
        'Earn {C:money}$#1#{} every',
        '{C:attention}#2#{} {C:inactive}[#3#]{} {C:clubs}Clubs{} cards',
        'discarded'
        }
    },

    config = {extra = {dollars = 5, discards = 3, discards_remaining = 3}},
    rarity = 1,
    cost = 4,
    atlas = 'stewjokers',
    pos = {x=0, y=0},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        return {
            vars = {card.ability.extra.dollars, card.ability.extra.discards, card.ability.extra.discards_remaining}
            }
        end,
        calculate = function (self, card, context)
         if context.discard and context.other_card:is_suit('Clubs')
            and not context.other_card.debuff then
            if card.ability.extra.discards_remaining <= 1 then
                if not context.blueprint then
                card.ability.extra.discards_remaining = card.ability.extra.discards
                end
                return{
                    dollars = card.ability.extra.dollars
                }
                else if not context.blueprint then
                card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
                end
            end
        end
    end
}
