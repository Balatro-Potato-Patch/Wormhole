SMODS.Joker { -- :3
    key = 'astro_n',
    rarity = 'worm_otherworldly',
    cost = 30,
    config = {
        extra = {
            multi = 1
        }
    },
    atlas = 'VVjokers',
    pos = {x = 4, y = 1},
    soul_pos = {x = 5, y = 1},
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local planets_used = 0
        for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then planets_used = planets_used + 1 end end
        return { 
            vars = { card.ability.extra.multi, (planets_used + 1) }, 
        }
    end,
    ppu_team = { "Violent Violets" },
    ppu_artist = { "FirstTry" },
    ppu_coder = { "Iso" },
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local planets_used = 0
                    for k, v in pairs(G.GAME.consumeable_usage) do
                        if v.set == 'Planet' then planets_used = planets_used + 1 end
                    end
                    ease_discard(planets_used)
                    ease_hands_played(planets_used)
                    SMODS.calculate_effect(
                        { message = '+' .. tostring(planets_used + 1) .. ' Hands & Discards' },
                        context.blueprint_card or card)
                    return true
                end
            }))
        end
    end
}