if not to_big then to_big = function(val) return val end end

SMODS.Joker({
    key = 'dum_mouthwash',
    config = { extra = { xmult_gain = 0.15, xmult = 1 } },
    unlocked = true,
    rarity = 2,
    atlas = 'DummiesJokers',
    pos = { x = 8, y = 1 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            -- Check for a hand to delevel
            local hands_to_delevel = {}
            for key, hand in pairs(G.GAME.hands) do
                if hand.level > to_big(1) then
                    table.insert(hands_to_delevel, key)
                end
            end
            if #hands_to_delevel == 0 then return end
            local hand_to_delevel = pseudorandom_element(hands_to_delevel, 'dum_mouthwash')
            level_up_hand(card, hand_to_delevel, false, -1)
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_table = card.ability.extra,
                scalar_value = "xmult_gain"
            })
            return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    pixel_size = { w = 45, h = 95 },
    ppu_coder = { "baltdev" },
    ppu_artist = { "ghostsalt" },
    ppu_team = { "dummies" },
    pronouns = "they_them"
})
