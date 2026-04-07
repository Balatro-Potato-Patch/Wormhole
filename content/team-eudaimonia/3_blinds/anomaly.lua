SMODS.Atlas({
    key = "blinded",
    path = "team-eudaimonia/blinds/anoblind.png",
    px = 34,
    py = 34,
    frames = 21,
    atlas_table = "ANIMATION_ATLAS"
})

SMODS.Atlas({
    key = "blinded",
    path = "team-eudaimonia/blinds/anoblind.png",
    px = 34,
    py = 34,
    frames = 21,
    atlas_table = "ANIMATION_ATLAS"
})

SMODS.Sound {
    key = "music_anomaly",
    path = "music_anomaly.ogg",
    select_music_track = function()
        if G.GAME.blind and G.GAME.blind.config.blind.key == 'bl_worm_anomaly' then
            return true
        end
    end
}

-- The Anomaly (Code by tby and m0xes)
SMODS.Blind {
    key = "anomaly",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 0 },
    boss = { min = 1 },
    boss_colour = HEX("8a8a8a"),
    atlas = 'blinded',
    config = { extra = { tot_change = 1 } },
    percent_change = 0.2,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.percent_change * 100 } }
    end,
    set_blind = function(self)
        G.GAME.blind.mult = math.max(2, (2 + Wormhole.EUDA.anomaly_mult))
        G.GAME.blind.chips = (G.GAME.blind.chips / 2) * G.GAME.blind.mult
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,
    disable = function(self)
        G.GAME.blind.chips = (G.GAME.blind.chips / G.GAME.blind.mult) * 2
    end,
    calculate = function(self, blind, context)
    end,
    in_pool = function(self) return false end,
}
