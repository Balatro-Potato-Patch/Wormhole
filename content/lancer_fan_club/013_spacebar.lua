Wormhole.LancerFanClub.card_triggers_queued = {}
Wormhole.LancerFanClub.spacebar_timing_windows = {
    -- how much time you have to hit that window, in seconds
    3/60, -- perfect
    5/60, -- great
    7/60, -- good
    9/60, -- ok
    11/60, -- near miss
}

SMODS.Joker {
    key = "lfc_spacebar",
    --atlas = "lfc_jokers",
    --pos = { x = 4, y = 0 },

    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    demicoloncompat = false,

    config = {
        extra = {
            max_xmult_mod = 0.2,
        }
    },
    attributes = {
        "xmult",
        "space", -- literally!
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.max_xmult_mod
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 1) + card.ability.extra.max_xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end,

    ppu_coder = { "InvalidOS" }
}