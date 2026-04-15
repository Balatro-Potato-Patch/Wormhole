return {
    descriptions = {
        Joker = {
            j_worm_stew_stew_earth = {
                name = "Stew Earth",
                text = {
                    '{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X#2#{} Mult',
                    ' if score {C:attention}catches fire{},',
                    'otherwise loses {X:mult,C:white}X#3#{} Mult'
                },
            },

            j_worm_stew_flat_earth = {
                name = 'Flat Earth',
                text = {
                    "{C:chips}+#2#{} Chips for each",
                    "non-{C:spades}Spade{} card",
                    "in your {C:attention}full deck{}",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                } 
            },

            j_worm_stew_dinosaur_earth = {
                name = 'Dinosaur Earth',
                text = {
                    '{C:green}#1# in #2#{} chance for',
                    '{C:attention}-#4#{} Ante and for all',
                    'Dinosaur Earths to go',
                    '{C:red,E:2}extinct{} at end of round'
                }
            },

            j_worm_stew_dinosaur_earth_alt = {
                name = 'Dinosaur Earth',
                text = {
                    '{s:2,E:1,C:red}Extinct!'
                }
            },

            j_worm_stew_impact_crater = {
                name = 'Impact Crater',
                text = {
                    '{C:green}#2# in #3#{} chance to create',
                    'a {C:attention,T:tag_meteor}#1#',
                    'at the end of the {C:attention}shop{}'
                    }
            },

            j_worm_stew_staged_landing = {
                name = 'Staged Landing',
                text = {
                    'This Joker gains {C:mult}+#2#{} Mult',
                    'for every {C:clubs}Club{} card',
                    'discarded this round',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
                }
            },

            j_worm_stew_stardust = {
                name = 'Stardust',
                text = {
                    'This Joker gains {C:money}$#1#{} of',
                    '{C:attention}sell value{} for every {C:attention}#2#{C:inactive} [#3#]',
                    'scoring {C:diamonds}Diamond{} cards played'
                }
            },

            j_worm_stew_8_ball_earth = {
                name = '8 Ball Earth',
                text = {
                    '{C:attention}Fill{} consumable slots with random',
                    '{C:tarot}Tarot{}, {C:planet}Planet{}, or {C:inactive,s:0.8}(rarely){} {C:spectral}Spectral',
                    'cards if played hand',
                    'contains a {C:attention}#1#',
                    '{C:inactive}(Must have room)'
                }
            },

            j_worm_stew_stargazer = {
                name = 'Stargazer',
                text = {
                    'Gives {X:mult,C:white}X#1#{} Mult for each',
                    '{C:planet}Planet{} or {C:attention}Star{} card held',
                    '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)'
                }
            },

            j_worm_stew_geocentrism = {
                name = 'Geocentrism',
                text = {
                    "Played cards with",
                    "{C:hearts}Heart{} suit give",
                    "{X:mult,C:white} X#1# {} Mult when scored",
                }
            },

            j_worm_stew_astrologer = {
                name = 'Astrologer',
                text = {
                    "Creates a random {C:planet}Planet{}",
                    "when a {C:tarot}Tarot{} card is used",
                    "{C:inactive}(Must have room)",
                }
            },

            j_worm_stew_cheese_moon = {
                name = 'Cheese Moon',
                text = {
                    '{C:green}#2# in #3#{} chance to destroy',
                    'the {C:attention}last{} card used in scoring',
                    'for the next {C:attention}#1#{} hands'
                }
            },

            j_worm_stew_chicken_egg = {
                name = 'Paradox Earth',
                text = {
                    '{C:chips}+Chips{} equal to double the',
                    'amount of {C:chips}Chips{} when triggered',
                }
            },

            j_worm_stew_chicken_egg_alt = {
                name = 'Paradox Earth',
                text = {
                    "{X:chips,C:white}X#1#{} Chips"
                }
            },

            j_worm_stew_capitalism = {
                name = 'Uncorrupted Joker',
                text = {
                    "{C:chips}+#2#{} Chips for every {C:money}$#3#{}",
                    "below the interest cap",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                    " {s:0.8,C:inactive}-------",
                    "{s:0.8,C:inactive}\"I am escaping to the",
                    "{s:0.8,C:inactive}one place that hasn't",
                    "{s:0.8,C:inactive}been corrupted by capitalism!\"",
                }
            },

            j_worm_stew_sputnik = {
                name = 'Space Probe',
                text = {
                    "{C:inactive}[Receiving transmission...]"
                }
            },

            j_worm_stew_starfish_earth = {
                name = 'Ocean Earthfish',
                text = {
                    "Earn {C:money}$#1#{} for every",
                    "{C:money}$#2#{} that you have",
                    'at end of round'
                }
            },

        },

        Tarot = {
            c_worm_stew_orbit = {
                name = "The Orbit",
                text = {
                    "Earn {C:money}$#1#{} per",
                    "poker hand {C:attention}level{} above {C:attention}1{}",
                    "{C:inactive}(Max of {C:money}$#2#{C:inactive})",
                    '{C:inactive}(Currently {C:money}$#3#{C:inactive})'
                },
           },
        },

        Spectral = {
            c_worm_stew_solar_flare = {
                name = "Solar Flare",
                text = {
                    "{C:attention}Debuff{} all cards in hand",
                    "Level up a random poker hand",
                    "for {C:attention}each{} card debuffed",
                },
           },
        },


        Edition = {
            e_worm_stew_stellar = {
                name = "Stellar",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "upgrade level of",
                    "played {C:attention}poker hand{}"
                },
            }
        },

        Tag = {
            tag_worm_stew_stellar = {
                name = "Stellar Tag",
                text = {
                    "Next base edition shop",
                    "Joker is free and",
                    "becomes {C:dark_edition}Stellar",
                },
           },
        },

        Blind = {
            bl_worm_stew_pull = {
                name = "The Pull",
                text = {
                    "Increases in size",
                    "per round played",
                    "this Ante",
                },
           },
        },

        PotatoPatch = {
            stew = {
                name = "Balatro Stewniversity"
            },
            stupxd = {
                name = "stupxd",
                text = {
                    "Play {C:red}Balatro{}, I heard",
                    "it's a great game!",
                }
            },
            PLagger = {
                name = "PLagger",
                text = {
                    "Shout out {C:money}Cheese{C:green}Pear{} and {C:green}Phrog{}, you two are",
                    'the {s:2,E:1,C:attention}GOAT{s:0.8,C:inactive}Lybear Lybear{}',
                    '',
                    'Also Ado nation rise up'
                }
            },
            dottykitty = {
                name = "dottykitty",
                text = {
                    "\"Some fall for eternal sleep",
                    "Their eulogies turn into gleaming stars\"",
                    "{s:0.4} ",
                    "{s:0.6,C:stew_inactive_lighter}if you recognise the lyrics no you don't",
                }
            },
            Wingcap = {
                name = "Wingcap",
                text = {
                    "Did you know you can",
                    "play RuneScape on your",
                    "phone as well as your",
                    "second monitor?",
                }
            },
            tuzzo = {
                name = "tuzzo",
                text = {
                    "This stew is new to me,",
                    "but I am honored to be a part of it",
                }
            },
            HonuKane = {
                name = "HonuKane",
                text = {
                    "womp womp",
                }
            },
            harmonywoods = {
                name = "harmonywoods",
                text = {
                    "womp womp",
                }
            },
        },
    },
    misc = {
        dictionary = {
            k_worm_stew_dinos_extinct = 'Extinct',
            k_worm_stew_yum = 'Yum!',
            k_worm_stew_cook = 'Let Him Cook!',
            k_worm_stew_uncook = 'Stove\'s Off...',
        },
        labels = {
            worm_stew_stellar = 'Stellar'
        },
        achievement_names = {
            ach_worm_stew_spaced_joker = 'Spaced Joker',
            ach_worm_stew_extinction_event = 'Extinction Event',
            ach_worm_stew_true_communist = 'True Communist',
            ach_worm_stew_perpetual_stew = 'Perpetual Stew',
        },
        achievement_descriptions = {
            ach_worm_stew_spaced_joker = 'Have a Space Joker with the Stellar edition',
            ach_worm_stew_extinction_event = 'Force an extinction event',
            ach_worm_stew_true_communist = 'Have Uncorrupted Joker give +750 or more Chips',
            ach_worm_stew_perpetual_stew = 'Have Stew Earth give X10 or more Mult',
        }
        

    },
}