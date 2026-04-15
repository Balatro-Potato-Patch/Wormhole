SMODS.Joker {
    key = "fraudthird",
    loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult } }
    end,
    config = { extra = { x_mult = 8 } },
    rarity = 3,
    cost = 8,
    atlas = 'VVjokers',
    pos = {x = 0, y = 0},
    ppu_team = { "Violent Violets" },
    ppu_artist = { "Gud" },
    ppu_coder = { "FireIce" },
    calculate = function(self, card, context)
        if context.cardarea == G.play then
            if context.other_card:get_id() == 3 then
                return {
                x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
}