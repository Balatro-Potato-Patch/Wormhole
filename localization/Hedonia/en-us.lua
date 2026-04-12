-- I (wombat) used a lot of VanillaRemade as reference throughout this entire file https://github.com/nh6574/VanillaRemade/blob/main/src/tarots.lua https://github.com/nh6574/VanillaRemade/blob/main/localization/en-us.lua
return {
    descriptions = {
        Joker = {
            j_worm_hedonia_casino = {
                name = 'Casino Bartender',
                text = {
                    'meow',
                    'meow meow',
                    'meowww'
                }
            },
            j_worm_hedonia_trash = {
                name = 'Trash Compactor',
                text = {
                    'meow',
                    'meow meow',
                    'meowww'
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
        }
    },
    misc = {
        dictionary={
            b_worm_hedonia_menu_cards = "Tonight's Menu",
            k_worm_hedonia_menu = "Menu Item",
        },
    },
}
