-- The Past
SMODS.Joker({
    key = 'the_past',
    atlas = 'worm_jokers',
    pos = { x = 0, y = 0 },
    rarity = 'worm_cosmic',
    cost = 20,
    blueprint_compat = true,
    discovered = true,
    ppu_artist = { "fooping" },
    ppu_coder = { "fooping" },
    ppu_team = { "riverboat" },
    attributes = {},
    loc_vars = function(self, info_queue, card)
        local hands = G.GAME and G.GAME.hands_played or 0
        local bought = G.GAME and G.GAME.worm_jokers_bought or 0
        local paired = get_pair_status()

        if paired then
            return { key = self.key .. '_paired', vars = { hands, bought } }
        end
        return { vars = { hands } }
    end,
    calculate = function(self, card, context)
        -- Logic is handled via loc_vars and the Future's calculation
    end
})
