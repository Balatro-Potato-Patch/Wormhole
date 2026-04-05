return {
    descriptions = {
        Joker = {
            j_worm_laika = {
                name = "Laika",
                text = {
                    "Every {C:attention}space-themed{}",
                    "Joker gives {C:attention}+1{}",
                    "temporary level"
                }
            },
            j_worm_dyson_sphere = {
                name = "Dyson Sphere",
                text = {
                    "Whenever you {C:attention}Clean-up{}, this",
                    "{C:attention}Joker{} gains {C:mult}+#2#{} Mult for",
                    "each card cleaned-up",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive})"
                }
            },
            j_worm_wall_e = {
                name = "WALL-E",
                text = {
                    "You may pay {C:attention}Clean-up{} costs by",
                    "selecting up to {C:attention}one{} fewer card",
                    "{C:inactive}(Minimum of 1 card)"
                }
            },
            j_worm_nyan_cat = {
                name = "Nyan Cat",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "per {C:attention}consecutive{} hand",
                    "played with {C:attention}two or more",
                    "unique scoring suits",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_worm_event_horizon = {
                name = "Event Horizon",
                text = {
                    "This Joker interrupts all",
                    "hand {C:attention}level-ups{} and redirects",
                    "them to the {C:attention}next played{} hand",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive} levels stored){}"
                }
            },
        },
        Enhanced = {
            m_worm_junk_card = {
                name = "Junk",
                text = {
                    {
                        "No rank or suit,",
                        "always scores",
                    },
                    {
                        "{C:chips}+#1#{} Chips",
                        "Retrigger this",
                        "card {C:attention}#3#{} time#4#"
                    }
                }
            },
            m_worm_junk_card_mult = {
                name = "Junk",
                text = {
                    {
                        "No rank or suit,",
                        "always scores",
                    },
                    {
                        "{C:chips}+#1#{} Chips",
                        "{C:mult}+#2#{} Mult",
                        "Retrigger this",
                        "card {C:attention}#3#{} time#4#"
                    }
                }
            },
        },
        JunkSet = {
            c_worm_asteroid_harvester = {
                name = "Asteroid Harvester",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Cards{} into",
                        "{C:attention}Junk Cards"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} Earn {C:money}$#3#{}",
                    }
                }
            },
            c_worm_solar_sail = {
                name = "Solar Sail",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Cards{} into",
                        "{C:attention}Junk Cards"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} Give the first two",
                        "{C:attention}cleaned-up cards{} an {C:dark_edition}Edition",
                    }
                }
            },
            c_worm_abandoned_wrench = {
                name = "Abandoned Wrench",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Cards{} into",
                        "{C:attention}Junk Cards"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} ALL current and",
                        "future {C:attention}Junk Cards{} gain {C:chips}+#3#{} Chips",
                    }
                }
            },
            c_worm_lost_pliers = {
                name = "Lost Pliers",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Cards{} into",
                        "{C:attention}Junk Cards"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} ALL current and",
                        "future {C:attention}Junk Cards{} gain {C:mult}+#3#{} Mult",
                    }
                }
            },
            c_worm_manhole_cover = {
                name = "Manhole Cover",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Cards{} into",
                        "{C:attention}Junk Cards"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} ALL current and",
                        "future {C:attention}Junk Cards{} gain {C:attention}+#3#{} retrigger",
                        "The next {C:attention}Blind{} must be skipped",
                    }
                }
            },
            c_worm_starfish_prime = {
                name = "Starfish Prime",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Cards{} into",
                        "{C:attention}Junk Cards"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} played hands with",
                        "{C:attention}Junk Cards{} gain an additional {C:attention}+#3#{}",
                        "multiplier to {C:chips}Chips{} and {C:mult}Mult{}, then",
                        "destroy {C:attention}#4#{} random {C:attention}cleaned-up cards{}",
                    }
                }
            }
        },
        Back = {
            b_worm_decrepit_deck = {
                name = "Decrepit Deck",
                text = {
                    "Start run with each {C:attention}face",
                    "{C:attention}card{} as a {C:attention,T:m_worm_junk_card}Junk Card",
                },
            },
        },
        Other = {
			p_worm_junkset_normal = {
				name = "Derelict Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:worm_c3_junkset}Derelict{} cards to",
					"be used immediately",
				},
			},
			p_worm_junkset_jumbo = {
				name = "Jumbo Derelict Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:worm_c3_junkset}Derelict{} cards to",
					"be used immediately",
				},
			},
			p_worm_junkset_mega = {
				name = "Mega Derelict Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:worm_c3_junkset}Derelict{} cards to",
					"be used immediately",
				},
			},

            worm_clean_up_keyword = {
                name = "Clean-up",
                text = {
                    "Clean-up {C:attention}X{} means",
                    "{s:0.8}\"You may use this on {C:attention,s:0.8}X {C:attention,s:0.8}Junk Cards{s:0.8},",
                    "{s:0.8}if you do, remove their enhancement then",
                    "{s:0.8}trigger the {C:attention,s:0.8}Clean-Up{s:0.8} effect instead\"",
                }
            }
        },
        PotatoPatch = {
            PotatoPatchTeam_colon_three = {
                name = ":3"
            },
            PotatoPatchDev_lordruby = {
                name = "lord.ruby",
                text = {
                    ":3"
                }
            },
            PotatoPatchDev_meta = {
                name = "Meta",
                text = {
                    "waow :3"
                }
            },
            PotatoPatchDev_ophelia = {
                name = "Ophelia",
                text = {
                    "I am so interesting",
                    "Keep looking at this text"
                }
            },
            PotatoPatchDev_notmario = {
                name = "notmario",
                text = {
                    "TO DO: WRITE FUNNY JOKE"
                }
            },
        }
    },
    misc = {
        dictionary = {
            k_junkset = "Derelict",
            b_junkset_cards = "Derelict Cards",
			k_junkset_pack = "Derelict Pack",
            k_junk_hands = "Junk Hands",
        },
        labels = {
            JunkSet = "Derelict"
        },
        poker_hand_descriptions = {
            ["Junk Hands"] = {
                "Adding Junk Cards to other Poker Hands",
                "increases their base Chips and Mult"
            }
        }
    }
}
