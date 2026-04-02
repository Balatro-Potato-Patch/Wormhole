SMODS.Joker({
    key = "log",
    pos = {x=0,y=0},
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    ppu_coder = {"ProdByProto"},
    config = {
        extra = {
            mult = 0,
            scalar = 2,
        }
    },
    loc_vars = function(self,info_queue,card)
        return{vars={card.ability.extra.scalar, card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.card_added and not context.repetition then
            if context.card.ability.set == "Joker" then
                cae.mult = cae.mult + cae.scalar
                juice_card(card)
            end
        end

        if context.joker_main then
            return{mult=cae.mult}
        end
    end

})