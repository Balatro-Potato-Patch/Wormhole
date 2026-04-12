-- Brain Scrambler
SMODS.Joker {
    key = "lfc_brain_scrambler",
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 7,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit" },
    ppu_artist = { "J8-Bit" },
    ppu_team = { "Lancer Fan Club" },
    pos = { x = 1, y = 1 },
    discovered = false,
    config = { extra = { repetitions = 1 } },
    attributes = {
        "retriggers",
        "hands",
    },
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = 1
            }
        end
        if context.press_play and not context.blueprint then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            G.play:shuffle('worm_lfc_scrambler' ..
                            G.GAME.round_resets.ante .. G.GAME.round .. G.GAME.current_round.hands_left)
                            return true
                        end
                    }))
                    return true
                end
            }
        end
    end,
}
