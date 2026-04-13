SMODS.Joker{

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "Wingcap" },
    ppu_coder = { "PLagger" },

    key = 'stew_8_ball_earth',
    config = {extra = {poker_hand = 'Full House'}},
    rarity = 2,
    cost = 6,
    atlas = 'stewjokers',
    pos = {x=4, y=0},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        return{
            vars = {localize(card.ability.extra.poker_hand, 'poker_hands')}
        }
    end,

    calculate = function (self, card, context)
        --is there a better way to do this? maybe. does it work? hell yea it does
        local consumable_types = {'Tarot', 'Tarot', 'Tarot', 'Tarot', 'Tarot', 'Planet', 'Planet', 'Planet', 'Planet', 'Planet', 'Spectral', 'Spectral'}
        if context.joker_main and next(context.poker_hands[card.ability.extra.poker_hand]) and not context.blueprint then
            for i=1, (G.consumeables.config.card_limit) do
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    
                    local type_created = pseudorandom_element(consumable_types, "worm_stew_8_ball_type")
                    
                    if type_created == 'Tarot' then
                    G.E_MANAGER:add_event(Event({
                        func = function ()
                        SMODS.add_card({set = 'Tarot', key_append = 'worm_stew_8_ball_earth'})
                        card:juice_up(0.3, 0.5)
                        G.GAME.consumeable_buffer = 0
                        return true
                        end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.SECONDARY_SET.Tarot})
                    elseif type_created == 'Planet' then
                        G.E_MANAGER:add_event(Event({
                        func = function ()
                        SMODS.add_card({set = 'Planet', key_append = 'worm_stew_8_ball_earth'})
                        card:juice_up(0.3, 0.5)
                        G.GAME.consumeable_buffer = 0
                        return true
                        end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    
                    elseif type_created == 'Spectral' then
                        G.E_MANAGER:add_event(Event({
                        func = function ()
                        SMODS.add_card({set = 'Spectral', key_append = 'worm_stew_8_ball_earth'})
                        card:juice_up(0.3, 0.5)
                        G.GAME.consumeable_buffer = 0
                        return true
                        end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                end
            end
        end
    end
}