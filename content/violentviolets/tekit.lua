SMODS.Joker {
    key = "tekit",
    atlas = 'VVjokers',
    rarity = 'worm_otherworldly',
    cost = 30,
    pos = {x = 0, y = 1},
    soul_pos = {x = 1, y = 1},
    config = {
        extra = {
            chips = 1,
            multiplier = 2,
        },
        immutable = {
        }
    },
    ppu_team = { "Violent Violets" },
    ppu_artist = { "FirstTry" },
    ppu_coder = { "FirstTry" },
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_moon
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.multiplier
                        }
        }
    end,
    calculate = function(self,card,context)
    if context.using_consumeable and context.consumeable.config.center.key == "c_moon" then
    SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "gain",
                    scalar_table = { gain = card.ability.extra.chips * card.ability.extra.multiplier },
                    scaling_message = {
                        message = "X" .. ( card.ability.extra.chips * card.ability.extra.multiplier ) .. " Chips",
                        colour = G.C.CHIPS
                    },
                })
    end
    if context.joker_main then
        return { xchips = card.ability.extra.chips }
    end
end
}