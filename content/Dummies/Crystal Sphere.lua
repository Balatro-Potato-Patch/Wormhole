SMODS.Joker {
    key = "dum_crystalsphere",
    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "dum_crystalsphere")
        return { vars = { num, denom } }
    end,
    rarity = 1,
    atlas = 'DummiesJokers',
    pos = { x = 0, y = 2 },
    wormhole_pos_extra = { hand_a = { x = 1, y = 2 }, hand_b = { x = 5, y = 2 }, ball = { x = 9, y = 2 } },
    wormhole_anim_extra = {
        hand_a = {
            { xrange = { first = 1, last = 4 }, y = 2, t = 0.3 }
        },
        hand_b = {
            { x = 5, y = 2, t = 0.15 },
            { xrange = { first = 6, last = 8 }, y = 2, t = 0.3 },
            { x = 5, y = 2, t = 0.15 }
        },
        ball = {
            { x = 9, y = 2, t = 3 },
            { xrange = { first = 10, last = 11 }, y = 2, t = 0.075 },
            { xrange = { first = 0, last = 2 }, y = 3, t = 0.075 },
            { x = 9, y = 2, t = 5 },
        },
    },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local found_face = false
            for _, v in ipairs(context.scoring_hand) do
                if v:is_face() then found_face = true break end
            end

            card.ability.extra.found_face = found_face and SMODS.pseudorandom_probability(card, "dum_crystalsphere", 1, card.ability.extra.odds)
        end

        if context.repetition and context.cardarea == G.play and not context.end_of_round and card.ability.extra.found_face then
            return { repetitions = 1 }
        end
    end,
    pronouns = "it_its",

    ppu_team = { "dummies" },
    ppu_artist = { "ghostsalt" },
    ppu_coder = { "ghostsalt" }
}