SMODS.Atlas({
    key = "fates",
    path = "team-eudaimonia/fates.png",
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

SMODS.ConsumableType{
    key = "Fate",
    primary_colour = HEX("3e4150"),
    secondary_colour = HEX("ff5192"),
    collection_rows = {5},
    default = "c_bounce"
}

SMODS.UndiscoveredSprite{
    key = "Fate",
    atlas = "fates",
    pos = {x=6,y=0}
}

-- Crunch
SMODS.Consumable{
    key = "crunch",
    atlas = "fates",
    pos = {x=0,y=0},
    set = "Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local suitOptions = {}
        for i = 1, 2 do
            suitOptions[i] = pseudorandom_element(SMODS.Suits, "crunch")
        end
        for _, _card in ipairs(G.deck.cards) do
            local suit = pseudorandom_element(suitOptions, "crunch")
            SMODS.change_base(_card, suit.key)
        end
    end,
    can_use = function(self, card)
        return true
    end
}

-- Freeze
SMODS.Consumable{
    key = "freeze",
    atlas = "fates",
    pos = {x=1,y=0},
    set = "Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local rankOptions = {}
        for i = 1, 4 do
            rankOptions[#rankOptions+1] = pseudorandom_element(SMODS.Ranks, "freeze")
        end
        for _, _card in ipairs(G.deck.cards) do
            local rank = pseudorandom_element(rankOptions, "freeze")
            SMODS.change_base(_card, nil, rank.key)
        end
    end,
    can_use = function(self, card)
        return true
    end
}

-- Rip
SMODS.Consumable{
    key = "rip",
    atlas = "fates",
    pos = {x=2,y=0},
    set = "Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local tempDeck = {}
        for _, _card in ipairs(G.deck.cards) do
            local rankMod = math.ceil(_card:get_id() / 2)
            SMODS.modify_rank(_card, -rankMod)
        end
        for _, _card in ipairs(G.deck.cards) do
            tempDeck[#tempDeck+1] = copy_card(_card, nil, nil, G.playing_card)
        end
        for _, _card in ipairs(tempDeck) do
            _card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, _card)
            G.deck:emplace(_card)
        end
    end,
    can_use = function(self, card)
        return true
    end
}

-- Slurp
SMODS.Consumable{
    key = "slurp",
    atlas = "fates",
    pos = {x=3,y=0},
    set = "Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local toRemove = math.ceil(#G.deck.cards / 2)

        local removedCount = 0
        local removed = {}

        while removedCount < toRemove do
            local _card = pseudorandom_element(G.deck.cards, "slurp")

            if not removed[_card] then
                removed[_card] = true
                removedCount = removedCount + 1
                SMODS.destroy_cards(_card, nil, nil, true)
            end
        end
    end,
    can_use = function(self, card)
        return true
    end
}

-- Bounce
SMODS.Consumable{
    key = "bounce",
    atlas = "fates",
    pos = {x=4,y=0},
    set = "Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        for _, _card in ipairs(G.deck.cards) do
            SMODS.destroy_cards(_card, nil, nil, true)
        end
        for i, _suit in pairs(SMODS.Suits) do
            for j, _rank in pairs(SMODS.Ranks) do
                local _card = SMODS.create_card({
                    set = "Playing Card",
                    skip_materialize = true,
                    rank = _rank.key,
                    suit = _suit.key,
                    enhanced_poll = 1
                })
                _card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
                G.deck:emplace(_card)
            end
        end
    end,
    can_use = function(self, card)
        return true
    end
}

-- Bang
SMODS.Consumable{
    key = "bang",
    atlas = "fates",
    pos = {x=5,y=0},
    set = "Spectral",
    hidden = true,
    soul_set = "Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"iamarta", "cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local cardCount = #G.deck.cards
        for _, _card in ipairs(G.deck.cards) do
            SMODS.destroy_cards(_card, nil, nil, true)
        end
        for i = 1, cardCount do
            local _card = SMODS.create_card({
                set = "Playing Card",
                skip_materialize = true,
                edition = SMODS.poll_edition("big_bang", nil, true),
                seal = SMODS.poll_seal("big_bang", nil, false, nil, "big_bang")
            })
            _card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, _card)
            G.deck:emplace(_card)
        end
    end,
    can_use = function(self, card)
        return true
    end
}