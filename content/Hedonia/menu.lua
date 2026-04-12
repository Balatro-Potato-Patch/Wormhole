-- I (wombat) used a lot of VanillaRemade as reference throughout this entire file https://github.com/nh6574/VanillaRemade/tree/main/src

SMODS.ConsumableType {
    key = "worm_hedonia_menu",
    collection_rows = { 4, 4 },
    primary_colour = HEX("9b7abb"), --shoutout cryptid https://github.com/SpectralPack/Cryptid/blob/8e041f1b8b3c2f2c5379dabe55bdfb74d28dc08b/items/code.lua#L4
    secondary_colour = HEX("503a66")
}

SMODS.Atlas {
    key = "menu",
    px = 71,
    py = 95,
    path = "Hedonia/menu.png"
}

SMODS.Atlas {
    key = "booster_placeholder",
    px = 71,
    py = 95,
    path = "Hedonia/boosters placeholder.png"
}

SMODS.Consumable {
    key = "hedonia_hadron",
    set = "worm_hedonia_menu",
    atlas = "menu",
    pos = {x = 0, y = 0},
    use = function(self, card, area, copier)
        local card_to_drink = pseudorandom_element(G.hand.cards, 'alcohol') --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/spectrals.lua#L26
        local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_tipsy", weight = 1}}})
        card_to_drink:set_edition(edition,true)
    end,
    can_use = function(self, card)
        return G.hand and G.hand.cards
    end
}

SMODS.Consumable {
    key = "hedonia_cosmo",
    set = "worm_hedonia_menu",
    atlas = "menu",
    pos = {x = 1, y = 0},
    use = function(self, card, area, copier)
        local card_to_drink = pseudorandom_element(G.hand.cards, 'alcohol') --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/spectrals.lua#L26
        local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_drunk", weight = 1}}})
        card_to_drink:set_edition(edition,true) 
    end,
    can_use = function(self, card)
        return G.hand and G.hand.cards
    end
}

SMODS.Consumable {
    key = "hedonia_mojitury",
    set = "worm_hedonia_menu",
    atlas = "menu",
    pos = {x = 2, y = 0},
    use = function(self, card, area, copier)
        local card_to_drink = pseudorandom_element(G.hand.cards, 'alcohol') --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/spectrals.lua#L26
        local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_very_drunk", weight = 1}}})
        card_to_drink:set_edition(edition,true) 
    end,
    can_use = function(self, card)
        return G.hand and G.hand.cards
    end
}

SMODS.Consumable {
    key = "hedonia_blackHoleBomb",
    set = "worm_hedonia_menu",
    atlas = "menu",
    pos = {x = 3, y = 0},
    use = function(self, card, area, copier)
        local card_to_drink = pseudorandom_element(G.hand.cards, 'alcohol') --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/spectrals.lua#L26
        local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_blackout", weight = 1}}})
        card_to_drink:set_edition(edition,true) 
    end,
    can_use = function(self, card)
        return G.hand and G.hand.cards
    end
}

SMODS.Consumable {
    key = "hedonia_jawbreaker",
    set = "worm_hedonia_menu",
    atlas = "menu",
    pos = {x = 0, y = 1},
    config = { extra = {
        bonus = 50
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.bonus}}
    end,
    use = function(self, card, area, copier)
        local card_to_bonus = pseudorandom_element(G.hand.cards, 'alcohol') --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/spectrals.lua#L26
        card_to_bonus.ability.perma_bonus = (card_to_bonus.ability.perma_bonus or 0) + card.ability.extra.bonus --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/jokers.lua#L1442
        return {
            card = card_to_bonus,
            message = 'Upgrade!'
        }
    end,
    can_use = function(self, card)
        return G.hand and G.hand.cards
    end
}

SMODS.Consumable {
    key = "hedonia_rings",
    set = "worm_hedonia_menu",
    atlas = "menu",
    pos = {x = 1, y = 1},
    use = function(self, card, area, copier)
        for i, v in pairs(G.hand.cards) do
            local is_drunk = v.edition and v.edition.key
            if is_drunk == 'e_worm_hedonia_tipsy' then --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/jokers.lua#L791
                v:set_edition(nil, true)
            elseif is_drunk == 'e_worm_hedonia_drunk' then
                local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_tipsy", weight = 1}}})
                v:set_edition(edition, true)
            elseif is_drunk == 'e_worm_hedonia_very_drunk' then
                local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_drunk", weight = 1}}})
                v:set_edition(edition, true)
            elseif is_drunk == 'e_worm_hedonia_blackout' then
                local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_very_drunk", weight = 1}}})
                v:set_edition(edition, true)
            end
        end
    end,
    can_use = function(self, card)
        local has_drunk = false
        if G.hand and G.hand.cards then
            for i,v in pairs(G.hand.cards) do
                if has_drunk == true then break end
                has_drunk = v.edition and (
                    v.edition.key == 'e_worm_hedonia_tipsy' or
                    v.edition.key == 'e_worm_hedonia_drunk' or
                    v.edition.key == 'e_worm_hedonia_very_drunk' or
                    v.edition.key == 'e_worm_hedonia_blackout'
                )
            end
        end
        return has_drunk
    end
}

