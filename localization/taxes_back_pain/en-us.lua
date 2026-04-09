local other_loc_table = {
    misc = {
        labels = {
            tbp_module = "Module"
        },
        dictionary = {
            b_tbp_module_cards = "Modules",
            k_tbp_module = "Module",
            k_worm_tbp_module = "Module Pack",
            tbp_module_weapons = 'WEAPON',
            tbp_module_core = 'CORE',
            tbp_module_thrusters = 'THRUSTERS',
            tbp_module_shields = 'SHIELD'
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
        Other = {
            p_worm_module_normal_1 = {
                name = "Module Pack",
                text = {
                    {
                        "Choose {C:attention}#1#{} of up to",
                        "{C:attention}#2#{C:spectral} Module{} cards to", -- TODO: change color to new Module one if changed
                        "be used immediately",
                    },
                    {
                        "When opened,",
                        "create a {C:attention}Spaceship{}",
                        "if none are owned"
                    }
                },
            },
            p_worm_module_normal_2 = {
                name = "Module Pack",
                text = {
                    {
                        "Choose {C:attention}#1#{} of up to",
                        "{C:attention}#2#{C:spectral} Module{} cards to", -- TODO: change color to new Module one if changed
                        "be used immediately",
                    },
                    {
                        "When opened,",
                        "create a {C:attention}Spaceship{}",
                        "if none are owned"
                    }
                },
            },
            p_worm_module_jumbo_1 = {
                name = "Jumbo Module Pack",
                text = {
                    {
                        "Choose {C:attention}#1#{} of up to",
                        "{C:attention}#2#{C:spectral} Module{} cards to", -- TODO: change color to new Module one if changed
                        "be used immediately",
                    },
                    {
                        "When opened,",
                        "create a {C:attention}Spaceship{}",
                        "if none are owned"
                    }
                },
            },
            p_worm_module_mega_1 = {
                name = "Mega Module Pack",
                text = {
                    {
                        "Choose {C:attention}#1#{} of up to",
                        "{C:attention}#2#{C:spectral} Module{} cards to", -- TODO: change color to new Module one if changed
                        "be used immediately",
                    },
                    {
                        "When opened,",
                        "create a {C:attention}Spaceship{}",
                        "if none are owned"
                    }
                },
            },
        }
    },
}

local descriptions = {
    Joker = {
        spaceship = {
            name = 'Spaceship',
            text = {
                '{V:1}Adds a {V:2}#1#',
                '{V:1}to the shop when',
                '{V:1}no modules are equipped'
            }
        },
    },
    tbp_module = {
        module_missing = {
            name = 'name',
            text = {
                '{V:1}EMPTY'
            }
        },
        -- CORE --
        -- WEAPON --
        uncat1 = {
            name = 'Uncategorized 1',
            text = {
                'Retrigger each scored',
                '{C:attention}Enhanced{} card',
                'in played hand {C:attention}twice'
            }
        },
        uncat1_equipped = {
            name = '{C:attention}Uncategorized 1',
            text = {
                '{s:1.2,V:1}Uncategorized 1',
                'Retrigger each scored',
                '{C:attention}Enhanced{} card',
                'in played hand {C:attention}twice'
            }
        },
        uncat2 = {
            name = 'Uncategorized 2',
            text = {
                'Create a {C:dark_edition}Negative{}',
                '{C:planet}Planet{} card for the played hand',
            }
        },
        uncat2_equipped = {
            name = '{C:attention}Uncategorized 2',
            text = {
                '{s:1.2,V:1}Uncategorized 2',
                'Create a {C:dark_edition}Negative{}',
                '{C:planet}Planet{} card for the played hand',
            }
        },
        uncat3 = {
            name = 'Uncategorized 3',
            text = {
                "Every played {C:attention}card{}",
                "permanently gains",
                "{C:mult}+#1#{} Mult when scored",
            }
        },
        uncat3_equipped = {
            name = '{C:attention}Uncategorized 3',
            text = {
                '{s:1.2,V:1}Uncategorized 3',
                "Every played {C:attention}card{}",
                "permanently gains",
                "{C:mult}+#1#{} Mult when scored",
            }
        },
        uncat4 = {
            name = 'Uncategorized 4',
            text = {
                "Earn {C:money}+$#1#{}",
                "when a {C:spectral}Module{}", -- TODO: change color to new Module one if changed
                "is {C:attention}destroyed{}"
            }
        },
        uncat4_equipped = {
            name = '{C:attention}Uncategorized 4',
            text = {
                '{s:1.2,V:1}Uncategorized 4',
                "Earn {C:money}+$#1#{}",
                "when a {C:spectral}Module{}", -- TODO: change color to new Module one if changed
                "is {C:attention}destroyed{}"
            }
        },
        -- UTILITY --
        -- THRUSTERS --
    }
}

return Wormhole.tbp.prefix_loc_table(descriptions, other_loc_table)