SMODS.Atlas {
    key = "abs_jokers",
    path = 'absinthe/abs_jokers.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'abs_clg',
    rarity = 2,
    cost = 5,
    atlas = 'worm_abs_jokers',
    pos = { x = 0, y = 0 },
    ppu_artist = { 'nixthatoneartist' },
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    attributes = {
        'generation',
        'drinks',
        'space'
    },
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local new_drink = SMODS.add_card({set = 'abs_drinks'})
                    new_drink.ability.drink_values.filled = false
                    new_drink.ability.drink_values.visibly_filled = false
                    G.GAME.consumeable_buffer = 0
                    return true;
                end
            }))
            return {
                message = localize('k_plus_drink'),
                colour = G.C.SECONDARY_SET.abs_drinks,
            }
        end
    end,
}
