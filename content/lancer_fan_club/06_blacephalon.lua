-- Blacephalon
SMODS.Joker {
    key = "lfc_blacephalon",
    blueprint_compat = false,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 2,
    cost = 8,
    atlas = "lfc_jokers",
    ppu_coder = { "J8-Bit" },
    pos = { x = 2, y = 0 },
    discovered = false,
    config = { extra = { dollars = 4 } },
    loc_vars = function(self, info_queue, card)
        local version = pseudorandom_element({ 'us', 'um' }, "lfc_blacephalon")
        local main_start = {}
        if G.GAME.worm_log and G.GAME.worm_log[card.config.center.key] then
            localize { type = 'descriptions', set = 'Other', key = "lfc_dex_blacephalon_" .. version, nodes = main_start, vars = { colours = {
                G.ARGS.LOC_COLOURS["lfc_pkmn_" .. version]
            } } }
        else
            localize { type = 'descriptions', set = 'Other', key = "lfc_obtain_pokemon_warning", nodes = main_start, vars = {} }
        end
        --info_queue[#info_queue + 1] = localize("lfc_dex_blacephalon_" .. version, "dictionary")
        return {
            vars = {
                card.ability.extra.dollars,
                colours = {
                    G.ARGS.LOC_COLOURS["lfc_pkmn_" .. version]
                }
            },
            main_start = main_start
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
