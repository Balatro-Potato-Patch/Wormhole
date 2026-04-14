if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "ct_nyan_cat",
    atlas = "ct_nyan_cat",
    pos = { x = 0, y = 0 },
    config = { extra = { chips = 0, chips_mod = 15 } },
    rarity = 1,
    cost = 4,
    attributes = { "space", "suit", "chips", "scaling", "reset" },
    ppu_artist = { "ophelia", "meta" },
    ppu_coder = { "notmario" },
    ppu_team = { ":3" },

    perishable_compat = false,

    loc_vars = function(self, q, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local suits = {}
            for suit, _ in pairs(SMODS.Suits) do
                suits[suit] = 0
            end
            for i = 1, #context.scoring_hand do
                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                    for suit, _ in pairs(suits) do
                        if context.scoring_hand[i]:is_suit(suit, true) and suits[suit] == 0 then
                            suits[suit] = suits[suit] + 1
                            break
                        end
                    end
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_any_suit(context.scoring_hand[i]) then
                    for suit, _ in pairs(suits) do
                        if context.scoring_hand[i]:is_suit(suit) and suits[suit] == 0 then
                            suits[suit] = suits[suit] + 1
                            break
                        end
                    end
                end
            end
            local nonzero_count = 0
            for _, count in pairs(suits) do
                if count > 0 then nonzero_count = nonzero_count + 1 end
            end
            if nonzero_count < 2 then
                local last_chips = card.ability.extra.chips
                card.ability.extra.chips = 0
                if last_chips > 0 then
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    message_key = "a_chips",
                    message_colour = G.C.CHIPS,
                })
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
