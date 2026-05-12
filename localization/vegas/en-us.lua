return {
    descriptions = {
        Joker = {
            j_worm_orbit = {
                name = "Orbit",
		        text = {
			        "Gains {C:mult}+#1#{} Mult when",
			        "scoring a {C:attention}#2#",
			        "Rank decreases after scoring",
			        "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
		        }
            },
            j_worm_spaghettification = {
                name = "Spaghettification",
		        text = {
			        "{C:green}#1# in #2#{} chance to {C:attention}downgrade",
			        "level of played {C:attention}poker hand",
			        "Gains {C:attention}double{} the Mult lost",
			        "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
		        }
            },
            j_worm_hubble = {
                name = "Hubble Space Telescope",
		        text = {
			        "{C:attention}+#2#{} hand size",
			        "Gains {C:attention}+#1#{} hand size for",
			        "every {C:attention}#4#{} {C:planet}Planet{} cards used",
			        "{C:attention}#3#{} {C:inactive}Planet cards left"
		        }
            },
            j_worm_gravity_assist = {
                name = "Gravity Assist",
		        text = {
			        "{C:green}#1# in #2#{} chance to create an",
			        "{C:attention}inferior{} {C:planet}Planet{} card",
			        "when a {C:planet}Planet{} card is used",
			        "{C:inactive}(Must have room)"
		        }
            },
            j_worm_astronaut = {
                name = "Astronaut",
		        text = {
			        "Earn {C:money}$#1#{} at end of",
			        "round per level of the final",
			        "played {C:attention}poker hand"
		        }
            },
            j_worm_chthonian = {
                name = "Chthonian Planet",
		        text = {
			        "If {C:attention}first discard{} of",
			        "round is {C:attention}#1#{} cards, make",
			        "{C:attention}both{} cards {C:attention}Stone{}"
		        }
            },
            j_worm_goldielocks = {
                name = "Goldielocks",
                text = {
                    "Retriggers middle card in",
			        "hand {C:attention}#2#{} times or",
			        "Retriggers both middle cards in",
			        "hand {C:attention}#1#{} time each"
                }
            },
            j_worm_vegas = {
                name = "Space Vegas",
		        text = {
			        "At the start of the",
			        "round, play {C:attention}space roulette",
			        "If {C:attention}this{} Joker lands face up,",
			        "gain {C:money}$#1#{} for each {C:attention}Joker{}"
		        }
            },
            j_worm_wormhole = {
                name = "Wormhole",
		        text = {
			        "Adds a {C:dark_edition}Negative{} copy of any",
			        "{C:attention}Consumable{} to the bottom of",
			        "your {C:attention}deck{} when it is used"
		        }
            },
            j_worm_inthesky = {
                name = "Diamonds in the Sky",
		        text = {
			        "If first hand of round", 
              "contains {C:attention}#1#{} {V:1}Diamonds{},",
			        "a random card held in hand",
              "becomes {C:dark_edition}Negative{}"
		        }
            },
            j_worm_observable = {
                name = "Observable Universe",
		        text = {
			        "{C:dark_edition}Negative{} playing cards held",
			        "in hand give {X:red,C:white}X#1#{} Mult"
		        }
            },
            j_worm_Big_Bounce = {
                name = "The Big Bounce",
				text = {
					"When {C:attention}Blind {C:red}failed{}",
					"restart your run with",
					"the same {C:green}Seed{}"
				}
            },
			j_worm_bigbang = {
				name = "The Big Bang Theory",
				text = {
					"Sell {C:attention}#1#{} Jokers to store",
					"enough compacted energy to",
					"create a {V:1}Legendary{} Joker"
				}
			}
        },
		Blind = {
			bl_worm_whitehole = {
				name = "White Hole",
				text = {
					"Decrease level of {C:red}all{}",
					"poker hands by 1 when played"
				}
			},
			bl_worm_heatdeath = {
				name = "Heat Death",
				text = {
					"Defeat the blind in",
					"{E:worm_vegas_timer}#1#{}"
				}
			}
		},
		Spectral = {
			c_worm_expanse = {
				name = "Expanse",
				text = {
					"Add {C:dark_edition}Negative{} to up",
					"to {C:attention}#1#{} random cards",
          "in your full deck"
				}
			}
		},
		Planet = {
			c_worm_kepler = {
				name = "Kepler-186 f",
				text = {
					"Permanently adds {C:white,X:mult}X#1#{} Mult",
					"to {C:attention}#2#{} selected cards in hand"
				}
			},
			c_worm_gj = {
				name = "GJ 504 b",
				text = {
					"Permanently adds {C:mult}+#1#{} Mult",
					"to {C:attention}#2#{} selected cards in hand"
				}
			},
			c_worm_wasp = {
				name = "Wasp J1407b",
				text = {
					"Permanently adds {C:chips}+#1#{} Chips",
					"to {C:attention}#2#{} selected cards in hand"
				}
			}
		},
		Back = {
            b_worm_colonist = {
                name = 'Colonist Deck',
                text = {
                    "Start with {C:chips,T:j_banner}Banner{}",
                    "and {C:planet,T:v_planet_merchant}Planet Merchant{}",
                    "Hands start at level {C:attention}0",
                }
            }
        },
		Other = {
            SpaceRoulette = {
                name = "Space Roulette",
		        text = {
			        "Flips all {C:attention}Jokers{}, then cycles",
			        "through unflipping your {C:attention}Jokers",
			        "until {C:attention}one{} is chosen as face up",
			        "After, turns all {C:attention}Jokers{} face up"
		        }
            },
            Inferior = {
                name = "Inferior",
                text = {
                    "The {C:planet}Planets'{} associated",
                    "hand type has less base",
                    "{C:chips}chips{} and {C:mult}mult{} at level 1"
                }
            }
        }
    },
    misc = {
		dictionary = {
			k_vegas_bazinga = "Bazinga!",
		},
    }
}