Balatest.TestPlay {
    name = 'dum_test_flight_big_score',
    category = { 'dum', 'dum_test_flight' },

    no_auto_start = true,
    jokers = { 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil',
                'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil',
                'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil',
                'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil',
                'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil', 'j_stencil',
                },
    execute = function()
        Balatest.start_round("bl_worm_dum_dummy_blind")
        Balatest.play_hand { '2S' } 
    end,
    assert = function()
    end
}
