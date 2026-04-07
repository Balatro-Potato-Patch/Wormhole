SMODS.Joker {
    key = 'goldilocks',
    atlas = "mrrp",
    pos = {
        x = 4,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = {'space'},
    config = {
        extra = {
            hand = "Three of a Kind",
            seal = 'Gold',
            enhancement = 'm_gold'
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enhancement]
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return {
            vars = {
                localize(card.ability.extra.hand, "poker_hands"),
                localize{type="name_text", set="Enhanced", key=card.ability.extra.enhancement},
                card.ability.extra.seal,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and context.poker_hands and next(context.poker_hands[card.ability.extra.hand]) then
            local target = context.scoring_hand[math.ceil((#context.scoring_hand)/2)]

            target:set_ability('m_gold', nil, true)

            target:set_seal('Gold')

            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.SECONDARY_SET.Planet
            }
        end
    end

}
