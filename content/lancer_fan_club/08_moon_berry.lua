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
    pos = { x = 0, y = 3 },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    atlas = "lfc_jokers",
    ppu_coder = { "ProdByProto" },
    config = {
        extra = {
            xmult = 2.5,
            secret = 0
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.card_added and not context.repetition then
            if context.card == card then
                play_sound("worm_lfc_berry_wow",1,0.6)
            end
        end

        if context.individual and context.cardarea == G.play and not context.end_of_round then
			if SMODS.has_enhancement(context.other_card, "m_bonus") then
                return{
                    mult = cae.xmult,
                    remove_default_message = true,
                    message = localize{type = "variable", key = "a_xmult", vars = {cae.xmult}},
                    sound = "worm_lfc_berry_sfx"..pseudorandom("moonberry_xmult_sfx",1,5),
                    colour = G.C.MULT
                }
            end

            if context.ante_change and context.ante_end then
                if G.GAME.round_resets >= 9 then
                    cae.secret = 1
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                end
                return{ 
                    func = function()
                        play_sound("worm_lfc_berry_ante",1,0.6)
                    end
                }
            end

            if context.selling_self and G.GAME.round_resets >= 9 and cae.secret == 1 then
                cae.secret = 2
                SMODS.add_card({"j_worm_lfc_fw"})
                return{ 
                    func = function()
                        play_sound("worm_lfc_berry_secret",1,0.6)
                    end
                }
            end


        end

    end

})
