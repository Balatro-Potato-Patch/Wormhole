SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty" },
    ppu_coder = { "PLagger" },

    key = 'stew_stardust',
    config = {extra = {price = 5, diamonds_required = 5, diamonds_remaining = 5}},
    rarity = 1,
    cost = 5,
    atlas = 'stewjokers',
    pos = {x=4, y=1},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        return{
            vars = {card.ability.extra.price, card.ability.extra.diamonds_required, card.ability.extra.diamonds_remaining}
        }
    end,

    calculate = function (self, card, context)

        if context.before and not context.blueprint then
            local diamond_cards = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                   if scored_card:is_suit('Diamonds') then
                    diamond_cards = diamond_cards + 1
                end   
            end
            card.ability.extra.diamonds_remaining = card.ability.extra.diamonds_remaining - diamond_cards
            if card.ability.extra.diamonds_remaining <= 0 then
                card.ability.extra.diamonds_remaining = card.ability.extra.diamonds_required + card.ability.extra.diamonds_remaining
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
                card:set_cost()
                return{
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            end
        end
    end
}