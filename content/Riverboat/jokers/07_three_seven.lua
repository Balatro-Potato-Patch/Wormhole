SMODS.Joker {
    key = "riverboat_threeseven",
    config = {
        extra = {
            mult = 3,
            chips = 7
        }
    },
    rarity = 1,
    cost = 3,
    atlas = "worm_jokers",
    pos = { x = 6, y = 0 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_artist = { "blamperer" },
    ppu_coder = { "blamperer" },
    ppu_team = { "riverboat" },
    attributes = { "chips", "mult", "rank", "three", "seven", "space" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 3 or context.other_card:get_id() == 7 then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                }
            end
        end
    end
}
