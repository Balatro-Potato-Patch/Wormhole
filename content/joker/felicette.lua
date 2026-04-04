SMODS.Joker {
    key = 'felicette',
    atlas = "mrrp_j",
    pos = {
        x = 3,
        y = 0
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            chips = 0,
            chips_mod = 14,
            hands = {}
        }
    },
    loc_vars = function(self, info_queue, card)
        local chips = card.ability.extra.chips
        local upgrades = 0
        local scalar = card.ability.extra.chips_mod
        local indeck = false
        for _, v in pairs(SMODS.get_card_areas('jokers')) do
            if card.area == v then
                indeck = true
            end
        end
        if not indeck then
            for _, v in pairs(G.GAME.hands) do
                if v.level and v.level > 1 then
                    upgrades = upgrades + 1
                end
            end
        end
        return {
            vars = {scalar, not indeck and upgrades * scalar or chips}
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.hands) do
            if v.level and v.level > 1 then
                card.ability.extra.hands[k] = true
                SMODS.scale_card(card, {
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    no_message = true
                })
            end
        end
    end,

    calculate = function(self, card, context)
        if context.poker_hand_changed and context.old_level and context.new_level and not context.blueprint then
            if context.new_level > 1 and not card.ability.extra.hands[context.scoring_name] then
                card.ability.extra.hands[context.scoring_name] = true
                SMODS.scale_card(card, {
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    message_colour = G.C.SECONDARY_SET.Planet
                })
            elseif context.new_level <= 1 and card.ability.extra.hands[context.scoring_name] then
                card.ability.extra.hands[context.scoring_name] = nil
                local scable = {
                    ["chips_mod"] = -card.ability.extra.chips_mod
                }
                SMODS.scale_card(card, {
                    ref_value = "chips",
                    scalar_table = scable,
                    scalar_value = "chips_mod",
                    scaling_message = {
                        message = localize("k_downgrade_ex"),
                        colour = G.C.SECONDARY_SET.Planet
                    }
                })
            end
        end
        if context.joker_main and card.ability.extra.chips ~= 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
