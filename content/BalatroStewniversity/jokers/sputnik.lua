SMODS.Joker {

    ppu_team = {'Balatro Stewniversity'},
    ppu_artist = {'Wingcap'},
    ppu_coder = {'stupxd'},

    key = 'worm_stew_sputnik',
    config = {extra = {mult = 0, mult_mod = 2, dollars = 30}},
    rarity = "Rare",
    cost = 8,
    atlas = 'stewjokers',
    pos = {x=3, y=2},
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = true,

    update_mult = function (self, card)
        card.ability.extra.mult = card.ability.extra.mult_mod * math.max(0, card.ability.extra.dollars - (G.GAME.dollars + (G.GAME.dollar_buffer or 0)))
    end,

    loc_vars = function (self, info_queue, card)
        self:update_mult(card)
        return {
            vars = {card.ability.extra.mult_mod, card.ability.extra.dollars, card.ability.extra.mult}
        }
    end,

    calculate = function (self, card, context)
        if context.joker_main then
            self:update_mult(card)
            return {
                mult = card.ability.extra.mult
            }
        end
    end

}