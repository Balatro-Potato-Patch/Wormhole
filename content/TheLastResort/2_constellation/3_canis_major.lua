SMODS.Consumable{
    key = "tlr_const_canis_major",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    pos = {x=0, y=4},
    ppu_team = {"TheLastResort"},
	ppu_coder = {"Jogla"},
    ppu_artist = {"Aura2247"},
    config = {
        amounts = {2, 1, 2, 2},
        choices = {0, 3, 5, 5}
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {
            card.ability.amounts[card.ability.tier],
            card.ability.choices[card.ability.tier],
        }}
    end,
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        if not G.consumeables then return end
        if card.ability.tier == 1 then
            for i=1, math.min(card.ability.amounts[1], G.consumeables.config.temp_limit-G.consumeables.config.card_count+1) do
                --if not (G.consumeables.config.temp_limit-G.consumeables.config.card_count > 0) then break end
                local c = SMODS.add_card{
                    set = 'worm_tlr_constellation',
                    area = G.consumeables
                }
            end
        else
            G.FUNCS.Wormhole_TLR_canis_major{max_selected = card.ability.tier == 4 and card.ability.amounts[card.ability.tier] or math.min(
                card.ability.amounts[card.ability.tier],
                G.consumeables.config.temp_limit-G.consumeables.config.card_count+1
            ),
            max_choices = card.ability.choices[card.ability.tier],
            negative = card.ability.tier == 4}
        end
    end
}