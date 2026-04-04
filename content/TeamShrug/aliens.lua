SMODS.ConsumableType{
    key = 'shrug_alien',
    default = 'c_fool',
    collection_rows = {3, 4},
    primary_colour = G.C.UI.TEXT_DARK,
    secondary_colour = G.C.DARK_EDITION,
    shop_rate = 0.0,
    loc_txt = { -- i dont know how to put it in localization
            collection = 'Aliens',
            name = 'Alien',
        },
}
SMODS.Atlas{
    key = 'shrug_alien_cards',
    path = 'TeamShrug/consumables.png',
    px = 71,
    py = 95
}
SMODS.UndiscoveredSprite{
    key = 'shrug_alien',
    atlas = 'shrug_alien_cards',
    pos = {x = 0, y = 0}
}

SMODS.Atlas{
    key = 'shrug_boosters',
    path = 'TeamShrug/boosters.png',
    px = 71,
    py = 95
}
SMODS.Booster {
    key = "shrug_alien_normal",
    config = {extra = 2, choose = 1},
    group_key = "shrug_alien_pack",
    cost = 4,
    weight = 0.3,
    atlas = "shrug_boosters",
    pos = {x = 0, y = 0},
    kind = "shrug_alien_pack",
    discovered = true,
    draw_hand = true,
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.choose, center.ability.extra}}
        end,
    create_card = function(self, card)
        local newCard = SMODS.create_card({set = "shrug_alien", area = G.pack_cards, skip_materialize = true})
        return newCard
            end,
    select_card = function(card, pack)
        return false
        end,
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"}
}

SMODS.Booster {
    key = "shrug_alien_normal2",
    config = {extra = 2, choose = 1},
    group_key = "shrug_alien_pack",
    cost = 4,
    weight = 0.3,
    atlas = "shrug_boosters",
    pos = {x = 1, y = 0},
    kind = "shrug_alien_pack",
    discovered = true,
    draw_hand = true,
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.choose, center.ability.extra}}
        end,
    create_card = function(self, card)
        local newCard = SMODS.create_card({set = "shrug_alien", area = G.pack_cards, skip_materialize = true})
        return newCard
            end,
    select_card = function(card, pack)
        return false
        end,
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"}
}

SMODS.Booster {
    key = "shrug_alien_jumbo",
    config = {extra = 4, choose = 1},
    group_key = "shrug_alien_pack",
    cost = 6,
    weight = 0.3,
    atlas = "shrug_boosters",
    pos = {x = 2, y = 0},
    kind = "shrug_alien_pack",
    discovered = true,
    draw_hand = true,
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.choose, center.ability.extra}}
        end,
    create_card = function(self, card)
        local newCard = SMODS.create_card({set = "shrug_alien", area = G.pack_cards, skip_materialize = true})
        return newCard
            end,
    select_card = function(card, pack)
        return false
        end,
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"}
}

SMODS.Booster {
    key = "shrug_alien_mega",
    config = {extra = 4, choose = 2},
    group_key = "shrug_alien_pack",
    cost = 8,
    weight = 0.3,
    atlas = "shrug_boosters",
    pos = {x = 3, y = 0},
    kind = "shrug_alien_pack",
    discovered = true,
    draw_hand = true,
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.choose, center.ability.extra}}
        end,
    create_card = function(self, card)
        local newCard = SMODS.create_card({set = "shrug_alien", area = G.pack_cards, skip_materialize = true})
        return newCard
            end,
    select_card = function(card, pack)
        return false
        end,
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"}
}

SMODS.Consumable{
    key = 'shrug_alien',
    set = 'shrug_alien',
    loc_txt = {name = '', text = {"i didnt want to code any aliens so here's placeholder, just delete it if you're gonna add an alien"}},
    atlas = 'shrug_alien_cards',
    unlocked = true,
    discovered = true,
    cost = 0,
}
