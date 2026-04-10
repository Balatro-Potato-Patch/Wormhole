SMODS.Consumable{
    key = "tlr_const_canis_minor",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    ppu_coder = {"Breuhh"},
    ppu_artist = {"Aura2247"},
    pos = {x=0, y=3},
    config = {
        tiers = {2, 3, 3, 4},
    },
    can_use = function(self,card)
        return G.GAME.worm_tlr_last_const_used ~= self.key
    end,
    use = function(self,card,area,copier)
        local newcard = SMODS.create_card({key = G.GAME.worm_tlr_last_const_used})
        if card.ability.tier >= 3 then newcard:set_edition("e_Negative") end
        newcard.ability.tier = card.ability.tiers[card.ability.tier]
        WORM_TLR.update_const_sprite(newcard.ability.center, newcard)
    end
}