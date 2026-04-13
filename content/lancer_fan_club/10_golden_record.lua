-- Shader
SMODS.Shader {
    key = 'lfc_golden_record',
    path = 'lfc_golden_record.fs',

    send_vars = function(sprite, card)
        return {
            card_size = (card and { card.config.center.pixel_size.w, card.config.center.pixel_size.h }) or { 71, 95 }
        }
    end

}

-- Golden Record
SMODS.Joker {
    key = "lfc_golden_record",
    blueprint_compat = false,
    demicoloncompat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 8,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit" },
    ppu_artist = { "J8-Bit" },
    ppu_team = { "Lancer Fan Club" },
    pos = { x = 2, y = 1 },
    pixel_size = { w = 69, h = 69 },
    display_size = { w = 69, h = 69 },
    discovered = false,
    config = { extra = { enhancement = "m_gold", card_type = "Spectral", discards = 15, discards_remaining = 15 } },
    attributes = {
        "enhancements",
        "discards",
        "spectral",
        "generation"
    },
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
        local function _create_spectral()
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = card.ability.extra.card_type,
                            key_append = 'lfc_golden_record'
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
                return _create_spectral()
            end
        end

        if context.forcetrigger then
            return _create_spectral()
        end
    end,
    in_pool = function(self, args)
        for _, card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(card, "m_gold") then
                return true
            end
        end
    end,
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('worm_lfc_golden_record', nil, card.ARGS.send_to_shader)
        end
    end,
}
