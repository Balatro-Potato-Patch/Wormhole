
SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty", "dottykitty" },
    ppu_coder = { "stupxd" },

    key = 'stew_chicken_egg',
    config = {extra = { Xchips = 3 }},
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
        }
    end,

    update_sprite = function (self, card)
        if card.ability.chicken then
            card.children.center:set_sprite_pos({ x=1, y=2 })
        else
            card.children.center:set_sprite_pos({ x=0, y=2 })
        end
    end,

    -- happens when a card is created or loaded
    set_sprites = function (self, card, front)

        card.ability.chicken = card.ability.chicken or true
        self:update_sprite(card)

    end,

    -- end round -> swap sprite, swap description

    -- load -> set correct sprite & description

    calculate = function (self, card, context)
        if context.main_eval then
            card.ability.chicken = not card.ability.chicken
            self:update_sprite(card)

            return {
                Xchips = card.ability.extra.Xchips
            }
        end
    end,
}
