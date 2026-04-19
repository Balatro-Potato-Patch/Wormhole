SMODS.Joker {
    key = "spacecadet",
    rarity = 3,
    cost = 10,
    config = {
        extra = {
            x_mult = 2.25
        }
    },
    ppu_team = { "Violent Violets" },
    ppu_coder = { "Iso", "FireIce" },
    atlas = 'VVjokers',
    pos = {x = 0, y = 2},
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "c", 1, 3) then
                return {
                    xmult = card.ability.extra.x_mult,
                },
                play_sound('worm_hyperspace', 1, 1)
            end
        end
    end
}