SMODS.Consumable {
    key = "hedonia_debbie",
    set = "worm_hedonia_menu",
    atlas = "menu",
    pos = {x = 2, y = 1},
    config = { extra = {
        cards = 2
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.cards}}
    end,
    use = function(self, card, area, copier)
        local rank = pseudorandom_element(SMODS.Ranks, 'debbie') --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/spectrals.lua#L415
        for i = 1, #G.hand.highlighted do --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/tarots.lua#L695
            SMODS.modify_rank(G.hand.highlighted[i], rank)
        end
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == 2
    end
}

SMODS.Consumable {
    key = "hedonia_jam",
    set = "worm_hedonia_menu",
    atlas = "menu",
    pos = {x = 3, y = 1},
    config = { extra = {
        cards = 2
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.cards}}
    end,
    use = function(self, card, area, copier)
        local suit = pseudorandom_element(SMODS.Suits, 'space_jam')
        for i = 1, #G.hand.highlighted do
            SMODS.modify_suit(G.hand.highlighted[i], suit)
        end
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == 2
    end
}

SMODS.Booster {
    key = "hedonia_menu_normal_1",
    kind = "hedonia_menu",
    cost = 4,
    atlas = "booster_placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1, name = "Menu Pack" },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "worm_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.choose, self.config.extra, self.config.name},
            key = "p_worm_hedonia_menu"
        }
    end
}

SMODS.Booster {
    key = "hedonia_menu_normal_2",
    kind = "hedonia_menu",
    cost = 4,
    atlas = "booster_placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = 3, choose = 1, name = "Menu Pack" },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "worm_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.choose, self.config.extra, self.config.name},
            key = "p_worm_hedonia_menu"
        }
    end
}

SMODS.Booster {
    key = "hedonia_menu_normal_3",
    kind = "hedonia_menu",
    cost = 4,
    atlas = "booster_placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = 3, choose = 1, name = "Menu Pack" },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "worm_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.choose, self.config.extra, self.config.name},
            key = "p_worm_hedonia_menu"
        }
    end
}

SMODS.Booster {
    key = "hedonia_menu_normal_4",
    kind = "hedonia_menu",
    cost = 4,
    atlas = "booster_placeholder",
    pos = { x = 3, y = 0 },
    config = { extra = 3, choose = 1, name = "Menu Pack" },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "worm_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.choose, self.config.extra, self.config.name},
            key = "p_worm_hedonia_menu"
        }
    end
}

SMODS.Booster {
    key = "hedonia_menu_jumbo_1",
    kind = "hedonia_menu",
    cost = 6,
    atlas = "booster_placeholder",
    pos = { x = 0, y = 1 },
    config = { extra = 4, choose = 1, name = "Jumbo Menu Pack" },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "worm_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.choose, self.config.extra, self.config.name},
            key = "p_worm_hedonia_menu"
        }
    end
}

SMODS.Booster {
    key = "hedonia_menu_jumbo_2",
    kind = "hedonia_menu",
    cost = 6,
    atlas = "booster_placeholder",
    pos = { x = 1, y = 1 },
    config = { extra = 4, choose = 1, name = "Jumbo Menu Pack" },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "worm_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.choose, self.config.extra, self.config.name},
            key = "p_worm_hedonia_menu"
        }
    end
}

SMODS.Booster {
    key = "hedonia_menu_mega_1",
    kind = "hedonia_menu",
    cost = 8,
    atlas = "booster_placeholder",
    pos = { x = 2, y = 1 },
    config = { extra = 4, choose = 2, name = "Mega Menu Pack" },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "worm_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.choose, self.config.extra, self.config.name},
            key = "p_worm_hedonia_menu"
        }
    end
}

SMODS.Booster {
    key = "hedonia_menu_mega_2",
    kind = "hedonia_menu",
    cost = 8,
    atlas = "booster_placeholder",
    pos = { x = 3, y = 1 },
    config = { extra = 4, choose = 2, name = "Mega Menu Pack" },
    draw_hand = true,
    create_card = function(self, card)
        return {set = "worm_hedonia_menu", area = G.pack_cards, skip_materialize = true}
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {self.config.choose, self.config.extra, self.config.name},
            key = "p_worm_hedonia_menu"
        }
    end
}
