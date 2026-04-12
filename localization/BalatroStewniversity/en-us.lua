return {
    descriptions = {
        Joker = {
            j_worm_stew_earth = {
                name = "Stew Earth",
                text = {
                    '{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X#2#{} Mult',
                    ' if score {C:attention}catches fire{},',
                    'otherwise loses {X:mult,C:white}X#3#{} Mult'
                },
            },

            j_worm_flat_earth = {
                name = 'Flat Earth',
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "non-{C:spades}Spade{} card",
                    "in your full deck",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                } 
            },

            j_worm_dinosaur_earth = {
                name = 'Dinosaur Earth',
                text = {
                    '{C:green}#1# in #2#{} chance for',
                    '{C:attention}-#4#{} Ante and for all',
                    'Dinosaur Earths to go',
                    '{C:red,E:2}extinct{} at end of round'
                }
            },

            j_worm_impact_crater = {
                name = 'Impact Crater',
                text = {
                    '{C:green}#2# in #3#{} chance to create',
                    'a {C:attention,T:tag_meteor}#1#',
                    'at the end of the {C:attention}shop{}'
                    }
            },

            j_worm_staged_landing = {
                name = 'Staged Landing',
                text = {
                    'This Joker gains {C:mult}+#2#{} Mult',
                    'for every {C:clubs}Club{} card',
                    'discarded this round',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
                }
            },

            j_worm_stardust_joker = {
                name = 'Stardust',
                text = {
                    'This Joker gains {C:money}$#1#{} of',
                    '{C:attention}sell value{} for every {C:attention}#2#{C:inactive} [#3#]',
                    'scoring {C:diamonds}Diamond{} cards played'
                }
            },

            j_worm_8_ball_earth = {
                name = '8 Ball Earth',
                text = {
                    '{C:attention}Fill{} consumable slots with random',
                    '{C:tarot}Tarot{}, {C:planet}Planet{}, or {C:inactive,s:0.8}(rarely){} {C:spectral}Spectral',
                    'cards if played hand',
                    'contains a {C:attention}#1#',
                    '{C:inactive}(Must have room)'
                }
            },

            j_worm_stargazer = {
                name = 'Stargazer',
                text = {
                    'Gives {X:mult,C:white}X#1#{} Mult for each',
                    '{C:planet}Planet{} or {C:attention}Star{} card held',
                    '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)'
                }
            },

            j_worm_geocentrism = {
                name = 'Geocentrism',
                text = {
                    "Played cards with",
                    "{C:hearts}Heart{} suit give",
                    "{X:mult,C:white} X#1# {} Mult when scored",
                }
            },

            j_worm_astrologer = {
                name = 'Astrologer',
                text = {
                    "Creates a random {C:planet}Planet{}",
                    "when a {C:tarot}Tarot{} card is used",
                    "{C:inactive}(Must have room)",
                }
            },

        },

        Tarot = {
            c_worm_orbit = {
                name = "The Orbit",
                text = {
                    "Earn {C:money}$#1#{} per",
                    "poker hand {C:attention}level{} above {C:attention}1{}",
                    "{C:inactive}(Max of {C:money}$#2#{C:inactive})",
                },
           },
        },

        Spectral = {
            c_worm_solar_flare = {
                name = "Solar Flare",
                text = {
                    "{C:attention}Debuff{} all cards in hand",
                    "Level up a random poker hand",
                    "for {C:attention}each{} card debuffed",
                },
           },
        },


        Edition = {
            e_worm_stellar = {
                name = "Stellar",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "upgrade level of",
                    "played {C:attention}poker hand{}"
                },
            }
        },

        Tag = {
            tag_worm_stellar = {
                name = "Stellar Tag",
                text = {
                    "Shop has a free",
                    "{C:dark_edition}Stellar Joker",
                },
           },
        },

        Blind = {
            bl_worm_pull = {
                name = "The Pull",
                text = {
                    "Increases in size",
                    "per round played",
                    "this Ante",
                },
           },
        },
    },
    misc = {
        dictionary = {
            k_worm_texttexttext = "Flavor Text Example"
        },
        labels = {
            worm_stellar = 'Stellar'
        }
    }
}