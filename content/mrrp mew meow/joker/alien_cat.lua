SMODS.Joker {
    key = 'alien_cat',
    atlas = "mrrp",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = {'cat', 'space'},
    config = {
        extra = {
            odds = 3,
            rank = "3"
        }
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_aliencat')
        return {
            vars = {numerator, denominator, localize(card.ability.extra.rank, "ranks"), localize("planet", "labels")}
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card:is_3() then
            for i = 1, context.other_card:is_3() do
                if SMODS.pseudorandom_probability(card, 'worm_aliencat_' .. i, 1, card.ability.extra.odds) and
                    #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({
                                set = "Planet"
                            })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({
                        message = localize('k_plus_planet'),
                        colour = G.C.SECONDARY_SET.Planet,
                        effect = true
                    }, card)
                end
            end
        end
    end
}
