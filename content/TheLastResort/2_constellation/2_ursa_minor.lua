SMODS.Consumable{
    key = "tlr_const_ursa_minor",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    pos = {x=0, y=0},
    ppu_coder = {"Breuhh"},
    ppu_artist = {"Aura2247"},
    config = {
        fraction = {0.1, 0.15, 0.25, 0.5},
    },

    can_use = function(self,card)
        return G.GAME.blind.in_blind
    end,

    use = function(self,card,area,copier)
        G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function() 
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips - G.GAME.blind.chips * card.ability.fraction[card.ability.tier])
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                return true
            end
        }))
    end
}