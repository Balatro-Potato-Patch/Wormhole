-- Atlas
SMODS.Atlas({
    key = "message", 
    path = "team-eudaimonia/message.png", 
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

-- Sound
SMODS.Sound {
    key = "notif",
    path = "notif.ogg"
}

-- Message
SMODS.Joker {
    key = "message",
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = false,
    cost = 1,
    config = { extra = { xmult = 4, odds = 1 }, },
    discovered = true,
    atlas = 'message',

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_message')
        return { vars = { card.ability.extra.xmult, numerator, denominator, } }
    end,

    calculate = function(self, card, context)
        if context.joker_main and SMODS.pseudorandom_probability(card, 'vremade_space', 1, card.ability.extra.odds) then -- Consequence
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('worm_notif')
                        card:set_ability("j_worm_answer")
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                return {
                    message = "Received!",
                    colour = G.C.BLUE
                }
        end

        if context.joker_main then --XMult
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Atlas
SMODS.Atlas({
    key = "answer", 
    path = "team-eudaimonia/answer.png", 
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

-- Answer
SMODS.Joker {
    key = "answer",
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = false,
    cost = 1,
    config = { extra = {}, },
    discovered = true,
    atlas = 'answer',
}