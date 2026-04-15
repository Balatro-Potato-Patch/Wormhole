SMODS.Joker {
    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty" },
    ppu_coder = { "stupxd" },

    key = 'stew_starfish_earth',
    rarity = "Common",
    cost = 3,
    atlas = 'stewjokers',
    pos = {x=4, y=2},
    config = { extra = { money = 1, money_needed = 10 } },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    fish_sprite = nil,

    loc_vars = function(self, info_queue, card)
        if self.fish_sprite and self.fish_sprite.remove then
            self.fish_sprite:remove()
            self.fish_sprite = nil
        end
        self.fish_sprite = Sprite(0, 0, 3.5, 3.5 *  176 / 326, G.ASSET_ATLAS.worm_stew_fish_lore, {x = 0, y = 0})

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", minh = 2, padding = 0.1 },
                nodes = {
                    { n = G.UIT.O, config = { object = self.fish_sprite } },
                }
            }
        }
        return {
            vars = { card.ability.extra.money, card.ability.extra.money_needed },
            main_end = main_end
        }
    end,

    calc_dollar_bonus = function(self, card)
        return math.max(0, math.floor(G.GAME.dollars / card.ability.extra.money_needed)) 
                    * card.ability.extra.money
    end
}