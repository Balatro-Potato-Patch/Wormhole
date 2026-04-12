SMODS.Joker {
    key = 'astrologer',
    rarity = "Common",
    cost = 4,
    atlas = 'stewjokers',
    pos = {x=0, y=0},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function (self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Tarot'
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then

            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    SMODS.add_card {
                        set = 'Planet',
                        key_append = 'astrologer'
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            return {
                message = localize('k_plus_planet'),
                colour = G.C.SECONDARY_SET.Planet,
            }
        end
    end
}