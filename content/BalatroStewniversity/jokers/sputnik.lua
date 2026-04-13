SMODS.Joker{ --Sputnik

    ppu_team = {'Balatro Stewniversity'},
    ppu_artist = {''},
    ppu_coder = {'PLagger'},

    key = 'worm_stew_sputnik',
    config = {extra = {chips = 250, chips_mod = 50}},
    rarity = 3,
    cost = 8,
    atlas = 'stewjokers',
    pos = {x=6, y=9},
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = true,

    update_chips = function (self, card)
        card.ability.extra.chips = card.ability.extra.chips_mod * math.max(0, (math.floor((G.GAME.interest_cap - G.GAME.dollars) / 5)))
    end,

    loc_vars = function (self, info_queue, card)
        self:update_chips(card)
        return{
            vars = {card.ability.extra.chips, card.ability.extra.chips_mod}
        }
    end,

    calculate = function (self, card, context)
        if context.joker_main then
            self:update_chips(card)
            return{
                chips = card.ability.extra.chips
            }
        end
    end

}