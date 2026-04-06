SMODS.Consumable {
    key = 'acme_ray_gun',
    atlas = Atlas_AcmeGadgets.key,
    set = 'ACME_Gadget',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
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
        end
    end,
    use = function(self, card, area, copier)
        local edition_key = SMODS.poll_edition({
            key = 'WORMHOLE SEED ' .. G.GAME.round_resets.ante .. G.GAME.ROUND 'AEIJFOIJAWFEAQF',
            guaranteed = true
        })
    end


}
