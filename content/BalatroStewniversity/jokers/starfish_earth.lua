SMODS.Joker {
    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty" },
    ppu_coder = { "stupxd" },

    key = 'stew_starfish_earth',
    rarity = "Rare",
    cost = 6,
    atlas = 'stewjokers',
    pos = {x=4, y=2},
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
                config = { align = "bm", minh = 2 },
                nodes = {
                    { n = G.UIT.O, config = { object = self.fish_sprite } },
                }
            }
        }
        return {
            vars = { 1, 2 },
            main_end = main_end
        }
    end,

    calculate = function (self, card, context)

        -- TODO effect Idk
    end
}