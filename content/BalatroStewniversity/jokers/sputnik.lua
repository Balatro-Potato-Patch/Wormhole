SMODS.Joker{ --Sputnik

    ppu_team = {'Balatro Stewniversity'},
    ppu_artist = {''},
    ppu_coder = {'PLagger'},

    key = 'worm_stew_sputnik',
    config = {extra = {chips = 50}},
    rarity = 3,
    cost = 8,
    atlas = 'stewjokers',
    pos = {x=6, y=9},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    update_chips = function (self, card)
        
    end

}
-- local thunk = (G.GAME.interest_cap or 25) - math.floor((G.GAME.dollars or 0) / 5) 