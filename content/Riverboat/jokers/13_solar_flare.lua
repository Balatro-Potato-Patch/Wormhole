SMODS.Joker({
    key = 'riverboat_solar_flare',
    atlas = 'worm_jokers',
    pos = { x = 0, y = 1 },
    rarity = 3, -- Rare
    cost = 10,
    blueprint_compat = true,
    discovered = true,
    config = { extra = { x_mult = 3, active = false } },
    ppu_coder = { "fooping" },
    ppu_artist = { "camo" },
    ppu_team = { "riverboat" },
    attributes = { "xmult", "planet", "spectral", "space" },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, (card.ability.extra.active and '' or 'not ') } }
    end,
    calculate = function(self, card, context)
        -- Activate on Planet or Spectral use
        if (context.using_consumeable and (context.consumeable.ability.set == 'Planet' or context.consumeable.ability.set == 'Spectral')) then
            card.ability.extra.active = true
            return {
                message = 'Active!',
                colour = G.C.SECONDARY_SET.Planet,
                card = card
            }
        end

        -- Trigger on the next hand
        if context.joker_main and card.ability.extra.active then
            return {
                message = localize({ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }),
                Xmult_mod = card.ability.extra.x_mult
            }
        end

        -- Burn out after hand
        if context.after and card.ability.extra.active then
            card.ability.extra.active = false
        end
    end
})
