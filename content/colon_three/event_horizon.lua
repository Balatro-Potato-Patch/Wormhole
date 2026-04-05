if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "event_horizon",
    --atlas = "ct_jokers",
    --pos = { x = 0, y = 0 },
    config = { extra = { levels = 0 } },
    attributes = { "space", "hand_type" },
    ppu_coder = { "meta" },
    ppu_team = { ":3" },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels } }
    end,
    calculate = function(self, card, context)
        if context.before and card.ability.extra.levels > 0 then
            SMODS.upgrade_poker_hands({
                hands = context.scoring_name,
                level_up = card.ability.extra.levels,
                from = card
            })
            card.ability.extra.levels = 0
            return nil, true
        end
    end
}

local upgrade_hands_ref = SMODS.upgrade_poker_hands
SMODS.upgrade_poker_hands = function(args)
    if (not args.from or args.from.config.center.key ~= "j_worm_event_horizon") and next(SMODS.find_card("j_worm_event_horizon")) then
        for i, v in ipairs(SMODS.find_card("j_worm_event_horizon")) do
            v.ability.extra.levels = v.ability.extra.levels + (args.level_up or 1)
        end
    else
        upgrade_hands_ref(args)
    end
end
