SMODS.ConsumableType{
    key = 'Rocket Part',
    primary_colour = HEX('FFFFFF'),
    secondary_colour = HEX('847F9B'),
    loc_txt = {
        name = 'Rocket Part',
        collection = 'Rocket Parts', -- label for the button to access the collection
        undiscovered = { -- description for undiscovered cards in the collection
            name = 'Not Discovered',
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }       
        },
    },
    shop_rate = 2.0,
    default = "c_worm_thruster"
}

SMODS.Consumable{ --Thruster
    key = 'thruster',
    set = 'Rocket Part',
    loc_txt = {
    name = 'Thruster',
    text = {'Adds {C:dark_edition}Stellar{} edition to',
            'a random {C:attention}Joker{}'
    },
    },
    use = function (self, card, area, copier)
        card:set_edition("worm_stellar", true)
    end

    --[[ placeholder credits until i actually figure out how to do it with the code
        credits:
        art: n/a
        code: PLagger
        team: Balatro Stewniversity
    ]]
}