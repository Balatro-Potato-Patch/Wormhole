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
        return { vars = { card.ability.extra.scalar, G.GAME and G.GAME.worm_log_count or 0, G.GAME and G.GAME.round or 1 } }
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.card_added and not context.repetition then
            if context.card.ability.set == "Joker" then
                return{message = "+"..cae.scalar.." "..localize("k_mult")}
            end
        end

        if context.joker_main then
            return { mult = cae.scalar * G.GAME.worm_log_count}
        end
    end

})
