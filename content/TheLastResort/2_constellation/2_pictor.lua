SMODS.Consumable{
    key = "tlr_const_pictor",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    pos = {x=0, y=8},
    ppu_coder = {"Breuhh"},
    ppu_artist = {"Aura2247"},
    config = {
        handsize = {1, 2, 3, 5},
    },
    can_use = function(self,card)
        return not G.GAME.blind.in_blind
    end,
    use = function(self,card,area,copier)
        G.hand:change_size(card.ability.handsize[card.ability.tier])
        G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.handsize[card.ability.tier]
    end
}