SMODS.Joker{ --Flat Earth
    key = 'flat_earth',
    config = {extra = {chips = 0, chips_mod = 2,}},
    rarity = 1,
    cost = 5,
    atlas = 'stewjokers',
    pos = {x=1, y=1},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    update_chips = function (self, card)
        local non_spades = 0
        for _, card in pairs(G.playing_cards) do
            if not card:is_suit("Spades") then
                non_spades = non_spades + 1
            end
        end
        card.ability.extra.chips = non_spades * card.ability.extra.chips_mod

    end,

    loc_vars = function (self, info_queue, card)
        self:update_chips(card)

        return {
            vars = {card.ability.extra.chips, card.ability.extra.chips_mod}
        }
    end,

    calculate = function (self, card, context)
        if context.joker_main then
            self:update_chips(card)
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}