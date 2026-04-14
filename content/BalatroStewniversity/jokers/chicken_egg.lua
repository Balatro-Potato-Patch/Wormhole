
SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty", "dottykitty" },
    ppu_coder = { "stupxd" },

    key = 'stew_chicken_egg',
    config = {extra = { Xchips = 3, chicken = false }},
    rarity = "Common",
    cost = 4,
    atlas = 'stewjokers',
    pos = { x=0, y=2 },
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    loc_vars = function (self, info_queue, card)
        return {
            vars = { card.ability.extra.Xchips },
            key = card.ability.extra.chicken and 'j_worm_stew_chicken_egg_alt' or nil
        }
    end,

    in_pool = function(self, args)
        return G.GAME.mass_extinction_event
    end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') then
            if card.ability.extra.chicken then
                card.children.center:set_sprite_pos({ x=1, y=2 })
            else
                card.children.center:set_sprite_pos({ x=0, y=2 })
            end
        end
    end,

    calculate = function (self, card, context)
        if context.joker_main then
            if not context.blueprint then
            card.ability.extra.chicken = not card.ability.extra.chicken
            end
            return {
                xchips = card.ability.extra.Xchips
            }
        end
    end,
}
