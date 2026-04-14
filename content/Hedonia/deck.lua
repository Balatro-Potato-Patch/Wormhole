SMODS.Atlas {
    key = "deck",
    px = 71,
    py = 95,
    path = "Hedonia/deck.png"
}

SMODS.Back {
    key = 'hedonia_bar',
    atlas = 'deck',
    pos = {x=0, y=0},
    apply = function(self, back)

        SMODS.add_card({ set = "Bartender", area = G.Jokers}) --https://github.com/SpectralPack/Cryptid/blob/58a5625f9bba973cdb9ae5e3abde4112276fe1a4/items/misc_joker.lua#L10259

        --[[https://github.com/RAYTRAC3R/AdventureTro/blob/e4e80e61b25391e43d6255a2fbbdc4c1e5d8d06e/items/Decks.lua#L26
        local card_to_create = pseudorandom_element("Bartender", "hedonia_bar")
        local card = SMODS.create_card({set="Joker", area=G.jokers, key=card_to_create})]]
    end
}