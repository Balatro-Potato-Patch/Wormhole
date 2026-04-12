-- singular

SMODS.Enhancement {
    key = "riverboat_stardust",
    atlas = "worm_modifiers",
    pos = { x = 0, y = 0 },
    ppu_coder = { "blamperer" },
    ppu_artist = { "blamperer" },
    config = {
        extra = {
            chips = 10,
            mult = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            if SMODS.in_scoring(card, context.scoring_hand) then
                local bonus = SMODS.pseudorandom_probability(card, "worm_riverboat_stardust", 1, 2,
                    "worm_riverboat_stardust", true) and "chips" or "mult"
                SMODS.upgrade_poker_hands {
                    hands = { context.scoring_name },
                    parameters = { bonus },
                    func = function(base, _, param, _)
                        return base + card.ability.extra[param]
                    end,
                    StatusText = true,
                    from = card
                }
            end
        end
    end
}
