local other_loc_table = {
    misc = {
        dictionary = {
            k_tbp_module = "Module",
            b_tbp_module_cards = "Modules",
        }
    },
    descriptions = {
        PotatoPatch = {
            PotatoPatchTeam_tbp = {name = 'Taxes and Back Pain'},
            PotatoPatchDev_eremel = {
                name = 'Eremel',
                text = {
                    'placeholder'
                }
            },
            PotatoPatchDev_n = {
                name = 'N\'',
                text = {
                    'placeholder'
                }
            },
            PotatoPatchDev_sdm = {
                name = 'SDM_0',
                text = {
                    'placeholder'
                }
            },
            PotatoPatchDev_dilly = {
                name = 'DillyTheDillster',
                text = {
                    'placeholder'
                }
            },
            PotatoPatchDev_ice = {
                name = 'Ice',
                text = {
                    'placeholder'
                }
            },
            PotatoPatchDev_rsnow = {
                name = 'RattlingSnow',
                text = {
                    'placeholder'
                }
            },
            PotatoPatchDev_mythie = {
                name = 'itsmythie',
                text = {
                    'placeholder'
                }
            },
        },
        Joker = {
            j_worm_spaceship = {
                name = "Spaceship",
                text = {
                    "Does {C:attention}awesome{} stuff!"
                }
            }
        },
        module = {
            c_worm_laser = {
                name = "Laser",
                text = {
                    "{C:mult}+#1#{} Mult"
                }
            }
        },
        Back = {
            b_worm_spaceship_deck = {
                name = "Spaceship Deck",
                text = {
                    "Start with ship and laser",
                    "(DEBUG PURPOSES)"
                },
            },
        },
    },
}

local descriptions = {
    Joker = {
        spaceship = {
            name = 'Spaceship',
            text = {
                'palceholder',
                '{C:red}#1#',
                '#2#',
                '#3#',
                '#4#'
            }
        },
    },
    tbp_module = {
        laser = {
            name = 'Laser',
            text = {
                '+#1# Mult'
            }
        },
        core = {
            name = 'Core',
            text = {
                '+#1# Chips'
            }
        },
    }
}

return Wormhole.tbp.prefix_loc_table(descriptions, other_loc_table)