SMODS.Joker({
    key = 'riverboat_hawking',
    atlas = 'worm_jokers',
    pos = { x = 1, y = 1 },
    rarity = 3, -- Rare
    cost = 10,
    blueprint_compat = true,
    discovered = true,
    config = { extra = { x_chips = 1, gain = 0.25 } },
    ppu_coder = { "fooping" },
    ppu_artist = { "fooping" },
    ppu_team = { "riverboat" },
    attributes = { "chips", "scaling", "destroy_card", "space" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.x_chips > 1 then
            return {
                message = 'X' .. number_format(card.ability.extra.x_chips),
                Xchip_mod = card.ability.extra.x_chips,
                colour = G.C.CHIPS
            }
        end

        -- Triggered by card destruction
        if (context.remove_playing_cards or context.destroyed_card or context.remove_card) and not context.blueprint then
            local count = #(context.removed or { 1 })
            card.ability.extra.x_chips = card.ability.extra.x_chips + (card.ability.extra.gain * count)
            return {
                message = 'Upgrade!',
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
})
