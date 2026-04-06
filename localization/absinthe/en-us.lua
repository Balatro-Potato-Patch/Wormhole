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
                        "When {C:attention}primed{}, upgrade", 
                        "the level of next played",
                        "poker hand, then is {C:abs_drinks}drank{}",
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
                        "When {C:attention}primed{}, upgrade", 
                        "the level of next played",
                        "poker hand, then is {C:abs_drinks}drank{}",
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
            c_worm_abs_meteor_sour = {
                name = 'Meteor Sour',
                text = {
                    {
                        "When {C:attention}primed{}, {C:blue}+#1#{} Hand for this",
                        "Blind if next played poker hand is",
                        "your {C:attention}most played{}, then is {C:abs_drinks}drank{}",
                        '{C:inactive}(Currently {C:attention}#2#{C:inactive})'
                    },
                    {
                        "{C:abs_drinks}Refill{} by discarding",
                        "{C:attention}#4#{} {C:enhanced}Enhanced cards{}",
                        "{C:inactive,s:0.8}(#3#/#4#){}",
                    }
                }
            },
            c_worm_abs_meteor_sour_empty = {
                name = 'Meteor Sour',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by discarding",
                        "{C:attention}#4#{} {C:enhanced}Enhanced cards{}",
                        "{C:inactive,s:0.8}(#3#/#4#){}",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed{}, {C:blue}+#1#{} Hand for this",
                        "Blind if next played poker hand is",
                        "your {C:attention}most played{}, then is {C:abs_drinks}drank{}",
                        '{C:inactive}(Currently {C:attention}#2#{C:inactive})'
                    }
                }
            },
            c_worm_abs_cosmospolitan = {
                name = 'Cosmospolitan',
                text = {
                    {
                        "When {C:attention}primed{} and {C:attention}setting Blind{},",
                        "create a random card from",
                        "{V:1}#1#{}, then is {C:abs_drinks}drank{}",
                        "{C:inactive}(Must have space!)",
                    },
                    {
                        "{C:abs_drinks}Refill{} by using {C:attention}#3#{} {C:planet}Planet{} cards",
                        "{C:inactive,s:0.8}(#2#/#3#){}",
                    }
                }
            },
            c_worm_abs_cosmospolitan_empty = {
                name = 'Cosmospolitan',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by using {C:attention}#3#{} {C:planet}Planet{} cards",
                        "{C:inactive,s:0.8}(#2#/#3#){}",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed{} and {C:attention}setting Blind{},",
                        "create a random card from",
                        "{V:1}#1#{}, then is {C:abs_drinks}drank{}",
                        "{C:inactive}(Must have space!)",
                    }
                }
            },
            c_worm_abs_voidka = {
                name = 'Voidka',
                text = {
                    {
                        "When {C:attention}primed{}, destroy first",
                        "scoring card in next",
                        "played hand, then is {C:abs_drinks}drank{}",
                    },
                    {
                        "{C:abs_drinks}Refill{} by spending {C:money}$#1#{}",
                        "{C:inactive,s:0.8}($#2#/$#1#){}",
                    }
                }
            },
            c_worm_abs_voidka_empty = {
                name = 'Voidka',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by spending {C:money}$#1#{}",
                        "{C:inactive,s:0.8}($#2#/$#1#){}",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed{}, destroy first",
                        "scoring card in next",
                        "played hand, then is {C:abs_drinks}drank{}",
                    }
                }
            },
            c_worm_abs_big_bang_brandy = {
                name = 'Big Bang Brandy',
                text = {
                    {
                        "When {C:attention}primed{}, create a",
                        "{C:spectral}Spectral{} card when next",
                        "hand is played, then is {C:abs_drinks}drank{}",
                        "{C:inactive}(Must have space!)",
                    },
                    {
                        "{C:abs_drinks}Refill{} by skipping",
                        "a {C:attention}Booster Pack{}",
                    }
                }
            },
            c_worm_abs_big_bang_brandy_empty = {
                name = 'Big Bang Brandy',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by skipping",
                        "a {C:attention}Booster Pack{}",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed{}, create a",
                        "{C:spectral}Spectral{} card when next",
                        "hand is played, then is {C:abs_drinks}drank{}",
                        "{C:inactive}(Must have space!)",
                    }
                }
            },
            c_worm_abs_absinthe = {
                name = 'Absinthe (WIP)',
                text = {
                    {
                        "When {C:attention}Blind{} is selected,",
                        "if this drink is {C:attention}not {C:abs_drink}empty{},",
                        "create a {C:dark_edition}Negative{C:abs_drink} Drink{}",
                    },
                    {
                        "If this drink is {C:attention}not {C:abs_drink}empty{},",
                        "when a {C:dark_edition}Negative{C:abs_drink} Drink{} is",
                        "{C:abs_drinks}drank{}, this drink gains", 
                        "{X:mult,C:white}X#1#{} Mult and is {C:abs_drinks}drank{}",
                        "{C:inactive}(Currently {{X:mult,C:white}X#2#{C:inactive} Mult)",
                    },
                    {
                        "{C:abs_drinks}Refill{} by using",
                        "a {C:spectral}Spectral{} card",
                    }
                }
            },
            c_worm_abs_absinthe_empty = {
                name = 'Absinthe (WIP)',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by using",
                        "a {C:spectral}Spectral{} card",
                    },
                    {
                        "{C:inactive}(Currently {{X:mult,C:white}X#2#{C:inactive} Mult)",
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "If this drink is {C:attention}not {C:abs_drink}empty{},",
                        "when a {C:dark_edition}Negative{C:abs_drink} Drink{} is",
                        "{C:abs_drinks}drank{}, this drink gains", 
                        "{X:mult,C:white}X#1#{} Mult and is {C:abs_drinks}drank{}",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}Blind{} is selected,",
                        "if this drink is {C:attention}not {C:abs_drink}empty{},",
                        "create a {C:dark_edition}Negative{C:abs_drink} Drink{}",
                    }
                }
            },
            c_worm_abs_spacewalk_selzer = {
                name = 'Spacewalk Seltzer',
                text = {
                    {
                        "When {C:attention}primed{}, {C:attention}retriggers",
                        "each played card {C:attention}#1#{} time,",
                        "then is {C:abs_drinks}drank{}",
                    },
                    {
                        "{C:abs_drinks}Refill{} by {C:red}destroying",
                        "1 {C:attention}Playing Card{}",
                    }
                }
            },
            c_worm_abs_spacewalk_selzer_empty = {
                name = 'Spacewalk Seltzer',
                text = {
                    {
                        "{C:inactive,s:0.8}Currently Empty{}",
                        "{C:abs_drinks}Refill{} by {C:red}destroying",
                        "1 {C:attention}Playing Card{}",
                    },
                    {
                        "{C:inactive,s:0.8}After being Refilled:{}",
                        "When {C:attention}primed{}, {C:attention}retriggers",
                        "each played card {C:attention}#1#{} time,",
                        "then is {C:abs_drinks}drank{}",
                    }
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
            j_worm_abs_seeing_stars = {
                name = 'Seeing Stars',
                text = {
                    "{C:attention}+#2#{} Consumable Slot",
                    "Earn {C:money}$#1#{} when a",
                    "{C:abs_drinks}Drink{} is {C:abs_drinks}Refilled{}",
                }
            },
            j_worm_abs_water_world = {
                name = 'Water World',
                text = {
                    "{C:attention}+#1#{} Consumable Slots",
                    "This Joker occupies",
                    "{C:red}#2#{} Joker Slots",
                }
            },
            j_worm_abs_gravity_well = {
                name = "Gravity Well",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "when a {C:abs_drinks}Drink{} is {C:abs_drinks}drank{}",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_worm_abs_binary_system = {
                name = 'Binary System',
                text = {
                    "{C:abs_drinks}Refill{} and {C:attention}copy{} a random owned", 
                    "{C:abs_drinks}Drink{} if played poker hand is",
                    "a {C:attention}Straight Flush{} or better",
                    "{C:red,E:2}self destructs{}",
                    "{C:inactive}(Must have space!)",

                }
            },
            j_worm_abs_glass_storm = {
                name = 'Glass Storm',
                text = {
                    "{C:attention}#1#{} random cards remaining",
                    "in deck become {C:attention}Glass Cards{}", 
                    "when an {C:attention}Empty {C:abs_drinks}Drink{} is {C:attention}sold{}",

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
        Voucher = {
            v_worm_abs_star_tap = {
                name = 'Star Tap',
                text = {
                    '{C:abs_drinks}Drinks{} can now',
                    'appear in the {C:attention}Shop'
                }
            },
            v_worm_abs_on_the_house = {
                name = 'On The House',
                text = {
                    '{C:abs_drinks}Drinks{} in the {C:attention}Shop',
                    'are {C:money}free'
                }
            },
        },
        PotatoPatch = {
            PotatoPatchDev_pangaea47 = {
                name = 'pangaea47',
                text = { {
                    'Nothing much to say about myself, but you can',
                    'call me {E:2,C:planet}Argel{} instead of Pangaea. I\'m a spider.',
                }, {
                    'I\'m also a spriter who is at fault for a lot of things,',
                    'but mainly pulling up this absolute juggernaut of a team',
                    'and I can\'t say how much I\'m thankful to everyone who',
                    'worked on our {s:1.2,C:absinthe}pint{} of the Jam.',
                    '{s:0.5,C:inactive}(big chance for something in the future involving us){}',
                }, {
                    'I\'ve also made the logo for this {C:edition,E:1}event{}, the logo for ', --(possibly redact this part if its not true i really do think the logo is awesome and it will be accepted :pleading_face:)
                    'our team {C:absinthe,E:1}absinthe{}, and a bunch of sprites for our part.',
                    'I show a lot of gratitude for being able to play our ',
                    'droplet on this ocean of content, it really means a lot.',
                }
                }
            },
            PotatoPatchDev_AstraLuna = {
                name = 'AstraLuna',
                text = { {
                    'Heyo!!! The name\'s {E:2,C:green}Luna{} and I exist here!',
                    'I\'m one of the artists for this team! I made quite',
                    'a few of the Jokers and am mildly proud of my work here.',
                    'Usually I\'d be the main coder, but with the scope of this Jam',
                    'and the stacked team we have, I left most of it to the others lmao.',
                }, {
                    "I\'m super grateful to my two dev partners base4 and Annebean for joining",
                    "me on this team, helping out and doing god's work out here.",
                    "It was an amazing experience refining this concept and",
                    "putting it out there for yall, and Id love to work with this group again.",
                },{
                    "Good luck!",
                    "Dont die!",
                    "Dont let the breadbugs bite."
                }
                }
            },
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
            k_glass = "Glass",
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
