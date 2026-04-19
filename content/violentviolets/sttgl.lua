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
    ppu_coder = { "FirstTry" },
    loc_vars = function(self,info_queue,card)
        return {
            vars = {
                G.GAME.hands["Straight"].chips,
                G.GAME.hands["Straight"].mult,
                "   "
            }
        }
    end,
    calculate = function(self,card,context)
    if context.joker_main then
        return {
            chips = G.GAME.hands["Straight"].chips,
            mult = G.GAME.hands["Straight"].mult,
        }
    end
    end
}