local function levels_over_one(not_including)
    local sum = 0
    for k, v in pairs(G.GAME.hands) do
        if k ~= not_including then
            if v.visible then
                sum = sum + (v.level - 1)
            end
        end
    end
    return sum
end

SMODS.Joker {
    key = "riverboat_calignment",
    config = {
        extra = {
            level_mult = 0.1
        }
    },
    rarity = 3,
    cost = 8,
    atlas = "worm_jokers",
    pos = { x = 4, y = 0 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_coder = { "blamperer" },
    ppu_artist = { "camo" },
    ppu_team = { "riverboat" },
    attributes = { "xmult", "planet", "space" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.level_mult,
                1 + (levels_over_one(SMODS.last_hand and SMODS.last_hand.scoring_name or "") * card.ability.extra.level_mult)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local levels = levels_over_one(context.scoring_name)
            if levels > 0 then
                return {
                    xmult = 1 + (levels * card.ability.extra.level_mult)
                }
            end
        end
    end
}
