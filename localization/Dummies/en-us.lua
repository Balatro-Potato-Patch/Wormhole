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
			j_worm_dum_scrooge = {
                name = "DuckTales: The Moon",
                text = {
					"Earn {C:money}#1#{} for {C:attention}every{} poker hand",
					"in played hand when holding their",
					"{C:attention}respective{} {C:planet}Planet{} card"
                },
            },
			j_worm_dum_spaghet = {
                name = "Spaghettification",
                text = {
					"If a {C:planet}Planet{} card is held for {C:attention}discarded{}",
					"poker hand, {C:red}destroy{} it and add",
					"{C:attention}per-level{} {C:chips}Chips{} of said poker hand",
					"to this Joker",
					"{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)"
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
			v_worm_dum_oxygentank = {
				name = "Oxygen Tank",
				text = {{
                    "{C:attention}Gain{} and {C:attention}Increase{} your",
                    "maximum amount of",
                    "{C:spectral}Oxygen{} by {C:attention}#1#{} minutes",
                }, {
                    "{u:inactive}Reduce{} the {C:spectral}Oxygen{}",
                    "gained, after beating",
                    "a {C:attention}Blind{}, by {C:attention}#2#{} seconds",
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
				name = "Oxygen Upgrade",
				text = {
                    "{C:inactive}Maximum Oxygen:", "{C:spectral}#1#{} -> {C:spectral}#2#{}",
                    "{s:0.5} ",
                    "{C:inactive}Replenish Time:", "{C:attention}#3#{} -> {C:attention}#4#{}",
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
			c_worm_dum_buff_spacesuit = "Buff Space Suit",
        },
		v_text = {
            -- Challenge Descs.
			ch_c_worm_dum_low_oxygen_1 = { "Start with {C:attention}30{} minutes of {C:spectral}Oxygen{},", },
			ch_c_worm_dum_low_oxygen_2 = { "{C:spectral}Oxygen{} doesn't affect scoring.", },
            ch_c_worm_dum_buff_spacesuit_1 = { "Enjoy {C:green,E:1}Pre-Nerfed {C:attention}Space Suit{} stats!", },
            ch_c_worm_dum_buff_spacesuit_2 = { "{C:inactive}Maximum Oxygen: {C:spectral}05:00{C:inactive} minutes", },
            ch_c_worm_dum_buff_spacesuit_3 = { "{C:inactive}Replenish Time: {C:attention}01:00{C:inactive} minute", },
            -- Generic/Misc.
			ch_c_worm_dum_gold_stake = { "Apply {C:money}Gold Stake{} difficulty" },
			ch_c_worm_dum_space = { "{s:0.5} ", },
        },
        --# See "dummies_quips.lua":
        --# Update the Amount of "EXPECTED" when using the [Generic] method!
        quips = {
            -- [Generic] WIN Quips:
            worm_dummies_win_1 = { "{s:2.0,C:green}W" },
            worm_dummies_win_2 = { "I knew you", "could do it!" },
            worm_dummies_win_3 = { "Cuties say '{E:1}what{}'." },
            worm_dummies_win_4 = { "You're a real", "{C:blue,E:1}Card Shark{}!" },
            worm_dummies_win_5 = { "I won back all", "my bets, thanks!" },
            worm_dummies_win_6 = { "Pretty {E:2}and{} Smart!" },
            worm_dummies_win_7 = { "You're the", "{C:red}3{} to my {C:red}<{}" },
            worm_dummies_win_8 = { "{s:2.0,C:green}+2" },
            worm_dummies_win_9 = { "With plays like these,", "I know why the word", '"{E:2}Peak{}" was invented!' },
            worm_dummies_win_10 = { "{s:2.0}:3" },
            worm_dummies_win_11 = { "{s:2.0} l_o_l", "{s:2.0}  |Î| ", "{s:1.0}  Absolute", "{s:2.0}Cinema" },
            -- [Generic] LOSS Quips:
            worm_dummies_loss_1 = { "{s:2.0,C:red}L" },
            worm_dummies_loss_2 = { "Yeah, you should", "try a bit more", "than {u:red}that{}. {E:2}Yikes{}!" },
            worm_dummies_loss_3 = { "   I think you'll have more success", '   searching for {C:red}"Quit"{} over here!', "                   {C:inactive}|", " ", "                   {C:inactive}|", " ", "                   {C:inactive}|", " ", "                   {C:inactive}|", "                   {C:inactive} - - - - - - - - >" },
            worm_dummies_loss_4 = { "I would've loved to help", "you, it's just not very", "convenient right now." },
            worm_dummies_loss_5 = { "Aww, dang it!" },
            worm_dummies_loss_6 = { "{E:2}Quit fooling around." },
            worm_dummies_loss_7 = { "Are you sure you", "know how to play?" },
            worm_dummies_loss_8 = { "Maybe ask", "{E:2}CrapGPT", "for help." },
            worm_dummies_loss_9 = { "I think you", "should play the", "{C:blue}Tutorial{} again." },
            worm_dummies_loss_10 = { "{s:2.0,C:red}-2" },
            worm_dummies_loss_11 = { "Time's up,", "{E:2}buddy{}!" },
            -- [Custom] Quips:
            worm_dummies_flowire_1 = { "ERROR" },
            worm_dummies_flowire_2 = { "nil" },
            worm_dummies_flowire_3 = { "{s:5.0} " },
        },
    }
}
