SMODS.Joker {
    key = "spacecadet",
    rarity = 3,
    cost = 10,
    config = {
        extra = {
        }
    },
    ppu_team = { "Violent Violets" },
    ppu_coder = { "Iso", "FireIce" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,
    calculate = function(self, card, context)
        local retrig_all = false
        if context.before then
            if SMODS.pseudorandom_probability(card, "award_a", 1, 3) then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 15
                return {
                    dollars = 15
                },
                play_sound('worm_jackpot', 1, 1)
            end
            if SMODS.pseudorandom_probability(card, "award_b", 1, 3) then
                ease_hands_played(1)
                return {
                    message = "+1 Hand",
                    colour = G.C.BLUE
                },
                play_sound('worm_extrahand', 1, 1)
            end
            if SMODS.pseudorandom_probability(card, "b", 1, 3) then 
                retrig_all = true
                return {
                    message = "Wormhole!",
                },
                play_sound('worm_wormhole', 1, 1)
            end
        end
        if context.repetition and retrig_all == true then
            return {
                repetitions = 1
            }
        end
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "c", 1, 3) then
                return {
                    xmult = 2,
                },
                play_sound('worm_hyperspace', 1, 1)
            end
        end
        if context.after then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    retrig_all = false
                    return true
                end
            }))
        end
    end
}
