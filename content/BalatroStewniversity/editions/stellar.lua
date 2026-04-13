
SMODS.Edition {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "stupxd" },
    ppu_coder = { "PLagger" },

    key = 'stew_stellar',
    shader = "stew_stellar",
    config = {odds = 4},
    in_shop = true,
    extra_cost = 4,
    weight = 17,

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
    end,

    on_apply = function (card)
        -- Randomize star field
        card.edition.stellar_seed = pseudorandom('worm_stellar_seed') * 0.1
        if card.config.center.key == 'j_space' then
            check_for_unlock({type = 'stew_spaced_joker'})
        end
    end,

}
