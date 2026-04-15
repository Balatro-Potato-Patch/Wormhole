return {
    descriptions = {
        Joker = {
            j_worm_ct_laika = {
                name = "Laika",
                text = {
                    "Every {C:attention}space-themed{}",
                    "Joker gives {C:attention}+1{}",
                    "temporary level"
                }
            },
            j_worm_ct_dyson_sphere = {
                name = "Dyson Sphere",
                text = {
                    "Whenever you {C:attention}Clean-up{}, this",
                    "{C:attention}Joker{} gains {C:mult}+#2#{} Mult for",
                    "each card cleaned-up",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive})"
                }
            },
            j_worm_ct_grabberhand = {
                name = "Grabber Hand",
                text = {
                    {
                        "You may pay {C:attention}Clean-up{} costs by",
                        "selecting up to {C:attention}one{} fewer card",
                        "{C:inactive}(Minimum of 1 card)"
                    },
                    {
                        "Whenever you {C:attention}Clean-up{}, get an",
                        "extra {C:blue}hand{} in the next round",
                        "{C:inactive}(Currently {C:blue}#1#{C:inactive} hands)"
                    }
                }
            },
            j_worm_ct_nyan_cat = {
                name = "Nyan Cat",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "per {C:attention}consecutive{} hand",
                    "played with {C:attention}two or more",
                    "unique scoring suits",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_worm_ct_event_horizon = {
                name = {
                    "Event Horizon",
                    "{s:0.5}(Reach for the Sun and Burn! Burn! Burn!)"
                },
                text = {
                    "This Joker interrupts all",
                    "hand {C:attention}level-ups{} and redirects",
                    "them to the {C:attention}next played{} hand",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive} levels stored){}"
                }
            },
            j_worm_ct_event_horizon_fake = {
                name = "The Witless"
            },
            j_worm_ct_quantum_tunneling = {
                name = "Quantum Tunnelling",
                text = {
                    "{C:green}#1#{} to all {C:attention}listed{} {C:green,E:1,S:1.1}probabilities{}",
                    "When you {C:attention}Clean-up{}, increase this by",
                    "{C:green}#2#{} for each card cleaned-up",
                }
            },
            j_worm_ct_tesla_in_space = {
                name = "Joker in Space",
                text = {
                    "When you {C:attention}Clean-up{}, earn {C:gold}$#1#",
                    "for each card cleaned-up",
                }
            },
        },
        Enhanced = {
            m_worm_ct_junk_card = {
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
            -- i lowkey hate this but whatever
            m_worm_ct_junk_card_mult = {
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
            m_worm_ct_junk_card_ringularity = {
                name = "Junk",
                text = {
                    {
                        "No rank or suit,",
                        "always scores",
                    },
                    {
                        "{C:chips}+#1#{} Chips",
                        "{X:mult,C:white}X#5#{} Mult",
                        "Earn {C:gold}+$#6#{}",
                        "Retrigger this",
                        "card {C:attention}#3#{} time#4#"
                    }
                }
            },
            m_worm_ct_junk_card_mult_ringularity = {
                name = "Junk",
                text = {
                    {
                        "No rank or suit,",
                        "always scores",
                    },
                    {
                        "{C:chips}+#1#{} Chips",
                        "{C:mult}+#2#{} Mult",
                        "{X:mult,C:white}X#5#{} Mult",
                        "Earn {C:gold}+$#6#{}",
                        "Retrigger this",
                        "card {C:attention}#3#{} time#4#"
                    }
                }
            },
        },
        JunkSet = {
            c_worm_ct_asteroid_harvester = {
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
            c_worm_ct_solar_sail = {
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
            c_worm_ct_abandoned_wrench = {
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
            c_worm_ct_lost_pliers = {
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
            c_worm_ct_manhole_cover = {
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
            c_worm_ct_starfish_prime = {
                name = "Starfish Prime",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Cards{} into",
                        "{C:attention}Junk Cards"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} Played hands with",
                        "{C:attention}Junk Cards{} gain an additional {X:worm_c3_junkset,C:white}+X#3#{}",
                        "multiplier to {C:chips}Chips{} and {C:mult}Mult{}, then",
                        "destroy {C:attention}#4#{} random {C:attention}cleaned-up cards{}",
                    }
                }
            },
            c_worm_ct_busted_3d_printer = {
                name = "Busted 3D Printer",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Card{} into",
                        "a {C:attention}Junk Card"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} Copy each of",
                        "the {C:attention}cleaned-up cards",
                    }
                }
            },
            c_worm_ct_trash_compactor = {
                name = "Trash Compactor",
                text = {
                    {
                        "Convert {C:attention}#1#{} selected",
                        "non-{C:attention}Junk Cards{} into",
                        "{C:attention}Junk Cards"
                    },
                    {
                        "Clean-up {C:attention}#2#{} {f:6}—{} Merge the {C:attention}cleaned-up",
                        "{C:attention}cards{} into a singular {C:attention}Junk Card{}",
                        "with added values",
                        "{C:inactive}(Retriggers excluded)",
                    }
                }
            },
        },
        Spectral = {
            c_worm_ct_accretion_disk = {
                name = "Accretion Disk",
                text = {
                    {
                        "Convert all non-{C:attention}Junk Cards{} in hand",
                        "into {C:attention}Junk Cards",
                    },
                    {
                        "ALL current and future {C:attention}Junk Cards{}",
                        "gain {X:mult,C:white}X#1#{} Mult and {C:gold}+$#2#{}",
                    },
                    {
                        "Played hands with {C:attention}Junk Cards{}",
                        "gain an additional {X:worm_c3_junkset,C:white}+X#3#{} multiplier",
                        "to {C:chips}Chips{} and {C:mult}Mult{}"
                    }
                }
            },
        },
        Back = {
            b_worm_ct_decrepit_deck = {
                name = "Decrepit Deck",
                text = {
                    "Start run with each {C:attention}face",
                    "{C:attention}card{} as a {C:attention,T:m_worm_ct_junk_card}Junk Card",
                },
            },
        },
        -- Voucher = {
        --     v_worm_fuel_efficiency = {
        --         name = "Fuel Efficiency",
        --         text = {
        --             "You may pay {C:attention}Clean-up{} costs by",
        --             "selecting up to {C:attention}one{} fewer card",
        --             "{C:inactive}(Minimum of 1 card)"
        --         }
        --     },
        --     v_worm_the_final_frontier = {
        --         name = "The Final Frontier",
        --         text = {
        --             "For every {C:attention}#1#{} {C:attention}Junk Cards",
        --             "scored, create a random {C:planet}Planet",
        --             "{C:inactive}(Must have room, currently #2#/#1#)"
        --         }
        --     },
        -- },
        Tag = {
            tag_worm_ct_derelict = {
                name = "Derelict Tag",
                text = {
                    "Gives a free",
                    "{C:worm_c3_junkset}Mega Derelict Pack",
                },
            },
        },
        Other = {
			p_worm_ct_junkset_normal = {
				name = "Derelict Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:worm_c3_junkset}Derelict{} cards to",
					"be used immediately",
				},
			},
			p_worm_ct_junkset_jumbo = {
				name = "Jumbo Derelict Pack",
				text = {
					"Choose {C:attention}#1#{} of up to",
					"{C:attention}#2#{} {C:worm_c3_junkset}Derelict{} cards to",
					"be used immediately",
				},
			},
			p_worm_ct_junkset_mega = {
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
            },
            worm_clean_up_reminder = {
                name = "Clean-up",
                text = {
                    "To {C:attention}Clean-up{}, use {C:worm_c3_junkset}Derelict{}",
                    "cards on {C:attention}Junk Cards{}"
                }
            },
        },
        PotatoPatch = {
            PotatoPatchTeam_colon_three = {
                name = ":3"
            },
            PotatoPatchDev_lordruby = {
                name = "lord.ruby",
                text = {
                    "And an angel came down to me. it put its hand",
                    "on my shoulder. Softer than the finest fabrics",
                    "I have ever felt; and the angel spoke out to me",
                    '"OMG it\'s the {C:worm_ruby}creator{} of {C:worm_entropy,E:1}Entropy{}, I\'m such a big fan"',
                    "in its pretty, {C:worm_entropy,E:1}gay{} little voice."
                }
            },
            PotatoPatchDev_nxkoo = {
                name = "N____",
                text = {
                    "Apathy."
                }
            },
            PotatoPatchDev_meta = {
                name = "Meta",
                text = {
                    { "wruff wruff :3" },
                    {
                        "did some code and a little",
                        "bit of art, as well as a good",
                        "amount of conceptual work"
                    },
                    {
                        "still hard at work",
                        "on Quintessence"
                    }
                }
            },
            PotatoPatchDev_ophelia = {
                name = "ivy",
                text = {
                    "mysterious puppygirl who {X:pure_black,C:pure_black}nothing",
                    "i did some art!",
                    "Find me at",
                    "https://{X:pure_black,C:pure_black}aaaaaaa{}.com/{X:pure_black,C:pure_black}meowmeow{}"
                }
            },
            PotatoPatchDev_notmario = {
                name = "notmario",
                text = {
                    {
                        "this {C:spectral}hexes{} me"
                    },
                    {
                        "i did a lot of art and code",
                        "and came up with the {C:worm_c3_junkset}Derelict",
                        "cards' mechanic"
                    },
                    {
                        "{f:worm_emoji}🙂{} Hello I am John Balatro",
                        "Please play Numbergem"
                    }
                }
            },
        }
    },
    misc = {
        quips = {
            worm_c3_mf_junk_1 = {"That run was {C:worm_c3_junkset}trash{}!"},
            worm_c3_mf_junk_2 = {"That run was {C:worm_c3_junkset}garbage{}!"},
            worm_c3_mf_junk_3 = {"That run was {C:worm_c3_junkset}rubbish{}!"},
            worm_c3_mf_junk_4 = {"You {C:worm_c3_junkset}wasted{} that run..."},
            worm_c3_mf_junk_5 = {"That run went to {C:worm_c3_junkset}the dump{}!"},
            worm_c3_mf_junk_6 = {"That run was a lot of {C:worm_c3_junkset}junk{}!"},
        },
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
        },
        challenge_names = {
            c_worm_ct_junk_it_up = "Junk it Up!",
        },
        v_text = {
            ch_c_clear_out_junk = { "If deck contains {C:attention}Junk Cards{} when {C:attention}Final Boss Blind{}" },
            ch_c_clear_out_junk_2 = { "is selected, immediately {C:red}lose the game" },
            ch_c_increase_derelict_rate = { "{C:worm_c3_junkset}Derelict Packs{} are {X:spectral,C:white}X3{} as common" },
        },
    }
}
