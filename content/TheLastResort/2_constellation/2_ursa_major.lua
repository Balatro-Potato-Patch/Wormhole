SMODS.Consumable{
    key = "tlr_const_ursa_major",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    pos = {x=0, y=5},
    ppu_coder = {"Breuhh"},
    ppu_artist = {"Aura2247"},
    config = {
        money = {3, 6, 10, 25},
    },
    can_use = function(self,card)
        return G.GAME.blind.in_blind
    end,
    use = function(self,card,area,copier)
        G.GAME.blind.dollars = G.GAME.blind.dollars + card.ability.money[card.ability.tier]
        G.GAME.current_round.dollars_to_be_earned = G.GAME.blind.dollars > 10 and (localize('$') .. G.GAME.blind.dollars) or (string.rep(localize('$'), G.GAME.blind.dollars)..'')
    end
}