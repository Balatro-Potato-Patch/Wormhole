Balatest.TestPlay {
    name = 'dum_gleebleglorp_all_level_one_hc',
    category = { 'dum', 'dum_gleebleglorp' },

    jokers = { 'j_worm_dum_gleebleglorp' },
    execute = function()
        Balatest.play_hand { '2S' }
    end,
    assert = function()
        Balatest.assert_chips(7 * 2)
    end
}

Balatest.TestPlay {
    name = 'dum_gleebleglorp_all_level_one_fh',
    category = { 'dum', 'dum_gleebleglorp' },

    jokers = { 'j_worm_dum_gleebleglorp' },
    execute = function()
        Balatest.play_hand { '2S', '2H', '2D', '3S', '3H' }
    end,
    assert = function()
        Balatest.assert_chips(52 * 4 * 2)
    end
}

Balatest.TestPlay {
    name = 'dum_gleebleglorp_hc_level_two_hc',
    category = { 'dum', 'dum_gleebleglorp' },

    jokers = { 'j_worm_dum_gleebleglorp' },
    execute = function()
        SMODS.upgrade_poker_hands({ hands = "High Card" })
        Balatest.play_hand { '2S' }
    end,
    assert = function()
        Balatest.assert_chips(17 * 2)
    end
}

Balatest.TestPlay {
    name = 'dum_gleebleglorp_hc_level_two_fh',
    category = { 'dum', 'dum_gleebleglorp' },

    jokers = { 'j_worm_dum_gleebleglorp' },
    execute = function()
        SMODS.upgrade_poker_hands({ hands = "High Card" })
        Balatest.play_hand { '2S', '2H', '2D', '3S', '3H' }
    end,
    assert = function()
        Balatest.assert_chips(52 * 4 * 2)
    end
}

Balatest.TestPlay {
    name = 'dum_gleebleglorp_fh_level_two_hc',
    category = { 'dum', 'dum_gleebleglorp' },

    jokers = { 'j_worm_dum_gleebleglorp' },
    execute = function()
        SMODS.upgrade_poker_hands({ hands = "Full House" })
        Balatest.play_hand { '2S' }
    end,
    assert = function()
        Balatest.assert_chips(7 * 2)
    end
}

Balatest.TestPlay {
    name = 'dum_gleebleglorp_fh_level_two_fh',
    category = { 'dum', 'dum_gleebleglorp' },

    jokers = { 'j_worm_dum_gleebleglorp' },
    execute = function()
        SMODS.upgrade_poker_hands({ hands = "Full House" })
        Balatest.play_hand { '2S', '2H', '2D', '3S', '3H' }
    end,
    assert = function()
        Balatest.assert_chips(77 * 6)
    end
}