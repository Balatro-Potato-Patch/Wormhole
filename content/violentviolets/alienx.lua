SMODS.Joker {
    key = "alienx",
    cost = 20,
    rarity = 4,
    atlas = 'VVjokers',
    pos = {x = 1, y = 0},
    soul_pos = {x = 2, y = 0},
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" and not context.blueprint then
        end
end
}