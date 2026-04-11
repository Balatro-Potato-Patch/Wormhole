SMODS.Atlas({
    key = "euda_anomalyatlas",
    path = "team-eudaimonia/blinds/anoblind.png",
    px = 34,
    py = 34,
    frames = 21,
    atlas_table = "ANIMATION_ATLAS"
})
SMODS.Sound {
    key = "euda_music_anomaly",
    path = "music_anomaly.ogg",
    select_music_track = function()
        if G.GAME.blind and G.GAME.blind.config.blind.key == 'bl_worm_euda_anomaly' then
            return true
        end
    end
}
-- The Anomaly
local percent_change = 0.2
SMODS.Blind {
    key = "euda_anomaly",
    atlas = "euda_anomalyatlas",
    dollars = 5,
    mult = 1,
    pos = { x = 0, y = 0 },
    boss = { min = 1 },
    boss_colour = HEX("8a8a8a"),
    set_blind = function(self)
        G.GAME.blind.mult = self.mult + percent_change * G.GAME.hands_played
        G.GAME.blind.chips = G.GAME.blind.chips / self.mult * G.GAME.blind.mult
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = (function()
                SMODS.juice_up_blind()
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.06 * G.SETTINGS.GAMESPEED,
                    blockable = false,
                    blocking = false,
                    func = function()
                        play_sound('tarot2', 0.76, 0.4)
                        return true
                    end
                }))
                play_sound('tarot2', 1, 0.4)
                return true
            end)
        }))
        delay(0.4)
    end,
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.chips / G.GAME.blind.mult
        G.GAME.blind.mult = self.mult
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,
    calculate = function(self, blind, context)
        if  not blind.disabled and context.before then
            G.GAME.blind.chips = G.GAME.blind.chips * (1 + percent_change / G.GAME.blind.mult) -- Equal to Original Chips * (mult + percent_change)
            G.GAME.blind.mult  = G.GAME.blind.mult + percent_change
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            blind.triggered = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function()
                    SMODS.juice_up_blind()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    return true
                end)
            }))
            delay(0.4)
        end
    end,
    in_pool = function(self) return false end,
}
