SMODS.Atlas({
    key = "stargaze_jokers",
    px = 71,
    py = 95,
    path = "Stargaze/jokers.png"
})

SMODS.Joker({
    key = "typhoon",

    loc_txt = {
        name = "Humanoid Typhoon",
        text = {
            "If played hand is {C:attention}#2#{},",
            "gain {X:mult,C:white}X0.2{} Mult",
            "{C:inactive}(Changes each round){}",
            "{C:inactive}(Current: {X:mult,C:white}X#1#{}){}"
        }
    },

    rarity = 3,
    blueprint_compat = true,
    cost = 9,
    pos = { x = 1, y = 0 },
    atlas = "stargaze_jokers",

    config = {
        extra = {
            xmult = 1,
            target_hand = "High Card"
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                string.format("%.1f", card.ability.extra.xmult),
                card.ability.extra.target_hand
            }
        }
    end,

    calculate = function(self, card, context)

        if context.end_of_round then
            local hands = {}
            for k, v in pairs(G.GAME.hands) do
                table.insert(hands, k)
            end

            if #hands > 0 then
                card.ability.extra.target_hand =
                    pseudorandom_element(hands, pseudoseed('vash'))
            end
        end

        if context.joker_main then
            if context.scoring_name == card.ability.extra.target_hand then
                card.ability.extra.xmult = card.ability.extra.xmult + 0.2

                return {
                    message = "Upgrade!",
                    colour = G.C.MULT
                }
            end

            return {
                x_mult = card.ability.extra.xmult
            }
        end
    end
})

SMODS.Atlas({
    key = "stargaze_jokers",
    px = 71,
    py = 95,
    path = "Stargaze/plushie.png"
})

SMODS.Joker({
    key = "punisher",

    loc_txt = {
        name = "The Punisher",
        text = {
            "{C:mult}+15{} Mult if {C:attention}5 cards{} are played",
            "{C:inactive}(Prevents death and has its final stand){}",
            "{X:mult,C:white}X#1#{} Mult, loses {X:mult,C:white}X3{} per round"
        }
    },

    rarity = 3,
    blueprint_compat = true,
    cost = 8,
    pos = { x = 2, y = 0 },
    atlas = "stargaze_jokers",

    config = {
        extra = {
            evolved = false,
            xmult = 15,
            used_revive = false
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)

      if context.game_over 
and not card.ability.extra.used_revive then

    card.ability.extra.used_revive = true
    card.ability.extra.evolved = true

    card.children.center:set_sprite_pos({x = 3, y = 0})
    card.children.center:reset()

    G.E_MANAGER:add_event(Event({
        func = function()
            card.ability.extra.xmult = 15
            return true
        end
    }))

    return {
        message = "Revived.",
        colour = G.C.BLACK,
        saved = true
    }
end
       if context.end_of_round 
and card.ability.extra.evolved then

    -- Only trigger once per round
    if card.ability.extra.last_round ~= G.GAME.round then
        card.ability.extra.last_round = G.GAME.round

        card.ability.extra.xmult =
            math.max(1, card.ability.extra.xmult - 3)

        -- 💀 If it reaches 1 → destroy Joker
        if card.ability.extra.xmult <= 1 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.8)

                    card:start_dissolve()
                    return true
                end
            }))

            return {
                message = "Dead.",
                colour = G.C.BLACK
            }
        end

        return {
            message = "-3X",
            colour = G.C.RED
        }
    end
end

        if context.joker_main then

            -- Phase 1
            if not card.ability.extra.evolved then
                if context.full_hand and #context.full_hand == 5 then
                    return {
                        mult = 15
                    }
                end
            end

            -- Phase 2
            if card.ability.extra.evolved then
                return {
                    x_mult = card.ability.extra.xmult
                }
            end
        end
    end
})