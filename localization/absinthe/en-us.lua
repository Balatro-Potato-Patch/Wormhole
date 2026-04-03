return {
    descriptions = {
        abs_drinks = {
            c_worm_abs_supergiant_cider = {
                name = 'Supergiant Cider',
                text = {
                    {
                        "When {C:attention}primed{}, {C:red}+#1#{} Discard",
                        "for this Blind, then is {C:abs_drinks}drank{}"
                    },
                    {
                        "{C:abs_drinks}Refill{} by playing a",
                        "{C:attention}#2#{} or better",
                    }
                }
            },
            c_worm_abs_supergiant_cider_empty = {
                name = 'Supergiant Cider',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by playing a",
                        "{C:attention}#2#{} or better",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed,{} {C:red}+#1#{} Discard",
                        "for this Blind, then is {C:abs_drinks}drank{}"
                    }
                }
            },
            c_worm_abs_hubble_trouble = {
                name = 'Hubble Trouble',
                text = {
                    {
                        "When {C:attention}primed{}, create the", 
                        "{C:planet}Planet{} card of next played",
                        "{C:attention}poker hand{}, then is {C:abs_drinks}drank{}",
                        "{C:inactive}(Must have space!)",
                        "{C:inactive,s:0.8}(Planet card has $0 sell value)",
                    },
                    {
                        "{C:abs_drinks}Refill{} by {C:attention}selling{}",
                        "a {C:planet}Planet{} card",
                    }
                }
            },
            c_worm_abs_hubble_trouble_empty = {
                name = 'Hubble Trouble',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by selling",
                        "a {C:planet}Planet{} card",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed{}, create the", 
                        "{C:planet}Planet{} card of next played",
                        "{C:attention}poker hand{}, then is {C:abs_drinks}drank{}",
                        "{C:inactive}(Must have space!)",
                        "{C:inactive,s:0.8}(Planet card has $0 sell value)",
                    }
                }
            },
            c_worm_abs_moonshine = {
                name = 'Moonshine',
                text = {
                    {
                        "When {C:attention}primed{}, {X:chips,C:white}X#1#{} Chips if",
                        "played hand contains a",
                        "{C:spades}Da{C:clubs}rk{} suit card, then is {C:abs_drinks}drank{}",
                    },
                    {
                        "{C:abs_drinks}Refill{} by {C:attention}scoring{}",
                        "#3# {C:diamonds}Lig{C:hearts}ht{} suit cards",
                        "{C:inactive,s:0.8}(#2#/#3#){}",
                    }
                }
            },
            c_worm_abs_moonshine_empty = {
                name = 'Moonshine',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by {C:attention}scoring{}",
                        "#3# {C:diamonds}Lig{C:hearts}ht{} suit cards",
                        "{C:inactive,s:0.8}(#2#/#3#){}",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed{}, {X:chips,C:white}X#1#{} Chips if",
                        "played hand contains a",
                        "{C:spades}Da{C:clubs}rk{} suit card, then is {C:abs_drinks}drank{}",
                    },
                }
            },
            c_worm_abs_pina_solada = {
                name = 'Pina Solada',
                text = {
                    {
                        "When {C:attention}primed{}, {X:mult,C:white}X#1#{} Mult if",
                        "played hand contains a",
                        "{C:diamonds}Lig{C:hearts}ht{} suit card, then is {C:abs_drinks}drank{}",
                    },
                    {
                        "{C:abs_drinks}Refill{} by {C:attention}scoring{}",
                        "#3# {C:spades}Da{C:clubs}rk{} suit cards",
                        "{C:inactive,s:0.8}(#2#/#3#){}",
                    }
                }
            },
            c_worm_abs_pina_solada_empty = {
                name = 'Pina Solada',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by {C:attention}scoring{}",
                        "#3# {C:spades}Da{C:clubs}rk{} suit cards",
                        "{C:inactive,s:0.8}(#2#/#3#){}",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed{}, {X:mult,C:white}X#1#{} Mult if",
                        "played hand contains a",
                        "{C:diamonds}Lig{C:hearts}ht{} suit card, then is {C:abs_drinks}drank{}",
                    },
                }
            },
        },
        Joker = {
            j_worm_abs_clg = {
                name = 'Cosmically Large Glass',
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "create an {C:attention}Empty {C:abs_drinks}Drink",
                    "{C:inactive}(Must have space!)",
                }
            },
            j_worm_abs_put_it_on_my_tab = {
                name = 'Put It On My Tab!',
                text = {
                    "{C:attention}+#2#{} Consumable Slot",
                    "Earn {C:money}$#1#{} when a",
                    "{C:abs_drinks}Drink{} is {C:abs_drinks}Refilled{}",
                }
            },
            j_worm_abs_drinkmaxxing = {
                name = {
                    'Drinkmaxxing',
                    "{C:inactive,s:0.8}someone give this joker a better name plz",
                },
                text = {
                    "{C:attention}+#1#{} Consumable Slots",
                    "This Joker occupies",
                    "{C:red}#2#{} Joker Slots",
                }
            },
            j_worm_abs_heavyweight_joker = {
                name = {
                    'Heavyweight Joker',
                    "{C:inactive,s:0.6}temp name?",
                },
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "when a {C:abs_drinks}Drink{} is {C:abs_drinks}Drank{}",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_worm_abs_binary_system = {
                name = {
                    'Binary System',
                    "{C:inactive,s:0.6}temp name?",
                },
                text = {
                    "{C:abs_drinks}Fill{} and {C:attention}copy{} a random owned", 
                    "{C:abs_drinks}Drink{} if played poker hand is",
                    "a {C:attention}Straight Flush{} or better",
                    "{C:red,E:2}self destructs{}",
                    "{C:inactive}(Must have space!)",

                }
            },
        },
        Other = {
            p_worm_abs_top_shelf_normal_1 = {
                name = 'Top Shelf Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:abs_drinks} Drinks{} to add to",
                    "your consumables",
                },
            },
            p_worm_abs_top_shelf_normal_2 = {
                name = 'Top Shelf Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:abs_drinks} Drinks{} to add to",
                    "your consumables",
                },
            },
            p_worm_abs_top_shelf_jumbo_1 = {
                name = 'Jumbo Top Shelf Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:abs_drinks} Drinks{} to add to",
                    "your consumables",
                },
            },
            p_worm_abs_top_shelf_mega_1 = {
                name = 'Mega Top Shelf Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:abs_drinks} Drinks{} to add to",
                    "your consumables",
                },
            },
            undiscovered_abs_drinks = {
                name = "Not Discovered",
                text = {
                    "Purchase this",
                    "card in an",
                    "unseeded run to",
                    "learn what it does",
                },
            },
        },
        PotatoPatch = {
            PotatoPatchDev_theAstra = {
                name = 'theAstra',
                text = { {
                    'Yo, I\'m Astra! I\'m The head of the Potato Patch',
                    'Dev Group and one of the organizers of this event!',
                    'Aside from that I created most of the backend for',
                    'the Drinks consumables as well as a few playable',
                    'objects here and there',
                }, {
                    'Thank you so much for checking out our work,',
                    'and keep an eye out for whatever thing',
                    'we decide to do next!! {f:9,s:0.6}🐟'
                }
                }
            },
            PotatoPatchDev_nixthatoneartist = {
                name = 'nixthatoneartist',
                text = { {
                    'Some call me Nix, some call me Gabriella,',
                    'but regardless, I exist, that\'s for sure.',
                    '{s:0.75}(One could say I {C:edition,E:1,s:0.75}nixist...{}{s:0.75})',
                }, {
                    '{s:0.6}i could squeak on about how technically this is my public debut{}',
                    '{s:0.6}Balatrowise cuz my own mod is taking a while but shhhh{}',
                    'Most of my contributions to team absinthe are',
                    'art-related, so I do hope everything looks swag B>'
                    -- may adjust if i end up contributing more to programming but i wasnt thinking so LOL
                    -- gabby
                }, {
                    'in any case, we really appreciate you',
                    'seeing what we brewed up for this jam,', -- ba dum tiss
                    'and hopefully you enjoy whatever we',
                    'may end up cooking in the future! :3',
                    '{s:0.5} {}',
                    '{s:0.75}jame'
                }
                }
            }
        }
    },
    misc = {
        dictionary = {
            b_abs_drinks_cards = "Drinks",
            k_abs_drinks = 'Drinks',
            k_plus_drink = '+1 Drink',
            k_worm_abs_emptied_ex = 'Emptied!',
            k_worm_abs_refilled_ex = 'Refilled!',
            k_worm_abs_top_shelf_pack = 'Top Shelf Pack'
        },
        v_dictionary = {
            a_discards = "+#1# Discards",
        },
    }
}
