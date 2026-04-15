SMODS.Atlas({
    key = "euda_fates",
    path = "team-eudaimonia/fates.png",
    px = 71,
    py = 95,
    atlas_table = "ASSET_ATLAS"
})

SMODS.ConsumableType{
    key = "euda_Fate",
    primary_colour = HEX("3e4150"),
    secondary_colour = HEX("ff5192"),
    collection_rows = {5},
    default = "c_euda_bounce"
}

SMODS.UndiscoveredSprite{
    key = "euda_Fate",
    atlas = "euda_fates",
    pos = {x=6,y=0}
}

-- Crunch
SMODS.Consumable{
    key = "euda_crunch",
    atlas = "euda_fates",
    pos = {x=0,y=0},
    set = "euda_Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local suitOptions = {}
        for i = 1, 2 do
            suitOptions[i] = pseudorandom_element(SMODS.Suits, "euda_crunch")
        end
        for _, _card in ipairs(G.deck.cards) do
            local suit = pseudorandom_element(suitOptions, "euda_crunch")
            SMODS.change_base(_card, suit.key)
        end
    end,
    can_use = function(self, card)
        return true
    end
}

-- Freeze
SMODS.Consumable{
    key = "euda_freeze",
    atlas = "euda_fates",
    pos = {x=1,y=0},
    set = "euda_Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local rankOptions = {}
        for i = 1, 4 do
            rankOptions[#rankOptions+1] = pseudorandom_element(SMODS.Ranks, "euda_freeze")
        end
        for _, _card in ipairs(G.deck.cards) do
            local rank = pseudorandom_element(rankOptions, "euda_freeze")
            SMODS.change_base(_card, nil, rank.key)
        end
    end,
    can_use = function(self, card)
        return true
    end
}

-- Rip
SMODS.Consumable{
    key = "euda_rip",
    atlas = "euda_fates",
    pos = {x=2,y=0},
    set = "euda_Fate",
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
    key = "euda_slurp",
    atlas = "euda_fates",
    pos = {x=3,y=0},
    set = "euda_Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local toRemove = math.ceil(#G.deck.cards / 2)

        local removedCount = 0
        local removed = {}

        while removedCount < toRemove do
            local _card = pseudorandom_element(G.deck.cards, "euda_slurp")

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
    key = "euda_bounce",
    atlas = "euda_fates",
    pos = {x=4,y=0},
    set = "euda_Fate",
    ppu_coder = {"iamarta"},
    ppu_artist = {"cosmeggo"},
    ppu_team = {"TeamEudaimonia"},
    use = function(self, card, area, copier)
        local old_count = 0
        local new_count = 0
        for _, _card in ipairs(G.deck.cards) do
            SMODS.destroy_cards(_card, nil, nil, true)
            old_count = old_count + 1
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
                new_count = new_count + 1
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card:juice_up(0.3, 0.5)
                ease_dollars(math.max(new_count - old_count, old_count - new_count), true)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

-- Bang
SMODS.Consumable{
    key = "euda_bang",
    atlas = "euda_fates",
    pos = {x=5,y=0},
    set = "Spectral",
    hidden = true,
    soul_set = "euda_Fate",
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
                edition = SMODS.poll_edition("euda_bang", nil, true),
                seal = SMODS.poll_seal("euda_bang", nil, false, nil, "euda_bang")
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