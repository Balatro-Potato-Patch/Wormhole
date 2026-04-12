SMODS.Joker({
    key = "lfc_log",
    pos = { x = 0, y = 1 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    demicoloncompat = true,
    atlas = "lfc_jokers",
    ppu_coder = { "ProdByProto" },
    ppu_artist = { "J8-Bit" },
    pixel_size = { w = 71, h = 68 },
    display_size = { w = 71, h = 68 },
    ppu_team = { "Lancer Fan Club" },
    config = {
        extra = {
            scalar = 2,
        }
    },
    attributes = {
        "mult",
        "joker"
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.scalar, (G.GAME and G.GAME.worm_log_count or 0) * card.ability.extra.scalar, G.GAME and G.GAME.round or 1, string.gsub(os.date("%x"), '/', '') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return { mult = card.ability.extra.scalar * G.GAME.worm_log_count }
        end
    end
})
