return {
    descriptions = {
        PotatoPatch = {
            -- Team-Name:
            PotatoPatchTeam_dummies = { name = 'Dummies' },
            -- Team-Members:
            PotatoPatchDev_ghostsalt = {
                name = 'GhostSalt',
                text = { ":3" }
            },
            PotatoPatchDev_vissa = {
                name = 'vissa',
                text = { "glorpalicious"}
            },
            PotatoPatchDev_bakersdozenbagels = {
                name = 'BakersDozenBagels',
                text = { ":transgender_flag:"}
            },
            PotatoPatchDev_theonegoofali = {
                name = 'TheOneGoofAli',
                text = { "aeiou" }
            },
            PotatoPatchDev_baltdev = {
                name = 'baltdev',
                text = { "hi im a slugcat" }
            },
            PotatoPatchDev_flowire = {
                name = 'Flowire',
                text = { "Tastes like a", "{C:red}Strawberry{}!" }
            },
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
            j_worm_dum_carnivore = {
                name = "Moku the Carnivore",
                text = {
                    {
                        "When {C:attention}Blind{} is selected,",
                        "if Joker to the right is:",
                        "{X:chips,C:white}Fish{} - eat it and gain {C:chips}+#2#{} Chips",
                        "{X:grey,C:white}Cat{} - eat it and gain {C:mult}+#1#{} Mult",
                        "{X:green,C:white}Alien{} - eat it and gain {X:mult,C:white} X#3# {} Mult",
                        "{C:inactive}(Currently {C:chips}+#5#{C:inactive} Chips, {C:mult}+#4#{C:inactive} Mult, {X:mult,C:white} X#6# {C:inactive} Mult",
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
            },
			j_worm_dum_gleebleglorp = {
                name = "Gleebleglorp",
                text = {
                    {
                        "{C:white,X:mult}X#1#{} Mult if played",
                        "{C:attention}poker hand{} is not your",
                        "{C:attention}highest-level{} hand"
                    }
                },
            },
        },
        Planet = {
            c_worm_dum_moony = {
                name = "Moony",
                text = {
                    "Select between {C:attention}#1#{}",
                    "random {C:attention}poker hands{},",
                    "upgrade selected",
                    "hand by {C:attention}#2#{} level"
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
        },
		Voucher = {
			v_worm_dum_spacesuit = {
				name = "Space Suit",
				text = {{
                    "{C:attention}Gain{} and {C:attention}Increase{} your",
                    "maximum amount of",
                    "{C:spectral}Oxygen{} by {C:attention}#1#{} minutes",
                }, {
                    "Gain {C:attention}#2#{} seconds of {C:spectral}Oxygen{}",
                    "after beating a {C:attention}Blind{}",
                }, {
				    "Multiply {C:chips}Chips{} and {C:mult}Mult{} by",
				    "half of your current {C:spectral}Oxygen{}",
                    "{C:inactive,s:0.8}(ex. {C:attention,s:0.8}2:53{C:inactive,s:0.8} -> {X:purple,C:white,s:0.8}X1.27{C:inactive,s:0.8} Mult and Chips){}",
				}}
			},
        },
		Tag = {
			tag_worm_dum_trinary = {
				name = "Trinary System",
				text = {
                    "Gives either a {C:planet}Planet{},",
                    "{C:spectral}Spectral{} or {C:tarot}Tarot{} card",
                    "when {C:attention}Blind{} is selected",
                    "{C:inactive}(Must have room){}",
                    "{C:inactive}({C:attention}#1#{C:inactive} uses left){}",
				}
			},
        },
		Other = {
			worm_dum_spacesuit_warning = {
				name = "{s:1.2}Warning{}",
				text = {
                    "When {C:spectral}Oxygen{} runs out,",
                    "{C:red,E:2}Lose{E:2} the Game",
                }
			},
			worm_dum_spacesuit_upgrade = {
				name = "Space Suit Upgrade",
				text = {
                    "Maximum Oxygen: {C:spectral}#1#{} -> {C:spectral}#2#{}",
                    "Beating a Blind: {C:attention}#3#{} -> {C:attention}#4#{}",
                    "{C:inactive}The multiplier doesn't change!"
                }
			},
        },
    },
    misc = {
        dictionary = {
            k_worm_dum_worm_free="Free packs!",
            k_worm_dum_worm_eat="Gulp!",
            k_worm_dum_dummy_blind_saved = "Test flight failed!",
            k_worm_dum_greg_eat="Nom!",
            k_worm_dum_carnivore_eat="Chomp!",
            worm_moony_menu_tooltip = {
                "Select one of the above",
                "poker hands to upgrade."
            },
            k_worm_dum_low_oxygen = "Low Oxygen",
        },
		v_dictionary = {
			worm_dum_store = "+X#1# Stored",
			worm_dum_apply = "+X#1# Applied",
            worm_dum_percent = "#1#%",
            worm_dum_xgeneric = "X#1#",
        },
		challenge_names = {
			c_worm_dum_low_oxygen = "Low Oxygen",
        },
		v_text = {
            -- Challenge Descs.
			ch_c_worm_dum_low_oxygen_1 = { "Start with {C:attention}30{} minutes of {C:spectral}Oxygen{},", },
			ch_c_worm_dum_low_oxygen_2 = { "{C:spectral}Oxygen{} doesn't affect scoring.", },
            -- Generic/Misc.
			ch_c_worm_dum_gold_stake = { "Apply {C:money}Gold Stake{} difficulty" },
			ch_c_worm_dum_space = { "{s:0.5} ", },
        },
    }
}
