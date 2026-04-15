SMODS.Joker {
    key = "riverboat_astrophoto",
    config = {
        extra = {
            score_mult = 10
        }
    },
    rarity = 1,
    cost = 5,
    atlas = "jokers",
    pos = { x = 3, y = 0 },
    pixel_size = { w = 71, h = 80 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    ppu_coder = { "blamperer" },
    ppu_artist = { "camo" },
    ppu_team = { "riverboat" },
    attributes = { "score", "planet", "space" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.score_mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" and G.GAME.blind.in_blind then
            local hand_chips, hand_mult = Wormhole.Riverboat.level_params_for_planet(context.consumeable)

            SMODS.calculate_effect({ score = card.ability.extra.score_mult * hand_chips * hand_mult }, card)

            if G.GAME.chips >= G.GAME.blind.chips then
                if G.GAME.current_round.hands_played <= 0 then
                    check_for_unlock { type = "riverboat_instaplanet" }
                end
                G.E_MANAGER:add_event(Event({
                    blocking = false,
                    func = function()
                        if G.STATE == G.STATES.SELECTING_HAND then
                            G.STATE = G.STATES.HAND_PLAYED
                            G.STATE_COMPLETE = true
                            end_round()
                            return true
                        end
                    end
                }))
            end
        end
    end
}
