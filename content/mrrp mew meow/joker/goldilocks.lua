SMODS.Joker {
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Shinku'},
    ppu_coder = {'SarcPot'},
    key = 'mrrp_goldilocks',
    atlas = "mrrp",
    pos = {
        x = 2,
        y = 2
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
                card = context.blueprint and context.blueprint_card or card,
                message_card = context.blueprint and context.blueprint_card or card
            }
        end
    end

}
