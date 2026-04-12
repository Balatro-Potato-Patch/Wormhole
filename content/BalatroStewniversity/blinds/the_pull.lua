
SMODS.Blind {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "tuzzo" },
    ppu_coder = { "stupxd" },

    key = "stew_pull",
    dollars = 5,
    mult = 2,
    mult_per_rounds_played = {2, 4, 6},
    name = "The Pull",
    atlas = "stewblinds",
    pos = { x = 0, y = 0 },
    boss = { min = 3 },
    boss_colour = HEX("575757"),
    calculate = function(self, blind, context)
        if not blind.disabled then

            if context.setting_blind then
                G.GAME.blind.worm_original_size = G.GAME.blind.chips

                local mult = self.mult_per_rounds_played[G.GAME.rounds_played_ante] / self.mult

                G.GAME.blind.chips = G.GAME.blind.chips * mult
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

            end
        end
    end,
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.worm_original_size
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end,
}

local new_round_ref = new_round
function new_round(...)
    G.GAME.rounds_played_ante = (G.GAME.rounds_played_ante or 0) + 1
    new_round_ref(...)
end

local end_round_ref = end_round
function end_round(...)
    if G.GAME.blind and G.GAME.blind:get_type() == 'Boss' then
        G.GAME.rounds_played_ante = 0
    end
    end_round_ref(...)
end
