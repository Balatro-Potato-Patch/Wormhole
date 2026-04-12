SMODS.Back({
    key = "riverboat_reverse_deck",
    atlas = "worm_decks",
    pos = { x = 0, y = 0 },
    name = "Reverse Deck",
    config = { reverse_ante = true },
    loc_txt = {
        name = "Reverse Deck",
        text = {
            "Start at {C:attention}Ante 8{} and",
            "count down to {C:attention}Ante 1{}",
            "Start with {C:attention}Antimatter{} and",
            "{C:attention}Crystal Ball{} vouchers",
            "Start with {C:attention}6{} random Jokers,",
            "{C:attention}2{} Tarots, and {C:attention}1{} Spectral",
            "{C:inactive}(Hand levels are randomized)"
        }
    },
    apply = function(self)
        G.GAME.modifiers.reverse_ante = true
        G.GAME.round_resets.ante = 8
        G.GAME.round_resets.blind_ante = 8

        -- Push initialization logic to an event so it runs cleanly after run creation
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                if G.hand_text_area and G.hand_text_area.ante then
                    G.GAME.round_resets.ante_disp = number_format(G.GAME.round_resets.ante)
                    G.hand_text_area.ante.config.object:update_text(true)
                end

                -- Provide Antimatter and Crystal Ball silently
                G.GAME.used_vouchers.v_antimatter = true
                G.GAME.used_vouchers.v_crystal_ball = true
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1

                -- Randomize hand levels between 1 and 10
                for k, v in pairs(G.GAME.hands) do
                    v.level = math.random(1, 10)
                    v.mult = math.max(1, v.mult + (v.l_mult * (v.level - 1)))
                    v.chips = math.max(1, v.chips + (v.l_chips * (v.level - 1)))
                end

                -- Generate Starting Cards
                -- 3 Common Jokers
                for i = 1, 3 do
                    local card = create_card('Joker', G.jokers, nil, 'Common', nil, nil, nil, 'reverse_deck')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end

                -- 2 Uncommon Jokers
                for i = 1, 2 do
                    local card = create_card('Joker', G.jokers, nil, 'Uncommon', nil, nil, nil, 'reverse_deck')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end

                -- 1 Rare Joker (with slight chance for Legendary)
                local legendary = pseudorandom('reverse_deck_leg') > 0.997
                local rare_card = create_card('Joker', G.jokers, legendary, legendary and 'Legendary' or 'Rare', nil, nil, nil, 'reverse_deck')
                rare_card:add_to_deck()
                G.jokers:emplace(rare_card)

                -- 2 Random Tarots
                for i = 1, 2 do
                    local tarot_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'reverse_deck')
                    tarot_card:add_to_deck()
                    G.consumeables:emplace(tarot_card)
                end

                -- 1 Random Spectral
                local spectral_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'reverse_deck')
                spectral_card:add_to_deck()
                G.consumeables:emplace(spectral_card)

                return true
            end
        }))
    end
})
