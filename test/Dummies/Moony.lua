local function use_moony_for(hand, card)
    local done = false
    Balatest.hook(G.FUNCS, 'worm_run_moony_menu', function(orig, ...)
        orig(...)
        G.GAME.worm_moony_selection = hand and { selection = hand } or nil
        G.FUNCS.exit_overlay_menu()
        G.SETTINGS.paused = false
    end)
    Balatest.q(function()
        G.FUNCS.use_card { config = { ref_table = card } }
    end)
    Balatest.wait()
end

Balatest.TestPlay {
    name = 'dum_moony_high_card',
    category = { 'dum', 'dum_moony' },

    consumables = { "c_worm_dum_moony" },
    execute = function()
        use_moony_for('High Card', G.consumeables.cards[1])
    end,
    assert = function()
        Balatest.assert_eq(G.GAME.hands['High Card'].level, 2)
        local sum = 0
        for _, v in pairs(G.GAME.hands) do
            sum = sum + v.level - 1
        end
        Balatest.assert_eq(sum, 1)
    end
}
Balatest.TestPlay {
    name = 'dum_moony_straight',
    category = { 'dum', 'dum_moony' },

    consumables = { "c_worm_dum_moony" },
    execute = function()
        use_moony_for('Straight', G.consumeables.cards[1])
    end,
    assert = function()
        Balatest.assert_eq(G.GAME.hands.Straight.level, 2)
        local sum = 0
        for _, v in pairs(G.GAME.hands) do
            sum = sum + v.level - 1
        end
        Balatest.assert_eq(sum, 1)
    end
}
Balatest.TestPlay {
    name = 'dum_moony_none',
    category = { 'dum', 'dum_moony' },

    consumables = { "c_worm_dum_moony" },
    execute = function()
        use_moony_for(nil, G.consumeables.cards[1])
    end,
    assert = function()
        for _, v in pairs(G.GAME.hands) do
            Balatest.assert_eq(v.level, 1)
        end
    end
}
