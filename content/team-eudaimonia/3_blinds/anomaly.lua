-- The Anomaly
SMODS.Blind {
    key = "anomaly",
    dollars = 5,
    mult = 1,
    pos = { x = 0, y = 9 },
    boss = { min = 1 },
    boss_colour = HEX("8a59a5"),
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.chips / 2
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
}
