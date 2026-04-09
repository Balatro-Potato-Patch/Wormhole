return {
    descriptions = {
        Joker = {
            j_worm_stew_earth = {
                name = "Stew Earth",
                text = {
                    "da stewww",
                },
            },

            j_worm_flat_earth = {
                name = 'Flat Earth',
                text = {
                    'This Joker gains {C:chips}+#2#{} Chips',
                    'for each {C:spades}Spade{} card removed',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}'
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

            j_worm_stargazer = {
                name = 'Stargazer',
                text = {
                    'This Joker gains {C:money}$#1#{} of',
                    '{C:attention}sell value{} every',
                    '{C:attention}#2#{C:inactive} [#3#]{C:diamonds} Diamond{} cards scored'
                }
            }

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
        }
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