SMODS.Joker {
    key = "riverboat_fractal",
    config = {
        extra = {
            odds = 4
        }
    },
    rarity = 2,
    cost = 6,
    atlas = "jokers",
    pos = { x = 9, y = 0 },
    discovered = true,
    blueprint_compat = true,
    ppu_coder = { "fooping" },
    ppu_team = { "riverboat" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.GAME and G.GAME.probabilities.normal or 1,
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local cards_to_modify = {}
            for i = 1, #context.scoring_hand do
                if not context.scoring_hand[i].edition and SMODS.pseudorandom_probability(card, 'fractal', 1, card.ability.extra.odds, 'fractal') then
                    cards_to_modify[#cards_to_modify + 1] = context.scoring_hand[i]
                end
            end

            if #cards_to_modify > 0 then
                for i = 1, #cards_to_modify do
                    cards_to_modify[i]:set_edition({ holo = true }, true)
                end
                return {
                    card = card
                }
            end
        end
    end
}
