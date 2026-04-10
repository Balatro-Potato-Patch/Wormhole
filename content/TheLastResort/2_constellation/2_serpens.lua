SMODS.Consumable{
    key = "tlr_const_serpens",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    pos = {x=0, y=7},
    ppu_coder = {"Breuhh"},
    ppu_artist = {"Aura2247"},
    config = {
        hands = {1, 1, 2, 3},
        discards = {1, 2, 2, 3}
    },
    can_use = function(self,card)
        return true
    end,
    use = function(self,card,area,copier)
        G.GAME.round_bonus.next_hands = G.GAME.round_bonus.next_hands + card.ability.hands[card.ability.tier]
        G.GAME.round_bonus.discards = G.GAME.round_bonus.discards + card.ability.discards[card.ability.tier]
        G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                card:juice_up(0.5, 0.5)
            return true
            end
        }))
    end
}