local other_loc_table = {
    misc = {
        dictionary = {
            b_tbp_module_cards = "Modules",
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
                text={
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:spectral} Module{} cards to", -- TODO: change color to new Module one if changed
                    "be used immediately",
                },
            },
            p_worm_module_normal_2 = {
                name = "Module Pack",
                text={
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:spectral} Module{} cards to", -- TODO: change color to new Module one if changed
                    "be used immediately",
                },
            },
            p_worm_module_jumbo_1 = {
                name = "Jumbo Module Pack",
                text={
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:spectral} Module{} cards to", -- TODO: change color to new Module one if changed
                    "be used immediately",
                },
            },
            p_worm_module_mega_1 = {
                name = "Mega Module Pack",
                text={
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:spectral} Module{} cards to", -- TODO: change color to new Module one if changed
                    "be used immediately",
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
        laser = {
            name = 'Laser',
            text = {
                '+#1# Mult'
            }
        },
        laser_equipped = {
            name = '{C:attention}Weapon',
            text = {
                '{s:1.2,V:1}Laser',
                '{C:red}+#1#{} Mult'
            }
        },
        core = {
            name = 'Core',
            text = {
                '+#1# Chips'
            }
        },
        core_equipped = {
            name = 'name',
            text = {
                '{s:1.2,V:1}Core',
                '{C:blue}+#1#{} Chips when a',
                '{C:attention}Ace{} is scored'
            }
        },
        module_missing = {
            name = 'name',
            text = {
                '{V:1}EMPTY'
            }
        },
    }
}

return Wormhole.tbp.prefix_loc_table(descriptions, other_loc_table)