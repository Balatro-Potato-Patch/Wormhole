SMODS.Consumable {
    key = 'acme_ray_gun',
    atlas = Atlas_AcmeGadgets.key,
    set = 'ACME_Gadget',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    ppu_coder = { 'Basil_Squared' },
    ppu_artist = { 'RadiationV2' },
    config = { extra = { cards_sold = 0, sold_threshold = 4 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.sold_threshold,
                card.ability.extra.cards_sold
            }
        }
    end,
    can_use = function(self, card)
        return card.ability.extra.cards_sold >= card.ability.extra.sold_threshold
    end,

    calculate = function(self, card, context)
        if context.selling_card and context.card ~= card then
            card.ability.extra.cards_sold = card.ability.extra.cards_sold + 1
            card_eval_status_text(card, 'extra', nil, nil, nil,
                {
                    message = card.ability.extra.cards_sold .. '/' .. card.ability.extra.sold_threshold,
                    colour = G.C
                        .FILTER
                })
            card:juice_up(0.3, 0.5)
        end
    end,

    use = function(self, card, area, copier)
        local temp_pool = {}
        for k, v in ipairs(G.jokers.cards) do
            if not v.edition then table.insert(temp_pool, v) end
        end

        if #temp_pool > 0 then
            local target = pseudorandom_element(temp_pool, pseudoseed('wormhole_target'))
            local edition_key = SMODS.poll_edition({
                key = 'wormhole_edition' .. G.GAME.round_resets.ante,
                guaranteed = true
            })

            -- Use G.E_MANAGER:add_event for the animation queue
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    target:set_edition(edition_key, true)
                    target:juice_up(0.5, 0.5)
                    return true
                end
            }))
        end
    end


}
