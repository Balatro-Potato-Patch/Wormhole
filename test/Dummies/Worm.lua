Balatest.TestPlay {
    name = 'dum_worm_eat_free',
    category = { 'dum', 'dum_worm' },

    jokers = { 'j_worm_dum_worm' },

    execute = function()
        Balatest.end_round()
        Balatest.cash_out()
    end,
    assert = function()
        for index, value in ipairs(G.shop_booster.cards) do
            Balatest.assert(value.ability.couponed, "Not free") 
        end
    end
}

Balatest.TestPlay {
    name = 'dum_worm_eat_count',
    category = { 'dum', 'dum_worm' },

    jokers = { 'j_worm_dum_worm' },

    execute = function()
        Balatest.hook(_G, 'get_pack', function() return { key = 'p_buffoon_normal_1' } end)
        Balatest.hook(_G, 'create_card', function(orig, set, a, l, r, k, s, f, ...)
            return set == 'Joker' and orig(set, a, l, r, k, s, 'j_joker', ...) or orig(set, a, l, r, k, s, f, ...)
        end)
        Balatest.hook(_G, 'poll_edition', function() end)
        Balatest.end_round()
        Balatest.cash_out()
        Balatest.use(function() return G.shop_booster.cards[1] end)
        Balatest.use(function() return G.pack_cards.cards[1] end)
    end,
    assert = function()
        Balatest.assert(#G.shop_booster.cards < 1, "Boosters still left")
    end
}
