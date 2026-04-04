SMODS.Edition{
    key = 'stellar',
    shader = false,
    config = {odds = 4},
    in_shop = false,
    extra_cost = 2,
    loc_txt = {
        name = 'Stellar',
        text = {'{C:green}#1# in #2#{} chance to',
        'upgrade level of',
        'played {c:attention}poker hand{}'
        },
        label = 'Stellar'
    },
    weight = 5,

    sound = { sound = "foil1", per = 1.2, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.edition.odds, 'worm_stellar')
        return { vars = { numerator, denominator, card.edition.odds } }
    end,
    calculate = function(self, card, context)
        if context.before and SMODS.pseudorandom_probability(card, 'worm_stellar', 1, card.edition.odds) then
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
    end

    --[[ placeholder credits until i actually figure out how to do it with the code
        credits:
        art: n/a
        code: PLagger
        team: Balatro Stewniversity
    ]]
}