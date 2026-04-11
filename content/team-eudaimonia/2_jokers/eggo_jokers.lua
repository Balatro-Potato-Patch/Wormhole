-- Atlas
SMODS.Atlas({
    key = "euda_messageatlas", 
    path = "team-eudaimonia/TheMessage.png", 
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
    config = { extra = { xmult = 4, odds = 32, answered = false }, },
    discovered = true,
    atlas = 'euda_messageatlas',

    loc_vars = function(self, info_queue, card)
        if card.ability.extra.answered then
            return { key = "j_worm_euda_answer" }
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_euda_message')
        return { vars = { card.ability.extra.xmult, numerator, denominator, } }
    end,
    add_to_deck = function(self, card, from_debuff)
        if (G.GAME.round_resets.blind_choices.Boss ~= 'bl_worm_euda_anomaly'
        and card.ability.extra.answered) then
            G.from_boss_tag = true
            G.FUNCS.reroll_boss()
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if (G.GAME.round_resets.blind_choices.Boss == 'bl_worm_euda_anomaly'
        and card.ability.extra.answered) then
            G.from_boss_tag = true
            G.FUNCS.reroll_boss()
        end
    end,
    set_sprites = function(self, card, front)
        if card.ability and card.ability.extra and card.ability.extra.answered then
			card.children.center:set_sprite_pos({x = 1, y = 0})
		end
    end,
    calculate = function(self, card, context)
        if card.ability.extra.answered then
            return
        end
        if context.joker_main and SMODS.pseudorandom_probability(card, 'vremade_space', 1, card.ability.extra.odds) then -- Consequence
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local evolution = card
                        play_sound('worm_euda_notif')
                        card.children.center:set_sprite_pos({ x = 1, y = 0 })
                        card.ability.eternal = true
                        card.ability.extra.answered = true
                        card:juice_up(0.3, 0.5)
                        G.from_boss_tag = true
                        G.FUNCS.reroll_boss()
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

local get_new_boss_ref = get_new_boss
function get_new_boss()
    for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
        if joker.config.center.key == "j_worm_euda_message"
        and joker.ability.extra.answered then
            return "bl_worm_euda_anomaly"
        end
    end
    return get_new_boss_ref()
end