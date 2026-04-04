return {
    descriptions = {
        PotatoPatch = {
            PotatoPatchTeam_dummies = { name = 'Dummies' },
            PotatoPatchDev_ghostsalt = { name = 'GhostSalt', text = { ":3" } },
            PotatoPatchDev_vissa = {name = 'vissa', text = { "take me to your dealer"}},
            PotatoPatchDev_theonegoofali = {name = 'TheOneGoofAli', text = { "aeiou" }},
            PotatoPatchDev_baltdev = {name = 'baltdev', text = { "hi im a slugcat" }},
            PotatoPatchDev_flowire = {name = 'Flowire', text = { "Tastes like a", "{C:red}Strawberry{}!" }},
        },
        Joker = {
            j_worm_dum_worm = {
                name = "Worm The Eater",
                text = {
                    "All booster packs are {C:attention}free{}.",
                    "{C:red}Eats{} booster packs while",
                    "you're not looking."
                },
            },
            j_worm_dum_greg = {
                name = "Greg The Spitter",
                text = {
                    {
                        "After a hand is scored",
                        "{C:attention}Eats{} your {C:attention}rightmost played{} card,",
                        "{C:attention}Enhances{} your {C:attention}leftmost played{} card.",
                        "{C:red}Cannot be sold."
                    }
                },
            },
			j_worm_dum_garlicbread = {
                name = { "Garlic Bread that", "went to Space" },
                text = {
                    "{C:attention}All{} poker hands are {C:attention}upgraded{}",
                    "after using {C:attention}#2#{} {C:planet}Planet{} cards",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}){}"
                },
            },
			j_worm_dum_farfromhome = {
                name = "Far from Home",
                text = {{
                    "Store {X:chips,C:white}X#1#{} Chips when",
                    "a {C:planet}Planet{} card is used",
                    "{C:inactive}(Stored: {X:chips,C:white}X#2#{C:inactive} Chips){}"
                }, {
                    "Using {C:planet}Earth{} applies",
                    "all stored Chips,",
                    "lose {X:chips,C:white}X#3#{} Chips for",
                    "every hand played",
                    "{C:inactive}(Currently {X:chips,C:white}X#4#{C:inactive} Chips){}"
                }},
			j_worm_dum_gleebleglorp = {
                name = "Gleebleglorp",
                text = {
                    {
                        "{C:white,X:mult}X#1#{} Mult if played",
                        "{C:attention}poker hand{} is not",
                        "your {C:attention}highest-level{} hand"
                    }
                },
            },
        },
        Planet = {
            c_worm_dum_moony = {
                name = "Moony",
                text = {
                    "Select between {C:attention}2{}",
                    "random {C:attention}poker hands{},",
                    "upgrade selected",
                    "hand by {C:attention}#1#{} level"
                }
            },
        },
        Spectral = {
            c_worm_dum_pulsar = {
                name = "Pulsar",
                text = {
                    "{C:attention}Doubles{} the per-level",
                    "Chips/Mult of {C:attention}#1#{}",
                    "and sets its level to 1"
                }
            }
        },
        Blind = {
            bl_worm_dum_dummy_blind = {
                name = "Test Flight",
                text = {
                    "You cannot lose to this blind.",
                    "Earn {C:attention}rewards{} based",
                    "on how well you score.",
                    "{s:0.8,C:worm_dum_brown}Let's see if you can",
                    "{s:0.8,C:worm_dum_brown}steer this Space Ship!"
                },
            },
        }
    },
    misc = {
        dictionary = {
            k_worm_dum_worm_free="Free packs!",
            k_worm_dum_worm_eat="Nom!",
            k_worm_dum_dummy_blind_saved = "Test flight failed!",
            worm_moony_menu_tooltip = {
                "Select one of the above",
                "poker hands to upgrade."
            },
        },
		v_dictionary = {
			worm_dum_store = "+X#1# Stored",
			worm_dum_apply = "+X#1# Applied",
            worm_dum_percent = "#1#%",
        },
    }
}
