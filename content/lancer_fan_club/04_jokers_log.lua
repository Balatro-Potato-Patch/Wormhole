SMODS.Joker({
    key = "lfc_log",
    pos = { x = 0, y = 1 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    atlas = "lfc_jokers",
    ppu_coder = { "ProdByProto" },
    config = {
        extra = {
            scalar = 2,
        }
    },
    loc_vars = function(self, info_queue, card)
        local var_two = 0
        if G.GAME.worm_log then var_two = card.ability.extra.scalar * G.iter(G.GAME.worm_log) end
        return { vars = { card.ability.extra.scalar, var_two , G.GAME and G.GAME.round or 1 } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.card_added and not context.repetition then
            if context.card.ability.set == "Joker" then
                return{message = "+"..cae.scalar.." "..localize("k_mult")}
            end
        end

        if context.joker_main then
            return { mult = cae.scalar * G.iter(G.GAME.worm_log)}
        end
    end

})
