Balatest.TestPlay {
    name = 'dum_greg_cannot_sell',
    category = { 'dum', 'dum_greg' },

    jokers = { 'j_worm_dum_greg' },

    execute = function()
        --Balatest.sell(function() return G.jokers.cards[1] end)
    end,
    assert = function()
        local i, greg = next(SMODS.find_card("j_worm_dum_greg"))
        
        Balatest.assert(greg ~= nil, "No greg")
        Balatest.assert(greg:can_sell_card() == false,"Can be sold")
        
    end
}

Balatest.TestPlay {
    name = 'dum_greg_dagger',
    category = { 'dum', 'dum_greg' },

    jokers = { 'j_ceremonial', 'j_worm_dum_greg' },

    execute = function()
        --Balatest.sell(function() return G.jokers.cards[1] end)
    end,
    assert = function()
        local i, greg = next(SMODS.find_card("j_worm_dum_greg"))
        
        Balatest.assert(greg == nil, "Yes greg")
      
    end
}

Balatest.TestPlay {
    name = 'dum_greg_madness',
    category = { 'dum', 'dum_greg' },

    jokers = { 'j_madness', 'j_worm_dum_greg' },

    execute = function()
        --Balatest.sell(function() return G.jokers.cards[1] end)
    end,
    assert = function()
        local i, greg = next(SMODS.find_card("j_worm_dum_greg"))
        
        Balatest.assert(greg == nil, "Yes greg")
      
    end
}


Balatest.TestPlay {
    name = 'dum_greg_high_five_splash',
    category = { 'dum', 'dum_greg' },

    jokers = { 'j_worm_dum_greg', 'j_splash' },
    execute = function()
        Balatest.play_hand { '2S', '3S', '4S', '5S', '7H' }
        Balatest.end_round()
    end,
    assert = function()
        local found_edition = false
        for index, value in ipairs(G.deck.cards) do
            if value.base.nominal == 7 and value.base.suit == 'Hearts' then
                Balatest.assert(false, "No card deleted")
            end
            if value.base.nominal == 2 and value.base.suit == 'Spades' then
                found_edition = true
                
            end
            Balatest.assert(found_edition, "No card deleted")
        end
    end
}
