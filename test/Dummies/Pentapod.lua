Balatest.TestPlay {
    name = 'dum_pentapod_high',
    category = { 'dum', 'dum_pentapod' },

    jokers = { 'j_worm_dum_pentapod' },
    execute = function()
        Balatest.play_hand { '2S' }
    end,
    assert = function()
        Balatest.assert_chips(7)
    end
}

Balatest.TestPlay {
    name = 'dum_pentapod_high_five',
    category = { 'dum', 'dum_pentapod' },

    jokers = { 'j_worm_dum_pentapod' },
    execute = function()
        Balatest.play_hand { '2S', '3S', '4S', '5S', '7H' }
    end,
    assert = function()
        Balatest.assert_chips(12)
    end
}

Balatest.TestPlay {
    name = 'dum_pentapod_high_five_splash',
    category = { 'dum', 'dum_pentapod' },

    jokers = { 'j_worm_dum_pentapod', 'j_splash' },
    execute = function()
        Balatest.play_hand { '2S', '3S', '4S', '5S', '7H' }
    end,
    assert = function()
        Balatest.assert_chips(26 * 5)
    end
}

Balatest.TestPlay {
    name = 'dum_pentapod_two_pair_plus_one',
    category = { 'dum', 'dum_pentapod' },

    jokers = { 'j_worm_dum_pentapod' },
    execute = function()
        Balatest.play_hand { '2S', '2H', '3S', '3H', '4S' }
    end,
    assert = function()
        Balatest.assert_chips(30 * 2)
    end
}

Balatest.TestPlay {
    name = 'dum_pentapod_two_pair_plus_one_splash',
    category = { 'dum', 'dum_pentapod' },

    jokers = { 'j_worm_dum_pentapod', 'j_splash' },
    execute = function()
        Balatest.play_hand { '2S', '2H', '3S', '3H', '4S' }
    end,
    assert = function()
        Balatest.assert_chips(34 * 10)
    end
}

Balatest.TestPlay {
    name = 'dum_pentapod_full_house',
    category = { 'dum', 'dum_pentapod' },

    jokers = { 'j_worm_dum_pentapod' },
    execute = function()
        Balatest.play_hand { '2S', '2H', '3S', '3H', '2C' }
    end,
    assert = function()
        Balatest.assert_chips(52 * 20)
    end
}