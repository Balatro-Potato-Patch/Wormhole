SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty" },
    ppu_coder = { "PLagger" },

    key = 'stew_staged_landing',
    config = {extra = {mult = 0, mult_mod = 4}},
    rarity = 1,
    cost = 4,
    atlas = 'stewjokers',
    pos = {x=0, y=0},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        return {
            vars = {card.ability.extra.mult, card.ability.extra.mult_mod}
            }
        end,
    
    calculate = function (self, card, context)
        if context.discard and not context.blueprint and not context.other_card.debuff and context.other_card:is_suit('Clubs') then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return{
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}},
                colour = G.C.RED,
                delay = 0.45
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval
            and not context.blueprint and card.ability.extra.mult > 0 then
            card.ability.extra.mult = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end

        if context.joker_main then
            return{
                mult = card.ability.extra.mult
            }
        end
    end
}
