-- Blacephalon
SMODS.Joker {
    key = "lfc_blacephalon",
    blueprint_compat = true,
    demicoloncompat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 8,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit", "InvalidOS" },
    ppu_artist = {"J8-Bit"},
    ppu_team = { "Lancer Fan Club" },
    pos = { x = 2, y = 0 },
    discovered = false,
    config = { extra = { dollars = 4, shiny=false } },
    attributes = {
        "economy"
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.remove_playing_cards and #context.removed > 0) or context.forcetrigger then
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
    in_pool = function(self, args)
        return G.GAME.lfc_can_blacephalon_appear
    end,
    set_ability = function(self, card, initial, delay_sprites) card.ability.extra.shiny = pseudorandom("lfc_blacephalon_shiny", 1, 16) <= 1 end,
    update = function(self, card, dt) if not Wormhole.LFC_Util.card_obscured(card) then card.children.center:set_sprite_pos({x = card.ability.extra.shiny and 3 or 2, y = 0}) end end,
    dex_entry_key = "lfc_dex_blacephalon",
    generate_ui = Wormhole.LFC_Util.generate_pokedex_entry_ui
}
