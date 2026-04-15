SMODS.Atlas {
    key = "util_deck",
    path = "util-modders/deck.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "util_stake",
    path = "util-modders/stake.png",
    px = 29,
    py = 29
}
SMODS.Atlas {
    key = "util_tag",
    path = "util-modders/tag.png",
    px = 34,
    py = 34
}
SMODS.Atlas {
    key = "util_extras",
    path = "util-modders/extra.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "util_cargo_space",
    atlas = "util_extras",
    pos = { x = 0, y = 0 },
    rarity = 3,
    blueprint_compat = false,
    cost = 7,
    attributes = {"passive", "space"},
    add_to_deck = function(self, card, from_debuff)
        for i,v in ipairs(SMODS.find_card("j_worm_util_cargo_space")) do
            if v ~= card then return end
        end
        for k,v in ipairs(G.I.CARD) do
            if (v.ability and v.ability.set) == "util_Spaces" then
                if not v.ability.util_cargo_spaced then
                    v.ability.util_cargo_spaced = true
                    v.ability.extra_slots_used = v.ability.extra_slots_used - 1
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for i,v in ipairs(SMODS.find_card("j_worm_util_cargo_space")) do
            if v ~= card then return end
        end
        for k,v in ipairs(G.I.CARD) do
            if (v.ability and v.ability.set) == "util_Spaces" then
                if v.ability.util_cargo_spaced then
                    v.ability.util_cargo_spaced = false
                    v.ability.extra_slots_used = v.ability.extra_slots_used + 1
                end
            end
        end
    end,
}

SMODS.Voucher {
    key = "util_better_craftmanship",
    atlas = "util_extras",
    pos = { x = 1, y = 0 },
}

SMODS.Voucher {
    key = "util_dealer_contact",
    atlas = "util_extras",
    pos = { x = 2, y = 0 },
    requires = { 'v_worm_util_better_craftmanship' },
}

local _add_to_pool = SMODS.add_to_pool
function SMODS.add_to_pool(proto, args)
    if G.GAME.modifiers.void_stake and (proto.set == "Planet") or (proto.set == "Booster" and proto.kind == 'Celestial') then
        --print('no pool')
        return false
    end
    return _add_to_pool(proto, args)
end

SMODS.Stake {
    key = 'util_void',
    atlas = 'util_stake',
    applied_stakes = {'gold'},
    prefix_config = { applied_stakes = { mod = false } },
    modifiers = function ()
        G.GAME.planet_rate = 0
        G.GAME.modifiers.void_stake = true
    end
}

local black_hole_lock = false
SMODS.Back {
    key = 'util_black_hole',
    atlas = 'util_deck',
    config = {
        extra = 1
    },
    loc_vars = function (self, info_queue, card)
        return { vars = { self.config.extra } }
    end,

    calculate = function (self, back, context)
        if context.poker_hand_changed and not black_hole_lock and context.new_level > context.old_level then
            --print('levelup hand', context.scoring_name, context.old_level, context.new_level, back.effect.config.extra)
            black_hole_lock = true
            SMODS.smart_level_up_hand(context.card, context.scoring_name, false, back.effect.config.extra)
            black_hole_lock = false
        end
    end
}

SMODS.Tag {
    key = 'util_pod_pack',
    atlas = 'util_tag',
    pos = { x = 0, y = 0 },

    apply = function (self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_worm_util_spaces_mega', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
