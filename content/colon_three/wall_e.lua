if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "wall_e",
    --atlas = "ct_jokers",
    --pos = { x = 0, y = 0 },
    config = { extra = { } },
    rarity = 2,
    attributes = { "space", },
    --ppu_artist = {},
    ppu_coder = { "notmario" },
    ppu_team = { ":3" },

    loc_vars = function(self, q, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context) -- handled in the clean-up definition
    end
}
