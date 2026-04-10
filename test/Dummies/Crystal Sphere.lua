Balatest.TestPlay {
    name = 'dum_crystalsphere_none_fail',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return false end)
        Balatest.play_hand { '2S' }
    end,
    assert = function()
        Balatest.assert_chips(7)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_none_success',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return true end)
        Balatest.play_hand { '2S' }
    end,
    assert = function()
        Balatest.assert_chips(7)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_unscored_fail',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return false end)
        Balatest.play_hand { '2S', '2H', 'KH' }
    end,
    assert = function()
        Balatest.assert_chips(14 * 2)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_unscored_success',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return true end)
        Balatest.play_hand { '2S', '2H', 'KH' }
    end,
    assert = function()
        Balatest.assert_chips(14 * 2)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_singlef_fail',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return false end)
        Balatest.play_hand { 'KH' }
    end,
    assert = function()
        Balatest.assert_chips(15)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_singlef_success',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return true end)
        Balatest.play_hand { 'KH' }
    end,
    assert = function()
        Balatest.assert_chips(15 + 10)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_straight_fail',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return false end)
        Balatest.play_hand { 'JH', 'TS', '9D', '8C', '7C' }
    end,
    assert = function()
        Balatest.assert_chips(74 * 4)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_straight_success',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return true end)
        Balatest.play_hand { 'JH', 'TS', '9D', '8C', '7C' }
    end,
    assert = function()
        Balatest.assert_chips((30 + 44 + 44) * 4)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_parei_fail',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere', 'j_pareidolia' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return false end)
        Balatest.play_hand { '2S' }
    end,
    assert = function()
        Balatest.assert_chips(7)
    end
}

Balatest.TestPlay {
    name = 'dum_crystalsphere_parei_success',
    category = { 'dum', 'dum_crystalsphere' },

    jokers = { 'j_worm_dum_crystalsphere', 'j_pareidolia' },
    execute = function()
        Balatest.hook(SMODS, "pseudorandom_probability", function(card, append, num, denum) return true end)
        Balatest.play_hand { '2S' }
    end,
    assert = function()
        Balatest.assert_chips(7 + 2)
    end
}