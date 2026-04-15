-- I (wombat) used a lot of VanillaRemade as reference throughout this entire file https://github.com/nh6574/VanillaRemade/blob/main/src/tarots.lua https://github.com/nh6574/VanillaRemade/blob/main/localization/en-us.lua
return {
    descriptions = {
        Back = {
            b_worm_hedonia_bar = {
                name = 'Space Bar',
                text = {
                    'Start with a random',
                    'bartender joker'
                }
            }
        },
        Joker = {
            j_worm_hedonia_casino = {
                name = 'Casino Bartender',
                text = {
                    'Add Drunk to Lucky Cards',
                    'Creates Menu Items',
                    'when Lucky Card triggers',
                }
            },
            j_worm_hedonia_trash = {
                name = 'Trash Compactor',
                text = {
                    'stores the chips of all',
                    'destroyed playing cards until',
                    'the start of the next ante',
                    '{C:inactive}(Currently +{C:chips}#1#{C:inactive} chips)'
                }                
            },
            j_worm_hedonia_patron = {
                name = 'Drunken Patron',
                text = {
                    '{C:mult}+#1#{} Mult for every',
                    'Tipsy, Drunk, Very Drunk,',
                    'or Blackout card held in hand'
                }
            },
            j_worm_hedonia_happy_hour = {
                name = 'Happy Hour',
                text = {
                    'Menu Items cost {C:money}$#1#{} less'
                }
            },
            j_worm_hedonia_speed = {
                name = 'Speed Bartender',
                text = {
                    'creates a menu item during scoring',
                    'based on how many jokers you have',
                    '{C:inactive} currently {C:green}#1# in #2#{C:inactive} chance{}'
                }
            },
            j_worm_hedonia_bar_mitzvah = {
                name = 'Bar Mitzvah',
                text = {
                    'creates a menu item',
                    'after {C:attention}#1#{} played hands',
                    '{C:inactive} currently {C:attention}#2#{C:inactive} hands left{}'
                }
            }
        },
        worm_hedonia_menu={
            c_worm_hedonia_hadron = {
                name = 'Hadron Colida',
                text = {
                    'Add Tipsy to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_cosmo = {
                name = 'Cosmopolitan',
                text = {
                    'Add Drunk to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_mojitury = {
                name = 'Mojitury',
                text = {
                    'Add Very Drunk to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_blackHoleBomb = {
                name = 'Black Hole Bomb',
                text = {
                    'Add Blackout to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_jawbreaker = {
                name = 'Jupiter Jawbreakers',
                text = {
                    'Add {C:chips}#1#{} bonus Chips to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_rings = {
                name = 'Saturn\'s Onion Rings',
                text = {
                    'All cards held in',
                    'hand sober up',
                    '{s:0.8}{C:inactive}(must be drunk)'
                }
            },
            c_worm_hedonia_debbie = {
                name = 'Cosmic Brownies',
                text = {
                    'Converts {C:attention}#1#{} selected cards',
                    'to the same random rank'
                }
            },
            c_worm_hedonia_jam = {
                name = 'Space Jam',
                text = {
                    'Converts {C:attention}#1#{} selected cards',
                    'to the same random suit'
                }
            }
        },
        Other = {
            p_worm_hedonia_menu = {
                name = "#3#",
                text = {
                    "Order {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} Menu items to",
                    "be used immediately"
                }
            }
        },
        PotatoPatch = {
            PotatoPatchTeam_Hedonia = {
                name = "Hedonia"
            },
            PotatoPatchDev_alxndr = {
                name = "Alxndr",
                text = {
                    'a'
                }
            },
            PotatoPatchDev_axyraandas = {
                name = "Axyraandas",
                text = {
                    'a'
                }
            },
            PotatoPatchDev_hellboydante = {
                name = "Dante",
                text = {
                    'a'
                }
            },
            PotatoPatchDev_professorrenderer = {
                name = "Professor Renderer",
                text = {
                    'This is my first ever mod jam!',
                    'I did the card text and also came up',
                    'with the names for the drinks and concepts',
                    'for the jokers. I\'m happy with everyone\'s work',
                    'and I hope you enjoyed what we came up with!'
                }
            },
            PotatoPatchDev_qunumeru = {
                name = "Qunumeru",
                text = {
                    'a'
                }
            },
            PotatoPatchDev_wombatcountry = {
                name = "Wombat Country",
                text = {
                    'a'
                }
            }
        }
    },
    misc = {
        dictionary={
            b_worm_hedonia_menu_cards = "Tonight's Menu",
            k_worm_hedonia_menu = "Menu Item",
        }
    },
}
