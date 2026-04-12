Wormhole.LancerFanClub.card_triggers_queued = {}
Wormhole.LancerFanClub.spacebar_timing_windows = {
    -- how much time you have to hit that window, in seconds
    3 / 60,  -- perfect
    5 / 60,  -- great
    7 / 60,  -- good
    9 / 60,  -- ok
    11 / 60, -- near miss
}

-- everything here likely needs to be redone from scratch but idk
local scms = SMODS.score_card
function SMODS.score_card(card, context, ...)
    if card.area == G.play or context.cardarea == G.play and not context.end_of_round and #SMODS.find_card("j_worm_lfc_spacebar") > 0 then
        Wormhole.LancerFanClub.do_spacebar_minigame = true
    end
    local ret = scms(card, context, ...)
    Wormhole.LancerFanClub.do_spacebar_minigame = nil
    return ret
end

SMODS.Joker {
    key = "lfc_spacebar",
    atlas = "lfc_jokers",
    pos = { x = 1, y = 2 },
    pixel_size = { w = 23, h = 95 },
    display_size = { w = 23, h = 95 },

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
            context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 1) +
                card.ability.extra.max_xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end,

    ppu_artist = { "J8-Bit" },
    ppu_team = { "Lancer Fan Club" },
    
    update = function(self, card, dt) if not Wormhole.LFC_Util.card_obscured(card) then card.children.center:set_sprite_pos({x = love.keyboard.isDown("space")and 2 or 1, y = 2}) end end
}