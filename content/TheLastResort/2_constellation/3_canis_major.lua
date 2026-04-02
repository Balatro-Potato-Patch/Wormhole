SMODS.Consumable{
    key = "tlr_const_canis_major",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    pos = {x=0, y=0},
    config = {
        amounts = {2, 1, 2, 2}
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {
            card.ability.amounts[card.ability.tier]
        }}
    end,
    can_use = function (self, card)
        return math.min(card.ability.amounts[card.ability.tier], G.consumeables.config.temp_limit-G.consumeables.config.card_count) > 0
    end,
    use = function (self, card, area, copier)
        if not G.consumeables then return end
        if card.ability.tier == 1 then
            for i=1, math.min(card.ability.amounts[1], G.consumeables.config.temp_limit-G.consumeables.config.card_count) do
                if not (G.consumeables.config.temp_limit-G.consumeables.config.card_count > 0) then break end
                local c = SMODS.add_card{
                    set = 'worm_tlr_constellation',
                    area = G.consumeables
                }
            end
        elseif card.ability.tier == 2 then
            G.FUNCS.Wormhole_TLR_canis_major{max_selected = 1}
        elseif card.ability.tier == 3 then
            G.FUNCS.Wormhole_TLR_canis_major{max_selected = 2}
        elseif card.ability.tier == 4 then
            G.FUNCS.Wormhole_TLR_canis_major{max_selected = 2, negative = true}
        end
    end
}