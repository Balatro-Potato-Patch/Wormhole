SMODS.Joker {
    key = "sttgl",
    atlas = 'VVjokers',
    rarity = 'worm_otherworldly',
    cost = 30,
    pos = {x = 3, y = 0},
    soul_pos = {x = 4, y = 0},
    config = {
        extra = {
        }
    },
    ppu_team = { "Violent Violets" },
    ppu_artist = { "FirstTry" },
    ppu_coder = { "FireIce" },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
            }
        }
    end,
    calculate = function(self,card,context)
    if context.ante_change then
        SMODS.add_card{ key = "c_black_hole" }
    end
    end
}