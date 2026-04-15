SMODS.Atlas {
    key = "shrug_enhancements",
    path = "TeamShrug/enhancements.png",
    px = 71,
    py = 95,
}

SMODS.Enhancement {
    key = 'shrug_nebulous',
    atlas = "shrug_enhancements",
    pos = { x = 0, y = 0 },
    config = { extra = { levels = 1 } },

    -- Return localization
    loc_vars = function (self, info_queue, card)
        local levels = card.ability.extra.levels
        local present = ""
        if math.abs(levels) ~= 1 then
            present = "s"
        end
        return { vars = { levels, present } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        if context.cardarea == G.play then
            if context.before then
                return { level_up = card.ability.extra.levels }
            end
            if context.after then
                return { level_up = -(card.ability.extra.levels) }
            end
        end
    end,

    -- Credits
    ppu_artist = {
        "waffle"
    },
    ppu_coder = {
        "randomsongv2"
    },
    ppu_team = { "shrug" }
}
