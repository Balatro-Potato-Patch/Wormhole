SMODS.Enhancement {
    key = 'shrug_nebulous',
    pos = {x = 3, y = 0}, -- this is placeholder sprite
    discovered = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play then
            if context.before then
                return {level_up = 1}
            end
            if context.after then
                return {level_up = -1}
            end
        end
    end
}
