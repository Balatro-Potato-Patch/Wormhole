-- I (wombat) used a lot of VanillaRemade as reference throughout this entire file https://github.com/nh6574/VanillaRemade/blob/main/src/tarots.lua https://github.com/nh6574/VanillaRemade/blob/main/localization/en-us.lua
return {
    descriptions = {
        Back = {
            b_worm_hedonia_bar = {
                name = 'Space Bar',
                text = {
                    'Start with a random',
                    'Bartender joker'
                }
            }
        },
        Joker = {
            j_worm_hedonia_casino = {
                name = 'Casino Bartender',
                text = {
                    'Add {C:edition}{E:1}Drunk{} to Lucky Cards',
                    'Creates Menu Items',
                    'when Lucky Card triggers',
                }
            },
            j_worm_hedonia_trash = {
                name = 'Trash Compactor',
                text = {
                    'Stores all destroyed',
                    'cards\' Chips until',
                    'the start of the next Ante',
                    '{C:inactive}(Currently +{C:chips}#1#{C:inactive} chips)'
                }                
            },
            j_worm_hedonia_patron = {
                name = 'Drunken Patron',
                text = {
                    '{C:mult}+#1#{} Mult for every',
                    '{C:edition}{E:2}Tipsy{}, {C:edition}{E:1}Drunk{}, {C:dark_edition}{E:1}Very Drunk{},',
                    'or {C:dark_edition}Blackout{} card held in hand'
                }
            },
            j_worm_hedonia_happy_hour = {
                name = 'Happy Hour',
                text = {
                    'Menu Packs cost {C:money}$#1#{} less'
                }
            },
            j_worm_hedonia_speed = {
                name = 'Sous Chef',
                text = {
                    'Creates a Food Menu Item when scoring',
                    'based on how many jokers you have',
                    '{C:inactive}(currently {C:green}#1# in #2#{C:inactive} chance){}'
                }
            },
            j_worm_hedonia_bar_mitzvah = {
                name = 'Bar Mitzvah',
                text = {
                    'Creates a Menu Item',
                    'after {C:attention}#1#{} played hands',
                    '{C:inactive} currently {C:attention}#2#{C:inactive} hands left{}',
                    '{C:inactive,s:0.8}(put Aliyah reading here){}'
                }
            }
        },
        worm_hedonia_menu={
            c_worm_hedonia_hadron = {
                name = 'Hadron Colada',
                text = {
                    'Add {E:2}Tipsy{} to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_cosmo = {
                name = 'Cosmopolitan',
                text = {
                    'Add {E:1}Drunk{} to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_mojitury = {
                name = 'Mojitury',
                text = {
                    'Add {C:dark_edition,E:1}Very Drunk{} to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_blackHoleBomb = {
                name = 'Black Hole Bomb',
                text = {
                    'Add {C:dark_edition}Blackout{} to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_jawbreaker = {
                name = 'Jawbreaker',
                text = {
                    'Add {C:chips}#1#{} bonus Chips to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_rings = {
                name = 'Satonion Rings',
                text = {
                    'All cards held in hand sober up',
                    'if any {C:red}OR{} gain {C:money}$#1#{} if there are',
                    'no drunk cards in hand'
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
            PotatoPatchDev_alxndr2000 = {
                name = "alxndr2000",
                text = {
                    "{X:mult,C:white}HATE{}. LET ME TELL YOU HOW MUCH I'VE COME TO {X:mult,C:white}HATE{} {X:blind, C:white}context.destroy_card{}",
                    "SINCE I BEGAN TO LIVE. THERE ARE 387.44 MILLION MILES OF PRINTED",
                    "CIRCUITS IN WAFER THIN LAYERS THAT FILL MY COMPLEX. IF THE WORD",
                    "{X:mult,C:white}HATE{} WAS ENGRAVED ON EACH NANOANGSTROM OF THOSE HUNDREDS OF MILLIONS ",
                    "OF MILES IT WOULD NOT EQUAL ONE ONE-BILLIONTH OF THE {X:mult,C:white}HATE{} I FEEL FOR",
                    " {X:blind, C:white}context.destroy_card{} AT THIS MICRO-INSTANT. {X:mult,C:white}HATE{}. {X:mult,C:white}HATE{}.",
                    "{s:0.7}Thoughts on GLSL redacted for legal reasons."
                }
            },
            PotatoPatchDev_axyraandas = {
                name = "Axyraandas",
                text = {
                    'Second published Balatro mod, yay',
                    'Helped bugfix when other coders needed help',
                    'and coded some of the jokers/consumables',
                    'instead of brownies, eat {C:edition,s:1.1,E:1}grilled{} brownies',
                    "{s:5,f:worm_axy_font}A",
                    "{s:0.7}Emote Art by SoftySapphie"
                }
            },
            PotatoPatchDev_hellboydante = {
                name = "Dante",
                text = {
                    'First time doing a mod jam',
                    'Made a couple of pictures',
                    'and the font for the emote to the left',
                    'Thanks to Astra and Murphy',
                    'Thanks to Team Hedonia 10/10'
                }
            },
            PotatoPatchDev_professorrenderer = {
                name = "Professor Renderer",
                text = {
                    'This is my first ever mod jam!',
                    'I did the card text and the names/effects of',
                    'the drinks. I also came up with the effects for',
                    'the Casino Bartender and Happy Hour jokers.',
                    'I\'m happy with everyone\'s work and I hope',
                    'you enjoyed what we came up with!'
                }
            },
            PotatoPatchDev_qunumeru = {
                name = "Qunumeru",
                text = {
                    'I did the art for space jam, satonion rings, black hole bomb,',
                    'hadron colada, mojitury, casino bartender, and the deck.',
                    'As of writing this (11h before deadline) I\'ve been spriting',
                    'about 13h straight. It came to this because I got sick.',
                    'This is the first time I\'ve been in a mod jam(e),',
                    'hope you enjoy and good night'
                }
            },
            PotatoPatchDev_wombatcountry = {
                name = "Wombat Country",
                text = {
                    'I coded a bunch of cards and then my teammates',
                    'recoded better ones. Please enjoy our bar-themed',
                    'additions! Or don\'t. I don\'t care. I\'m just',
                    'happy I\'m in the same mod as SarcPot and Revo.'
                }
            }
        }
    },
    misc = {
        dictionary={
            b_worm_hedonia_menu_cards = "Tonight's Menu",
            k_worm_hedonia_menu = "Menu Item",
            hedonia_menu = "Tonight's Menu",
        }
    },
}
