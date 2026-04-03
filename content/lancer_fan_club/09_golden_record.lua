-- Golden Record
SMODS.Joker {
    key = "lfc_golden_record",
    blueprint_compat = false,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 8,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit" },
    pos = { x = 2, y = 1 },
    pixel_size = { w = 69, h = 69 },
    display_size = { w = 69, h = 69 },
    discovered = false,
    config = { extra = { enhancement = "m_gold", card_type = "Spectral", discards = 5, discards_remaining = 5 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.enhancement and
                localize({ type = 'name_text', set = "Enhanced", key = card.ability.extra.enhancement }) or "Gold Card",
                card.ability.extra.card_type and localize("k_" .. string.lower(card.ability.extra.card_type)) or
                localize("k_spectral"),
                card.ability.extra.discards,
                card.ability.extra.discards_remaining,
                colours = {
                    G.C.SECONDARY_SET[card.ability.extra.card_type] or G.C.FILTER
                }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard then
            local do_card_create = false
            if not context.blueprint and SMODS.has_enhancement(context.other_card, card.ability.extra.enhancement) then
                if card.ability.extra.discards_remaining <= 1 then
                    card.ability.extra.discards_remaining = card.ability.extra.discards
                    do_card_create = true
                else
                    card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
                end
            end
            if do_card_create then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = card.ability.extra.card_type,
                                key_append = 'lfc_golden_record' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_' .. string.lower(card.ability.extra.card_type)),
                        G.C.SECONDARY_SET[card.ability.extra.card_type] or G.C.FILTER,
                    }
                end
            end
        end
    end,
}
