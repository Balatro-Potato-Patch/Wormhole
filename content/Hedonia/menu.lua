-- I (wombat) used a lot of VanillaRemade as reference throughout this entire file https://github.com/nh6574/VanillaRemade/tree/main/src

SMODS.ConsumableType {
    key = "wormhole_hedonia_menu",
    collection_rows = { 4, 3 },
    primary_colour = HEX("fff56c"), --shoutout cryptid https://github.com/SpectralPack/Cryptid/blob/8e041f1b8b3c2f2c5379dabe55bdfb74d28dc08b/items/code.lua#L4
    secondary_colour = HEX("33622c")
}

-- PLACEHOLDER ART ATLAS
SMODS.Atlas {
    key = "placeholder",
    px = 71,
    py = 95,
    path = "Hedonia/sungwon.png"
}

SMODS.Consumable {
    key = "template",
    set = "wormhole_hedonia_menu",
    atlas = "placeholder",
    pos = {x = 0, y = 0},
    use = function(self, card, area, copier)
        
    end
}