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
            tbp_module_utility = 'UTILITY'
        }
    },
    descriptions = {
        PotatoPatch = {
            PotatoPatchTeam_tbp = {name = 'Taxes and Back Pain'},
            PotatoPatchDev_eremel = {
                name = 'Eremel',
                text = {
                    {
                        'Look at this silly UI I made (:'
                    },
                    {
                        'I help make {C:attention,E:2}SMODS{}!'
                    },
                    {
                        'I also worked on {C:green,E:2}Galdur{},',
                        '{C:blue,E:2}Malverk{}, {C:red,E:2}Ortalab{} and {C:gold,E:2}Monarchy{}'
                    }
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
        nebula = {
            name = "Nebula Core",
            text = {
                'When a {C:spectral}Module{} is {C:attention}exhausted{},',
                'level up a random',
                'poker hand by {C:attention}#1#{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        nebula_equipped = {
            name = '{C:attention}Nebula Core',
            text = {
                '{s:1.2,V:1}Nebula Core{}',
                'When a {C:spectral}Module{} is {C:attention}exhausted{}',
                'level up a random',
                'poker hand by {C:attention}#1#{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        astrophage = {
            name = "Astrophage Core",
            text = {
                'Using a {C:planet}Planet{} card',
                'increases the durability of',
                'a random {C:spectral}Module{} by {C:attention}#1#{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        astrophage_equipped = {
            name = "Astrophage Core",
            text = {
                '{s:1.2,V:1}Astrophage Core{}',
                'Using a {C:planet}Planet{} card',
                'increases the durability of',
                'a random {C:spectral}Module{} by {C:attention}#1#{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        dellinger = {
            name = "Dellinger Core",
            text = {
                'Playing a {C:attention}#2#{}',
                'increases the durability of',
                'other {C:spectral}Modules{} by {C:attention}#1#{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        dellinger_equipped = {
            name = "Dellinger Core",
            text = {
                '{s:1.2,V:1}Dellinger Core{}',
                'Playing a {C:attention}#2#{}',
                'increases the durability of',
                'each other {C:spectral}Module{} by {C:attention}1{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        black_hole_generator = {
            name = "Black Hole Generator",
            text = {
                'When a {C:spectral}Module{} is {C:attention}exhausted{},',
                'increases the durability of',
                'other {C:spectral}Modules{} by {C:attention}#1#{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        black_hole_generator_equipped = {
            name = "Black Hole Generator",
            text = {
                '{s:1.2,V:1}Black Hole Generator{}',
                'When a {C:spectral}Module{} is {C:attention}exhausted{}',
                'increases the durability of',
                'other {C:spectral}Modules{} by {C:attention}#1#{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        -- WEAPON --
        void = {
            name = 'Void Raid',
            text = {
                'Destroy random cards played',
                'in {C:attention}first hand{} of round',
                'and add {C:purple}#1#%{} of the',
                'required score for each',
                '{s:0.8,C:inactive}(Depletes for each card destroyed)'
            }
        },
        void_equipped = {
            name = '{C:attention}Void Raid',
            text = {
                '{s:1.2,V:1}Void Raid',
                'Destroy random cards played',
                'in {C:attention}first hand{} of round',
                'and add {C:purple}#1#%{} of the',
                'required score for each',
                '{s:0.8,C:inactive}(Depletes for each card destroyed)'
            }
        },
        ballistics = {
            name = 'Advanced Ballistics',
            text = {
                "Every played {C:attention}card{}",
                "permanently gains",
                "{C:chips}+#1#{} Chips when scored",
                '{s:0.8,C:inactive}(Depletes for each card scored)'
            }
        },
        ballistics_equipped = {
            name = '{C:attention}Advanced Ballistics',
            text = {
                '{s:1.2,V:1}Advanced Ballistics',
                "Every played {C:attention}card{}",
                "permanently gains",
                "{C:chips}+#1#{} Chips when scored",
                '{s:0.8,C:inactive}(Depletes for each card scored)'
            }
        },
        waste = {
            name = 'Weaponized Waste Disposal',
            text = {
                '{C:mult}+#1#{} Mult for every',
                '{C:spectral}Module{} exhausted', -- TODO: change color to new Module one if changed
                'this run',
                '{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)',
                '{s:0.8,C:inactive}(Depletes each hand)'
            }
        },
        waste_equipped = {
            name = '{C:attention}Weaponized Waste Disposal',
            text = {
                '{s:1.2,V:1}Weaponized Waste Disposal',
                '{C:mult}+#1#{} Mult for every',
                '{C:spectral}Module{} exhausted', -- TODO: change color to new Module one if changed
                'this run',
                '{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)',
                '{s:0.8,C:inactive}(Depletes each hand)'
            }
        },
        salvo = {
            name = 'Overcharged Salvo',
            text = {
                '{X:mult,C:white} X#1# {} for each',
                '{C:spectral}Module{} installed',
                'if scored hand contains',
                '{C:attention}5{} cards',
                '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)',
                '{s:0.8,C:inactive}(Depletes all Modules when triggered)'
            }
        },
        salvo_equipped = {
            name = '{C:attention}Overcharged Salvo',
            text = {
                '{s:1.2,V:1}Overcharged Salvo',
                '{X:mult,C:white} X#1# {} for each',
                '{C:spectral}Module{} installed',
                'if scored hand contains',
                '{C:attention}5{} cards',
                '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)',
                '{s:0.8,C:inactive}(Depletes all Modules when triggered)'
            }
        },
        -- UTILITY --
        hardlight = {
            name = 'Hardlight Barrier',
            text = {
                'Reduce {C:attention}Blind{}\'s',
                'requirement by {C:red}#1#%{}',
                'when {C:attention}Blind{} is selected',
                '{s:0.8,C:inactive}(Depletes each Blind)'
            }
        },
        hardlight_equipped = {
            name = '{C:attention}Hardlight Barrier',
            text = {
                '{s:1.2,V:1}Hardlight Barrier',
                'Reduce {C:attention}Blind{}\'s',
                'requirement by {C:red}#1#%{}',
                'when {C:attention}Blind{} is selected',
                '{s:0.8,C:inactive}(Depletes each Blind)'
            }
        },
        quantum = {
            name = 'Quantum Computer',
            text = {
                'Earn {C:money}+$#1#{} when',
                'another {C:green}probability{} succeeds',
                '{s:0.8,C:inactive}({s:0.8,C:green}#2# in #3#{s:0.8,C:inactive} chance',
                '{s:0.8,C:inactive}to deplete when triggered)'
            }
        },
        quantum_equipped = {
            name = '{C:attention}Quantum Computer',
            text = {
                '{s:1.2,V:1}Quantum Computer',
                'Earn {C:money}+$#1#{} when',
                'another {C:green}probability{} succeeds',
                '{s:0.8,C:inactive}({s:0.8,C:green}#2# in #3#{s:0.8,C:inactive} chance',
                '{s:0.8,C:inactive}to deplete when triggered)'
            }
        },
        interference = {
            name = 'Interference Matrix',
            text = {
                'Disable selected',
                '{C:attention}Boss Blind{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        interference_equipped = {
            name = '{C:attention}Interference Matrix',
            text = {
                '{s:1.2,V:1}Interference Matrix',
                'Disable selected',
                '{C:attention}Boss Blind{}',
                '{s:0.8,C:inactive}(Depletes when triggered)'
            }
        },
        redundancy = {
            name = 'Redundancy Battery',
            text = {
                'When a {C:spectral}Module{} would',
                '{C:attention}deplete{}, this module',
                'depletes by {C:attention}#1#{} instead',
            }
        },
        redundancy_equipped = {
            name = '{C:attention}Redundancy Battery',
            text = {
                '{s:1.2,V:1}Redundancy Battery',
                'When a {C:spectral}Module{} would',
                '{C:attention}deplete{}, this module',
                'depletes by {C:attention}#1#{} instead',
            }
        },
        -- THRUSTERS --
        warp_drive = {
            name = 'Warp Drive',
            text = {
                'Skip Blind: gain {X:mult,C:white} X#1# {} Mult',
                '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive})',
                '{C:inactive,s:0.8}(Depletes when skipping a blind)'
            }
        },
        warp_drive_equipped = {
            name = '{C:attention}Warp Drive',
            text = {
                '{s:1.2,V:1}Warp Drive{}',
                'Skip Blind: gain {X:mult,C:white} X#1# {} Mult',
                '{C:inactive,s:0.8}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)',
                '{C:inactive,s:0.8}(Depletes when skipping a blind)'
            }
        },
        temporal_jump = {
            name = 'Temporal Jump Thrusters',
            text = {
                'Skip Blind: Get {C:attention}#1#{} {C:attention}Skip Tags',
                '{C:inactive,s:0.8}(Depletes when skipping a blind)'
            }
        },
        temporal_jump_equipped = {
            name = '{C:attention}Temporal Jump Thrusters',
            text = {
                '{s:1.2,V:1}Temporal Jump Thrusters{}',
                'Skip Blind: Get {C:attention}#1#{} {C:attention}Skip Tags',
                '{C:inactive,s:0.8}(Depletes when skipping a blind)'
            }
        },
        repeater = {
            name = 'Repeater Engine',
            text = {
                'Retrigger each scored',
                '{C:attention}Enhanced{} card',
                'in played hand {C:attention}twice',
                '{s:0.8,C:inactive}(Depletes each hand)'
            }
        },
        repeater_equipped = {
            name = '{C:attention}Repeater Engine',
            text = {
                '{s:1.2,V:1}Repeater Engine',
                'Retrigger each scored',
                '{C:attention}Enhanced{} card',
                'in played hand {C:attention}twice',
                '{s:0.8,C:inactive}(Depletes each hand)'
            }
        },
        antimatter = {
            name = 'Anti-Matter Thrusters',
            text = {
                'Create a {C:dark_edition}Negative{}',
                '{C:planet}Planet{} card for the played hand',
                '{s:0.8,C:inactive}(Depletes each hand)'
            }
        },
        antimatter_equipped = {
            name = '{C:attention}Anti-Matter Thrusters',
            text = {
                '{s:1.2,V:1}Anti-Matter Thrusters',
                'Create a {C:dark_edition}Negative{}',
                '{C:planet}Planet{} card for the played hand',
                '{s:0.8,C:inactive}(Depletes each hand)'
            }
        },
        -- hyperlight_rotors = {
        --     name = 'Hyperlight Rotors',
        --     text = {
        --         'Gives {X:mult,C:white} X#1# {C:mult} Mult',
        --         'per empty {C:attention}Joker slot',
        --         '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive})',
        --         '{C:inactive,s:0.8}Damaged when scoring'
        --     }
        -- },
        -- hyperlight_rotors_equipped = {
        --     name = '{C:attention}Hyperlight Rotors',
        --     text = {
        --         '{s:1.2,V:1}Hyperlight Rotors{}',
        --         'Gives {X:mult,C:white} X#1# {C:mult} Mult',
        --         'per empty {C:attention}Joker slot',
        --         '{C:inactive,s:0.8}(Currently {X:mult,C:white}X#2#{C:inactive})',
        --         '{C:inactive,s:0.8}Depletes when scoring'
        --     }
        -- },
        -- resuited_thruster = {
        --     name = 'Resuited Thruster',
        --     text = {
        --         'Played {V:1}#2#{} cards',
        --         'give {C:chips}+#1#{} Chips',
        --         '{C:inactive,s:0.8} Damaged when scoring',
        --         '{C:inactive,s:0.8} Suit changes at end of round'
        --     }
        -- },
        -- resuited_thruster_equipped = {
        --     name = '{C:attention}Resuited Thruster',
        --     text = {
        --         '{s:1.2,V:1}Resuited Thruster{}',
        --         'Played {V:2}#2#{} cards',
        --         'give {C:chips}+#1#{} Chips',
        --         '{C:inactive,s:0.8} Depletes when scoring',
        --         '{C:inactive,s:0.8} Suit changes at end of round'
        --     }
        -- },
        -- UNCATEGORIZED --
        -- uncat3 = {
        --     name = 'Uncategorized 3',
        --     text = {
        --         "Every played {C:attention}card{}",
        --         "permanently gains",
        --         "{C:mult}+#1#{} Mult when scored",
        --         '{s:0.8,C:inactive}(Depletes for each card scored)'
        --     }
        -- },
        -- uncat3_equipped = {
        --     name = '{C:attention}Uncategorized 3',
        --     text = {
        --         '{s:1.2,V:1}Uncategorized 3',
        --         "Every played {C:attention}card{}",
        --         "permanently gains",
        --         "{C:mult}+#1#{} Mult when scored",
        --         '{s:0.8,C:inactive}(Depletes for each card scored)'
        --     }
        -- },
        -- uncat4 = {
        --     name = 'Uncategorized 4',
        --     text = {
        --         "Earn {C:money}+$#1#{}",
        --         "when a {C:spectral}Module{}",
        --         "is {C:attention}exhausted{}",
        --         '{s:0.8,C:inactive}(Depletes each time it triggers)'
        --     }
        -- },
        -- uncat4_equipped = {
        --     name = '{C:attention}Uncategorized 4',
        --     text = {
        --         '{s:1.2,V:1}Uncategorized 4',
        --         "Earn {C:money}+$#1#{}",
        --         "when a {C:spectral}Module{}",
        --         "is {C:attention}exhausted{}",
        --         '{s:0.8,C:inactive}(Depletes each time it triggers)'
        --     }
        -- },
    }
}

return Wormhole.tbp.prefix_loc_table(descriptions, other_loc_table)