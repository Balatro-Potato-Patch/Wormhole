


-- The Pull
SMODS.Blind {
    key = "pull",
    dollars = 5,
    mult = 2,
    atlas = "stewblinds",
    pos = { x = 0, y = 0 },
    boss = { min = 3 },
    boss_colour = HEX("575757"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            -- TODO : implement
            if context.setting_blind then
                G.hand:change_size(-1)
            end
        end
    end,
    disable = function(self)
        G.hand:change_size(1)
    end,
    defeat = function(self)
        if not G.GAME.blind.disabled then
            G.hand:change_size(1)
        end
    end
}

