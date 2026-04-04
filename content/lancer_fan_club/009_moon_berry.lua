SMODS.Sound({
    key = "lfc_berry_wow",
    path = "lfc_berry_wow.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx1",
    path = "lfc_berry_sfx1.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx2",
    path = "lfc_berry_sfx2.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx3",
    path = "lfc_berry_sfx3.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx4",
    path = "lfc_berry_sfx4.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_sfx5",
    path = "lfc_berry_sfx5.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_ante",
    path = "lfc_berry_ante.ogg",
    pitch = 1
})
SMODS.Sound({
    key = "lfc_berry_secret",
    path = "lfc_berry_secret.ogg",
    pitch = 1
})

SMODS.Joker({
    key = "lfc_fw",
    pos = { x = 0, y = 2 },
    soul_pos = { x = 0, y = 3 },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    atlas = "lfc_jokers",
    ppu_coder = { "ProdByProto" },
    config = {
        extra = {
            enhancement = "m_bonus",
            xmult = 2.5,
            secret = 0,
            added = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        local hint1, hint2 = "..."," "
        if card.ability.extra.secret == 1 then
            hint1 = "Sell this joker to reveal a secret!"
            hint2 = "(creates extra copy of Moon Berry, must have room)"
        elseif card.ability.extra.secret == 2 then
            hint1, hint2 = "gotcha, lol", "wow so secret"
        end
        return {
            vars = { card.ability.extra.enhancement and
            localize({ type = 'name_text', set = "Enhanced", key = card.ability.extra.enhancement }) or "Bonus Card",
                card.ability.extra.xmult, hint1, hint2 }
        }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.card_added and not context.repetition then
            if cae.added == 1 then
                cae.added = 0
                return{ 
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = "immeadiate",
                            no_delete = true,
                            pause_force = true,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound("worm_lfc_berry_wow", 1, 0.6)
                                return true
                            end
                        }))
                    end
                }
            end
            if not G.GAME.lfc_berry_secret then G.GAME.lfc_berry_secret = 0 end
            cae.secret = G.GAME.lfc_berry_secret
        end

        if context.individual and context.cardarea == G.play and not context.end_of_round then
			if SMODS.has_enhancement(context.other_card, "m_bonus") then
                return{
                    xmult = cae.xmult,
                    remove_default_message = true,
                    message = localize { type = "variable", key = "a_xmult", vars = { cae.xmult } },
                    sound = "worm_lfc_berry_sfx" .. pseudorandom("moonberry_xmult_sfx", 1, 5),
                    colour = G.C.MULT
                }
            end

            if context.ante_change and context.ante_end then
                if G.GAME.round_resets.ante >= 9 then
                    if cae.secret == 0 then cae.secret = 1 end
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                end
                return {
                    func = function()
                        play_sound("worm_lfc_berry_ante", 1, 0.6)
                    end
                }
            end

            if context.selling_self and G.GAME.round_resets.ante >= 9 and cae.secret == 1 then
                G.GAME.lfc_berry_secret = 2
                SMODS.add_card({ key = "j_worm_lfc_fw" })
                return{ 
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = "immeadiate",
                            no_delete = true,
                            pause_force = true,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound("worm_lfc_berry_secret", 1, 0.6)
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end

})
