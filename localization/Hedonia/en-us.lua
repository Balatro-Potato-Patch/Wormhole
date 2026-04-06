-- I (wombat) used a lot of VanillaRemade as reference throughout this entire file https://github.com/nh6574/VanillaRemade/blob/main/src/tarots.lua https://github.com/nh6574/VanillaRemade/blob/main/localization/en-us.lua
return {
    descriptions = {
        worm_hedonia_menu={
            c_worm_template = {
                name = 'The Sungwon Special',
                text = {
                    'It\'s not easy being Dr. Breen'
                }
            }
        },
        Other = {
            p_worm_hedonia_menu_normal = {
                name = "Menu Pack",
                text = {
                    "order {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} Menu items to",
                    "be used immediately"
                }
            },
            p_worm_hedonia_menu_jumbo = {
                name = "Jumbo Menu Pack",
                text = {
                    "order {C:attention}#1#{} of up to",
                    "{C:attention}#2#{} Menu items to",
                    "be used immediately"
                }
            },
            p_worm_hedonia_menu_mega = {
                name = "Mega Menu Pack",
                text = {
                    "order {C:attention}#1#{} of up to",
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