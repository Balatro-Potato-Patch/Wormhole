
SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty" },
    ppu_coder = { "PLagger", "stupxd" },

    key = 'stew_dinosaur_earth',
    config = {extra = {odds = 6, ante = 1}},
    rarity = 3,
    cost = 9,
    atlas = 'stewjokers',
    pos = {x=3, y=0},
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    loc_vars = function (self, info_queue, card)
    
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_stew_dinosaur_earth')

        return {
            vars = {numerator, denominator, card.ability.extra.odds, card.ability.extra.ante},
            key = G.GAME.mass_extinction_event and 'j_worm_stew_dinosaur_earth_alt' or nil
        }
    end,

    mass_extinction = function (self, card)
        G.GAME.mass_extinction_event = true
        local dinosaur_earths = SMODS.find_card('j_worm_stew_dinosaur_earth')
        local dinos_extinct = #dinosaur_earths
        ease_ante(-card.ability.extra.ante * dinos_extinct)

        --check if player manipulated odds to force extinction event
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_stew_dinosaur_earth') 
        if numerator >= denominator then
            check_for_unlock({type = 'stew_extinction_event'})
        end

        G.E_MANAGER:add_event(Event {
            func = function()
                ExtinctionEvent.play_video()

                SMODS.destroy_cards(dinosaur_earths, nil, nil, true)
                return true
            end
        })
    end,

    calculate = function (self, card, context)
        if G.GAME.mass_extinction_event then
            return
        end

        if not context.blueprint and context.end_of_round and context.game_over == false and context.main_eval then
            if SMODS.pseudorandom_probability(card, 'worm_stew_dinosaur_earth', 1, card.ability.extra.odds) then
                self:mass_extinction(card)
                return{
                    message = localize('k_extinct_ex')
                }
            else return {
                message = localize('k_safe_ex')
            }
            end
        end

        if not context.blueprint and context.tag_triggered and context.tag_triggered.key == 'tag_meteor' then
            self:mass_extinction(card)
            check_for_unlock({type = 'stew_extinction_event'})
            return {
                message = localize('k_extinct_ex')
            }
        end

    end,
}
