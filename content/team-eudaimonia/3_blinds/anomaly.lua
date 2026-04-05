-- The Anomaly
SMODS.Blind {
    key = "anomaly",
    dollars = 5,
    mult = 1,
    pos = { x = 0, y = 9 },
    boss = { min = 1 },
    boss_colour = HEX("8a59a5"),
    config = {extra={tot_change=1}},
    percent_change = 0.2,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.percent_change*100} }
    end,
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.chips / G.GAME.blind.effect.extra.tot_change
        G.GAME.blind.effect.extra.tot_change = 1
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,
    calculate = function(self, blind, context)
        if  not blind.disabled and context.press_play then
            G.GAME.blind.chips = G.GAME.blind.chips * (1 + self.percent_change)
            G.GAME.blind.effect.extra.tot_change = G.GAME.blind.effect.extra.tot_change * (1 + self.percent_change)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end,
    in_pool = function(self) return false end,
}
