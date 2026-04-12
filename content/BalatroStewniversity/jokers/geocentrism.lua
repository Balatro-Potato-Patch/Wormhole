
SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "Wingcap" },
    ppu_coder = { "stupxd" },

    key = 'stew_geocentrism',
    config = {extra = {Xmult = 1.25}},
    rarity = "Common",
    cost = 5,
    atlas = 'stewjokers',
    pos = {x=3, y=1},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        return {
            vars = { card.ability.extra.Xmult }
        }
    end,
    
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end
}
