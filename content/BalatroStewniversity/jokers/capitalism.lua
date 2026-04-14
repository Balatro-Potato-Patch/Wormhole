
SMODS.Joker {

    ppu_team = {'Balatro Stewniversity'},
    ppu_artist = {'dottykitty'},
    ppu_coder = {'PLagger'},

    key = 'worm_stew_capitalism',
    config = {extra = {chips = 250, chips_mod = 50, interest = 5}},
    rarity = "Rare",
    cost = 8,
    atlas = 'stewjokers',
    pos = {x=2, y=2},
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = true,

    update_chips = function (self, card)
        card.ability.extra.chips = card.ability.extra.chips_mod * math.max(0, (math.floor((G.GAME.interest_cap - G.GAME.dollars) / card.ability.extra.interest)))
    end,

    loc_vars = function (self, info_queue, card)
        self:update_chips(card)
        if card.ability.extra.chips >= 750 then
           check_for_unlock({type = 'stew_true_communist'})
        end
        return{
            vars = {card.ability.extra.chips, card.ability.extra.chips_mod, card.ability.extra.interest}
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