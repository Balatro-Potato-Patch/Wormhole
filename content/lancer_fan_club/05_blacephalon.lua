-- Spider Bake Sale
SMODS.Joker {
    key = "spider_bake_sale",
    blueprint_compat = false,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 2,
    cost = 12,
    atlas = "j8jokers",
    pos = { x = 1, y = 5 },
    discovered = false,
    config = { extra = { dollars = 4 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and #context.removed > 0 then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars * #context.removed,
                delay = 0.25,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end,
}
