return {
    descriptions = {
        abs_drinks = {
            c_worm_abs_supergiant_cider = {
                name = 'Supergiant Cider',
                text = {
                    {
                        "{C:red}+#1#{} Discard when hand,",
                        "is drawn, then is {C:gold}drank{}",
                    },
                    {
                        "{C:gold}Refill{} by playing a",
                        "{C:attention}#2#{} or better",
                    }
                }
            },
            c_worm_abs_supergiant_cider_empty = {
                name = 'Supergiant Cider',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:gold}Refill{} by playing a",
                        "{C:attention}#2#{} or better",
                    },
                    {
                        "{C:inactive,s:0.8}After being filled:{}",
                        "{C:red}+#1#{} Discard when hand,",
                        "is drawn, then is {C:gold}drank{}",
                    }
                }
            },
        },
        Jokers = {

        },
        Other = {
            p_worm_abs_top_shelf_jumbo_1 = {
                name = 'Jumbo Top Shelf Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:abs_drink} Drinks{} to",
                    "be used immediately",
                },
            },
            p_worm_abs_top_shelf_mega_1 = {
                name = 'Mega Top Shelf Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:abs_drink} Drinks{} to",
                    "be used immediately",
                },
            },
            p_worm_abs_top_shelf_normal_1 = {
                name = 'Top Shelf Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:abs_drink} Drinks{} to",
                    "be used immediately",
                },
            },
            p_worm_abs_top_shelf_normal_2 = {
                name = 'Top Shelf Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:abs_drink} Drinks{} to",
                    "be used immediately",
                },
            },
        }
    },
    misc = {
        dictionary = {
            b_abs_drinks_cards = "Drinks",
            k_abs_drinks = 'Drinks',
            k_worm_abs_emptied_ex = 'Emptied!',
            k_worm_abs_refilled_ex = 'Refilled!',
            k_worm_abs_top_shelf_pack = 'Top Shelf Pack'
        },
        v_dictionary={
            a_discards="+#1# Discards",
        },
    }
}
