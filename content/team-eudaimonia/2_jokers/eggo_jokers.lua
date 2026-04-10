-- Atlas
SMODS.Atlas({
    key = "euda_messageatlas", 
    path = "team-eudaimonia/jokers/message.png", 
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

-- Sound
SMODS.Sound {
    key = "euda_notif",
    path = "notif.ogg"
}

-- Message
SMODS.Joker {
    key = "euda_message",
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = false,
    cost = 1,
    config = { extra = { xmult = 4, odds = 32 }, },
    discovered = true,
    atlas = 'euda_messageatlas',

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
                        play_sound('worm_euda_notif')
                        card:set_ability("j_worm_euda_answer")
                        card:set_eternal(true)
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
    key = "euda_answeratlas", 
    path = "team-eudaimonia/jokers/answer.png", 
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

-- Answer
SMODS.Joker {
    key = "euda_answer",
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = false,
    cost = 1,
    config = { extra = {}, },
    discovered = true,
    atlas = 'euda_answeratlas',
    add_to_deck = function(self, card, from_debuff)
        if (G.GAME.round_resets.blind_choices.Boss ~= 'bl_worm_euda_anomaly') then
            G.from_boss_tag = true
            G.FUNCS.reroll_boss()
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.from_boss_tag = true
        G.FUNCS.reroll_boss()
    end,
}

local get_new_boss_ref = get_new_boss
function get_new_boss()
    if next(SMODS.find_card("j_worm_euda_answer")) then
        return "bl_worm_euda_anomaly"
    end
    return get_new_boss_ref()
end