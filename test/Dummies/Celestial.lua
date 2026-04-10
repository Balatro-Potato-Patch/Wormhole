Balatest.TestPlay {
    name = 'dum_celestial_triggers',
    category = { 'dum', 'dum_celestial' },

    jokers = { { id = 'j_joker', edition = 'worm_dum_Celestial' } },
    consumables = { 'c_pluto' },
    execute = function()
        Balatest.hook(_G, 'pseudorandom', function(orig, ...)
            return 0
        end)
        Balatest.use(G.consumeables.cards[1])
    end,
    assert = function()
        local sum = 0
        for _, v in pairs(G.GAME.hands) do
            sum = sum + v.level - 1
        end
        Balatest.assert_eq(sum, 2)
    end
}

Balatest.TestPlay {
    name = 'dum_celestial_triggers_twice',
    category = { 'dum', 'dum_celestial' },

    jokers = { { id = 'j_joker', edition = 'worm_dum_Celestial' } },
    consumables = { 'c_pluto', 'c_pluto' },
    execute = function()
        Balatest.hook(_G, 'pseudorandom', function(orig, ...)
            return 0
        end)
        Balatest.use(G.consumeables.cards[1])
        Balatest.use(G.consumeables.cards[2])
    end,
    assert = function()
        local sum = 0
        for _, v in pairs(G.GAME.hands) do
            sum = sum + v.level - 1
        end
        Balatest.assert_eq(sum, 4)
    end
}

Balatest.TestPlay {
    name = 'dum_celestial_tarot',
    category = { 'dum', 'dum_celestial' },

    jokers = { { id = 'j_joker', edition = 'worm_dum_Celestial' } },
    consumables = { 'c_temperance' },
    execute = function()
        Balatest.hook(_G, 'pseudorandom', function(orig, ...)
            return 0
        end)
        Balatest.use(G.consumeables.cards[1])
    end,
    assert = function()
        local sum = 0
        for _, v in pairs(G.GAME.hands) do
            sum = sum + v.level - 1
        end
        Balatest.assert_eq(sum, 0)
    end
}

Balatest.TestPlay {
    name = 'dum_celestial_oops',
    category = { 'dum', 'dum_celestial' },

    jokers = {
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        'j_oops' },
    consumables = { 'c_pluto' },
    execute = function()
        Balatest.use(G.consumeables.cards[1])
    end,
    assert = function()
        local sum = 0
        for _, v in pairs(G.GAME.hands) do
            sum = sum + v.level - 1
        end
        Balatest.assert_eq(sum, 5)
    end
}

Balatest.TestPlay {
    name = 'dum_celestial_fails',
    category = { 'dum', 'dum_celestial' },

    jokers = {
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' } },
    consumables = { 'c_pluto' },
    execute = function()
        Balatest.hook(_G, 'pseudorandom', function(orig, ...)
            return 1
        end)
        Balatest.use(G.consumeables.cards[1])
    end,
    assert = function()
        local sum = 0
        for _, v in pairs(G.GAME.hands) do
            sum = sum + v.level - 1
        end
        Balatest.assert_eq(sum, 1)
    end
}

Balatest.TestPlay {
    name = 'dum_celestial_visible_only',
    category = { 'dum', 'dum_celestial' },

    jokers = {
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' },
        { id = 'j_joker', edition = 'worm_dum_Celestial' } },
    consumables = { 'c_pluto', 'c_pluto', 'c_pluto', 'c_pluto' },
    execute = function()
        Balatest.hook(_G, 'pseudorandom', function(orig, ...)
            return 0
        end)
        Balatest.use(G.consumeables.cards[1])
        Balatest.use(G.consumeables.cards[2])
        Balatest.use(G.consumeables.cards[3])
        Balatest.use(G.consumeables.cards[4])
    end,
    assert = function()
        local sum = 0
        for k, v in pairs(G.GAME.hands) do
            if not SMODS.is_poker_hand_visible(k) then
                Balatest.assert_eq(v.level, 1)
                sum = sum + v.level - 1
            end
        end
    end
}
