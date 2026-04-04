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
                    "each card cleaned up",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive})"
                }
            },
        },
        Enhanced = {
            m_worm_junk_card = {
                name = "Junk",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "No rank or suit,",
                    "always scores,",
                    "retrigger this",
                    "card {C:attention}#3#{} time#4#"
                }
            },
            m_worm_junk_card_mult = {
                name = "Junk",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:mult}+#2#{} Mult",
                    "No rank or suit,",
                    "always scores,",
                    "retrigger this",
                    "card {C:attention}#3#{} time#4#"
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
                        "{C:inactive,s:0.8}(You may use this on #2# Junk Cards,",
                        "{C:inactive,s:0.8}if you do, remove their enhancement",
                        "{C:inactive,s:0.8}and trigger this effect instead)",
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
                        "cleaned-up cards an {C:dark_edition}Edition",
                        "{C:inactive,s:0.8}(You may use this on #2# Junk Cards,",
                        "{C:inactive,s:0.8}if you do, remove their enhancement",
                        "{C:inactive,s:0.8}and trigger this effect instead)",
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
                        "{C:inactive,s:0.8}(You may use this on #2# Junk Cards,",
                        "{C:inactive,s:0.8}if you do, remove their enhancement",
                        "{C:inactive,s:0.8}and trigger this effect instead)",
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
                        "{C:inactive,s:0.8}(You may use this on #2# Junk Cards,",
                        "{C:inactive,s:0.8}if you do, remove their enhancement",
                        "{C:inactive,s:0.8}and trigger this effect instead)",
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
                        "{C:inactive,s:0.8}(You may use this on #2# Junk Cards,",
                        "{C:inactive,s:0.8}if you do, remove their enhancement",
                        "{C:inactive,s:0.8}and trigger this effect instead)",
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
                        "multiplier to {C:chips}Chips{} and {C:mult}Mult",
                        "{C:inactive,s:0.8}(You may use this on #2# Junk Cards,",
                        "{C:inactive,s:0.8}if you do, remove their enhancement",
                        "{C:inactive,s:0.8}and trigger this effect instead)",
                    }
                }
            }
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
        },
        labels = {
            JunkSet = "Derelict"
        },
    }
}
