bsfx = function(str,prefix)
    return ((prefix == true and "worm_") or "").."lfc_berry_"..str
end
SMODS.Sound({
    key = bsfx("wow"),
    path = bsfx("wow")..".ogg",
    pitch = 1
})
SMODS.Sound({
    key = bsfx("sfx1"),
    path = bsfx("sfx1")..".ogg",
    pitch = 1
})
SMODS.Sound({
    key = bsfx("sfx2"),
    path = bsfx("sfx2")..".ogg",
    pitch = 1
})
SMODS.Sound({
    key = bsfx("sfx3"),
    path = bsfx("sfx3")..".ogg",
    pitch = 1
})
SMODS.Sound({
    key = bsfx("sfx4"),
    path = bsfx("sfx4")..".ogg",
    pitch = 1
})
SMODS.Sound({
    key = bsfx("sfx5"),
    path = bsfx("sfx5")..".ogg",
    pitch = 1
})
SMODS.Sound({
    key = bsfx("ante"),
    path = bsfx("ante")..".ogg",
    pitch = 1
})
SMODS.Sound({
    key = bsfx("secret"),
    path = bsfx("secret")..".ogg",
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
            secret = false
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.card_added and not context.repetition then
            if context.card == card then
                play_sound(bsfx("wow",1),1,0.6)
            end
        end

        if context.individual and context.cardarea == G.play and not context.end_of_round then
			if SMODS.has_enhancement(context.other_card, "m_bonus") then
                return{
                    mult = cae.xmult,
                    remove_default_message = true,
                    message = localize{type = "variable", key = "a_xmult", vars = {cae.xmult}},
                    sound = bsfx("sfx",1)..pseudorandom("moonberry xmult sfx",1,5),
                    colour = G.C.MULT
                }
            end

            if context.ante_change and context.ante_end then
                if G.GAME.round_resets >= 9 then
                    cae.secret = true
                    local eval = function(card) return not card.REMOVED end
                    juice_card_until(card, eval, true)
                end
                return{ 
                    func = function()
                        play_sound(bsfx("ante",1),1,0.6)
                    end
                }
            end

            if context.selling_self then
                SMODS.add_card({"j_worm_lfc_fw"})
                return{ 
                    func = function()
                        play_sound(bsfx("secret",1),1,0.6)
                    end
                }
            end


        end

    end

})
