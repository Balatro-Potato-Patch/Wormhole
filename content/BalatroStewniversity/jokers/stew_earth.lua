
SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "Wingcap" },
    ppu_coder = { "PLagger" },

    key = 'stew_stew_earth', -- haha
    config = {extra = {Xmult = 1.5, Xmult_up = 0.5, Xmult_down = 0.25}},
    rarity = "Uncommon",
    cost = 8,
    atlas = 'stewjokers',
    pos = {x=1, y=0},
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        return{
            vars = {card.ability.extra.Xmult, card.ability.extra.Xmult_up, card.ability.extra.Xmult_down}
        }
    end,

    calculate = function (self, card, context)
        if context.after and not context.blueprint then
            if SMODS.last_hand_oneshot then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_up

                return{
                    message = localize('k_worm_stew_cook'),
                    -- message = (localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_up}} .. ' Gained'),
                    colour = G.C.RED,
                }
                
            elseif card.ability.extra.Xmult - card.ability.extra.Xmult_down <= 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return{
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_down
                return{
                    message = localize('k_worm_stew_uncook'),
                    -- message = localize{type = 'variable', key = 'a_xmult_minus', vars = {card.ability.extra.Xmult_down}},
                    colour = G.C.RED,
                }
            end
        end

        if context.joker_main then
            check_for_unlock({type = 'stew_stew', value = card.ability.extra.Xmult })
            return{
                    xmult = card.ability.extra.Xmult
            }
        end
    end

    --art by wingy, code by plagger
}
