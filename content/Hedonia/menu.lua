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

SMODS.Atlas {
    key = "booster_placeholder",
    px = 71,
    py = 95,
    path = "Hedonia/boosters placeholder.png"
}

SMODS.Consumable {
    key = "template",
    set = "wormhole_hedonia_menu",
    atlas = "placeholder",
    pos = {x = 0, y = 0},
    use = function(self, card, area, copier)
        
    end
}

SMODS.Booster {
    key = "hedonia_menu_normal_1",
    kind = "hedonia_menu_booster",
    cost = 4,
    atlas = "booster_placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "wormhole_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end
}

SMODS.Booster {
    key = "hedonia_menu_normal_2",
    kind = "hedonia_menu_booster",
    cost = 4,
    atlas = "booster_placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "wormhole_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end
}

SMODS.Booster {
    key = "hedonia_menu_normal_3",
    kind = "hedonia_menu_booster",
    cost = 4,
    atlas = "booster_placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "wormhole_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end
}

SMODS.Booster {
    key = "hedonia_menu_normal_4",
    kind = "hedonia_menu_booster",
    cost = 4,
    atlas = "booster_placeholder",
    pos = { x = 3, y = 0 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "wormhole_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end
}

SMODS.Booster {
    key = "hedonia_menu_jumbo_1",
    kind = "hedonia_menu_booster",
    cost = 6,
    atlas = "booster_placeholder",
    pos = { x = 0, y = 1 },
    config = { extra = 4, choose = 1 },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "wormhole_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end
}

SMODS.Booster {
    key = "hedonia_menu_jumbo_2",
    kind = "hedonia_menu_booster",
    cost = 6,
    atlas = "booster_placeholder",
    pos = { x = 1, y = 1 },
    config = { extra = 4, choose = 1 },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "wormhole_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end
}

SMODS.Booster {
    key = "hedonia_menu_mega_1",
    kind = "hedonia_menu_booster",
    cost = 8,
    atlas = "booster_placeholder",
    pos = { x = 2, y = 1 },
    config = { extra = 4, choose = 2 },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "wormhole_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end
}

SMODS.Booster {
    key = "hedonia_menu_mega_2",
    kind = "hedonia_menu_booster",
    cost = 8,
    atlas = "booster_placeholder",
    pos = { x = 3, y = 1 },
    config = { extra = 4, choose = 2 },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "wormhole_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end
}