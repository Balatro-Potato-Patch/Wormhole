-- I (wombat) used a lot of VanillaRemade as reference throughout this entire file https://github.com/nh6574/VanillaRemade/blob/main/src/tarots.lua https://github.com/nh6574/VanillaRemade/blob/main/localization/en-us.lua
return {
    descriptions = {
        Back = {
            b_worm_hedonia_bar = {
                name = 'Space Bar',
                text = {
                    'Start with a random',
                    '{C:attention}Bartender{} Joker'
                }
            }
        },
        Joker = {
            j_worm_hedonia_casino = {
                name = 'Casino Bartender',
                text = {
                    {
                        'Played {C:edition}{E:2}Tipsy{}, {C:edition}{E:1}Drunk{}, {C:dark_edition}{E:1}Very Drunk{},',
                        'and {C:dark_edition}Blackout{} cards have',
                        'a {C:green}#1# in #2#{} chance to become',
                        '{C:attention}Lucky Cards{} when scored',
                    },
                    {
                        'Create a {C:attention}Drink{} {C:worm_hedonia_menu}Menu Item{}',
                        'when {C:attention}Blind{} is selected',
                        '{C:inactive}(Must have room)',
                    },            
                }
            },
            j_worm_hedonia_trash = {
                name = 'Trash Compactor',
                text = {
                    '{C:attention}Stores{} all {C:red}destroyed',
                    'cards\' {C:chips}Chips{} until',
                    '{C:attention}Boss Blind{} is defeated',
                    '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)'
                }
            },
            j_worm_hedonia_patron = {
                name = 'Drunken Patron',
                text = {
                    'This Joker gains {C:mult}+#2#{} Mult when a',
                    '{C:edition}{E:2}Tipsy{}, {C:edition}{E:1}Drunk{}, {C:dark_edition}{E:1}Very Drunk{},',
                    'or {C:dark_edition}Blackout{} card is scored',
                    '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)',
                }
            },
            j_worm_hedonia_happy_hour = {
                name = 'Happy Hour',
                text = {
                    {
                        'Earn {C:money}$#2#{} when a',
                        '{C:worm_hedonia_menu}Menu Item{} is used',
                    },
                    {
                        '{C:worm_hedonia_menu}Menu Packs{} cost {C:money}$#1#{} less'
                    }
                }
            },
            j_worm_hedonia_speed = {
                name = 'Sous Chef',
                text = {
                    "{C:green}#1# in #2#{} chance to create a",
                    "{C:attention}Food{} {C:worm_hedonia_menu}Menu Item{} when scoring,",
                    "{C:green}probability{} changes depending on",
                    "number of {C:attention}Jokers{} and {C:attention}Joker Slots{}",
                    '{C:inactive}(Must have room)',
                }
            },
            j_worm_hedonia_bar_mitzvah = {
                name = 'Bar Mitzvah',
                text = {
                    'Creates a {C:worm_hedonia_menu}Menu Item{} after',
                    '{C:attention}#1#{} played and scoring cards',
                    '{C:inactive}(Currently {C:attention}#2#{C:inactive} cards left){}',
                    '{C:inactive,s:0.8}(put Aliyah reading here){}'
                }
            }
        },
        worm_hedonia_menu = {
            c_worm_hedonia_hadron = {
                name = 'Hadron Colada',
                text = {
                    'Add {E:2}Tipsy{} to',
                    'all selected cards'
                }
            },
            c_worm_hedonia_cosmo = {
                name = 'Cosmopolitan',
                text = {
                    'Add {E:1}Drunk{} to',
                    'up to {C:attention}#1#{} selected cards'
                }
            },
            c_worm_hedonia_mojitury = {
                name = 'Mojitury',
                text = {
                    'Add {C:dark_edition,E:1}Very Drunk{} to',
                    'up to {C:attention}#1#{} selected cards'
                }
            },
            c_worm_hedonia_blackHoleBomb = {
                name = 'Black Hole Bomb',
                text = {
                    'Add {C:dark_edition}Blackout{} to',
                    '{C:attention}#1#{} {C:attention}random{} cards held in hand'
                }
            },
            c_worm_hedonia_jawbreaker = {
                name = 'Jawbreaker',
                text = {
                    'Add {C:chips}+#1#{} bonus Chips to a',
                    'random card held in hand'
                }
            },
            c_worm_hedonia_rings = {
                name = 'Satonion Rings',
                text = {
                    'All selected cards {C:attention}sober up{}',
                    '{C:red}OR{} gain {C:money}$#1#{} if there are',
                    'no drunk cards held in hand'
                }
            },
            c_worm_hedonia_debbie = {
                name = 'Cosmic Brownies',
                text = {
                    'Converts up to {C:attention}#1#{} selected cards',
                    'to the same random rank'
                }
            },
            c_worm_hedonia_jam = {
                name = 'Space Jam',
                text = {
                    'Converts up to {C:attention}#1#{} selected cards',
                    'to the same random suit'
                }
            }
        },
        Other = {
            p_worm_hedonia_menu = {
                name = "#3#",
                text = {
                    "Order {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} {C:worm_hedonia_menu}Menu items{} to",
                    "be used immediately"
                }
            },
            undiscovered_worm_hedonia_menu = {
                name = "Not Discovered",
                text = {
                    "Purchase this",
                    "card in an",
                    "unseeded run to",
                    "learn what it does",
                },
            },
        },
        Edition = {
            e_worm_hedonia_tipsy = {
                name = 'Tipsy',
                text = {
                    '{C:green}#1# in #2#{} chance to {C:attention}sober up{}',
                    'whilst held in hand',
                    'Randomize rank and {C:green}#3# in #4#{} chance',
                    'to {C:attention}get drunker{} after scoring',
                    '{C:inactive}(max rank variance: {C:attention}#5#{C:inactive})' },
                label = 'Tipsy'
            },
            e_worm_hedonia_drunk = {
                name = 'Drunk',
                text = {
                    '{C:green}#1# in #2#{} chance to {C:attention}sober up{}',
                    'whilst held in hand',
                    'Randomize rank and {C:green}#3# in #4#{} chance',
                    'to {C:attention}get drunker{} after scoring',
                    '{C:inactive}(max rank variance: {C:attention}#5#{C:inactive})' },
                label = 'Drunk'
            },
            e_worm_hedonia_very_drunk = {
                name = 'Very Drunk',
                text = {
                    '{C:green}#1# in #2#{} chance to {C:attention}sober up{}',
                    'whilst held in hand',
                    'Randomize rank and {C:green}#3# in #4#{} chance',
                    'to {C:attention}get drunker{} after scoring',
                    '{C:inactive}(max rank variance: {C:attention}#5#{C:inactive})' },
                label = 'Very Drunk'
            },
            e_worm_hedonia_blackout = {
                name = 'Blackout',
                text = {
                    '{C:green}#1# in #2#{} chance to {C:attention}sober up{}',
                    'whilst held in hand',
                    '{C:green}#3# in #4#{} chance to {C:red,E:2}self destruct{}',
                    'after scoring',
                },
                label = 'Blackout'
            },
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
            },
            PotatoPatchDev_stanzarorae = {
                name = "Stanza Rorae",
                text = {
                    'Here in spirit',
                    '',
                    'play UNBEATABLE, greatest game of all time',
                }
            }
        }
    },
    misc = {
        dictionary = {
            b_worm_hedonia_menu_cards = "Tonight's Menu",
            k_worm_hedonia_menu = "Menu Item",
            k_worm_hedonia_menu_plus = "+1 Menu Item",
            hedonia_menu = "Tonight's Menu",
            k_lucky = "Lucky",
        },
        labels = {
            worm_hedonia_tipsy = 'Tipsy',
            worm_hedonia_drunk = 'Drunk',
            worm_hedonia_very_drunk = 'Very Drunk',
            worm_hedonia_blackout = 'Blackout'
        },
    },
}
