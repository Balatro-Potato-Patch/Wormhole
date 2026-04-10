Balatest.TestPlay {
    name = 'dum_carnivore_eat_greg',
    category = { 'dum', 'dum_carnivore' },

    jokers = { 'j_worm_dum_carnivore', 'j_worm_dum_greg' },
    assert = function()
        Balatest.assert(#G.jokers.cards<2, "Joker amount didnt decrease")

        local i, carnivore = next(SMODS.find_card("j_worm_dum_carnivore"))
    
        Balatest.assert(carnivore ~= nil, "No carnivore")
        Balatest.assert(carnivore.ability.extra.xmult > 1.0, "Value didnt increase, no alien attribute")
        Balatest.assert(carnivore.ability.extra.chips > 1.0, "Value didnt increase, no fish attribute")
        
        
    end
}

Balatest.TestPlay {
    name = 'dum_carnivore_eat_alien_polled',
    category = { 'dum', 'dum_carnivore' },

    no_auto_start = true,
    jokers = { 'j_worm_dum_carnivore' },
    execute = function()
        SMODS.add_card({ key = pseudorandom_element(SMODS.get_attribute_pool("alien"), "test_dum_carnivore_eat_alien_polled") })
        --Balatest.exit_shop()
        Balatest.start_round()
    end,
    assert = function()
        Balatest.assert(#G.jokers.cards<2)
    end
}

Balatest.TestPlay {
    name = 'dum_carnivore_not_eatable',
    category = { 'dum', 'dum_carnivore' },

    jokers = { 'j_worm_dum_carnivore', 'j_glass' },

    assert = function()
        Balatest.assert_eq(#G.jokers.cards, 2)
    end
}

