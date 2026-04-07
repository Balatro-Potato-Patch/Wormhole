SMODS.Atlas{
    key = 'stewjokers',
    path = 'BalatroStewniversity/Jokers.png',
    px = 71,
    py = 95
}

SMODS.Joker{ --Staged Landing
    key = 'staged_landing',
    loc_txt = {
    name = 'Staged Landing',
    text = {
        'Earn {C:money}$#1#{} every',
        '{C:attention}#2#{} {C:inactive}[#3#]{} {C:clubs}Clubs{} cards',
        'discarded'
        }
    },

    config = {extra = {dollars = 5, discards = 3, discards_remaining = 3}},
    rarity = 1,
    cost = 4,
    atlas = 'stewjokers',
    pos = {x=0, y=0},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        return {
            vars = {card.ability.extra.dollars, card.ability.extra.discards, card.ability.extra.discards_remaining}
            }
        end,
        calculate = function (self, card, context)
         if context.discard and context.other_card:is_suit('Clubs')
            and not context.other_card.debuff then
            if card.ability.extra.discards_remaining <= 1 then
                if not context.blueprint then
                card.ability.extra.discards_remaining = card.ability.extra.discards
                end
                return{
                    dollars = card.ability.extra.dollars
                }
                else if not context.blueprint then
                card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
                end
            end
        end
    end
}

SMODS.Joker{ --Stew Earth
    key = 'stew_earth',
    loc_txt = {
        name = 'Stew Earth',
        text = {
            '{E:1}mmmmmmmm stew{}'
        }
    },

    config = {},
    rarity = 4,
    cost = 42069,
    atlas = 'stewjokers',
    pos = {x=1, y=0},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

}

SMODS.Joker{ --Impact Crater
    key = 'impact_crater',
    loc_txt = {
        name = 'Impact Crater',
        text = {
            '{C:green}#2# in #3#{} chance to create',
            'a {C:attention,T:tag_meteor}#1#',
            'at the end of the {C:attention}shop{}'
        }
    },

    config = {extra = {odds = 2}},
    rarity = 2,
    cost = 6,
    atlas = 'stewjokers',
    pos = {x=2, y=0},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_meteor', set = 'Tag' }
        info_queue[#info_queue + 1] = G.P_CENTERS.p_celestial_mega_1
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_impact_crater')
        return{
            vars = {localize {type = 'name_text', key = 'tag_meteor', set = 'Tag'}, numerator, denominator}
        }
    end,

    calculate = function (self, card, context)
        if context.ending_shop and SMODS.pseudorandom_probability(card, 'worm_impact_crater', 1, card.ability.extra.odds) then
            card:juice_up() --maybe we can add more flair to creating the tag?
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_meteor'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}

SMODS.Joker{ --Dinosaur Earth
    key = 'dinosaur_earth',
    loc_txt = {
        name = 'Dinosaur Earth',
        text = {
            '{C:green}#1# in #2#{} chance for',
            '{C:attention}-#4#{} Ante and for all',
            'Dinosaur Earths go',
            '{C:red,E:2}extinct{} at end of round'
        }
    },

    config = {extra = {odds = 6, ante = 1}},
    rarity = 3,
    cost = 9,
    atlas = 'stewjokers',
    pos = {x=3, y=0},
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,

    loc_vars = function (self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'worm_dinosaur_earth')
        return {
            vars = {numerator, denominator, card.ability.extra.odds, card.ability.extra.ante}
        }
    end,

    mass_extinction = function (self, card)
        G.GAME.mass_extinction_event = true
        local dinosaur_earths = SMODS.find_card('j_worm_dinosaur_earth')
        local dinos_extinct = #dinosaur_earths
        ease_ante(-card.ability.extra.ante * dinos_extinct)
        G.E_MANAGER:add_event(Event {
            func = function()
                SMODS.destroy_cards(dinosaur_earths, nil, nil, true) --It's functional, but we could smooth the animation out later
                return true
            end
        })
    end,

    calculate = function (self, card, context)
        if G.GAME.mass_extinction_event then
            return
        end

        if not context.blueprint and context.end_of_round and context.game_over == false and context.main_eval then
            if SMODS.pseudorandom_probability(card, 'worm_dinosaur_earth', 1, card.ability.extra.odds) then
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
            return {
                message = localize('k_extinct_ex')
            }
        end
        --TO DO: Make the meteor crashing video play when the dinos go extinct

    end,
}