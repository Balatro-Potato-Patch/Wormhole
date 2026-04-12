SMODS.Atlas({
    key = "stargaze_jokers",
    px = 71,
    py = 95,
    path = "Stargaze/jokers.png"
})

SMODS.Joker({
    key = "typhoon",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 9,
    pos = { x = 1, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede"},
    ppu_team = { "Stargaze" },



    config = {
        extra = {
            xmult = 1,
            target_hand = "High Card"
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                string.format("%.1f", card.ability.extra.xmult),
                card.ability.extra.target_hand
            }
        }
    end,

    calculate = function(self, card, context)

        if context.end_of_round then
            local hands = {}
            for k, v in pairs(G.GAME.hands) do
                table.insert(hands, k)
            end

            if #hands > 0 then
                card.ability.extra.target_hand =
                    pseudorandom_element(hands, pseudoseed('vash'))
            end
        end

        if context.joker_main then
            if context.scoring_name == card.ability.extra.target_hand then
                card.ability.extra.xmult = card.ability.extra.xmult + 0.2

                return {
                    message = "Upgrade!",
                    colour = G.C.MULT
                }
            end

            return {
                x_mult = card.ability.extra.xmult
            }
        end
    end
})


SMODS.Joker({
    key = "punisher",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 8,
    pos = { x = 2, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede"},
    ppu_team = { "Stargaze" },



    config = {
        extra = {
            evolved = false,
            xmult = 15,
            used_revive = false
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)

      if context.game_over 
and not card.ability.extra.used_revive then

    card.ability.extra.used_revive = true
    card.ability.extra.evolved = true

    card.children.center:set_sprite_pos({x = 3, y = 0})
    card.children.center:reset()

    G.E_MANAGER:add_event(Event({
        func = function()
            card.ability.extra.xmult = 15
            return true
        end
    }))

    return {
        message = "Revived",
        colour = G.C.BLACK,
        saved = true
    }
end
       if context.end_of_round 
and card.ability.extra.evolved then

    if card.ability.extra.last_round ~= G.GAME.round then
        card.ability.extra.last_round = G.GAME.round

        card.ability.extra.xmult =
            math.max(1, card.ability.extra.xmult - 3)

        if card.ability.extra.xmult <= 1 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.8)

                    card:start_dissolve()
                    return true
                end
            }))

            return {
                message = "Retired",
                colour = G.C.BLACK
            }
        end

        return {
            message = "-3X",
            colour = G.C.BLACK
        }
    end
end


        if context.joker_main then

            if not card.ability.extra.evolved then
                if context.full_hand and #context.full_hand == 5 then
                    return {
                        mult = 15
                    }
                end
            end

            if card.ability.extra.evolved then
                return {
                    x_mult = card.ability.extra.xmult
                }
            end
        end
    end
})


SMODS.Joker({
    key = "knives",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 9,
    pos = { x = 7, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede"},
    ppu_team = { "Stargaze" },

    calculate = function(self, card, context)

        if context.before 
        and G.GAME.current_round 
        and G.GAME.current_round.hands_left == 0 then

            local hand_cards = G.hand.cards
            if not hand_cards or #hand_cards < 2 then return end

            local lowest = hand_cards[1]
            local highest = hand_cards[1]

            for _, c in ipairs(hand_cards) do
                if c.base.id < lowest.base.id then
                    lowest = c
                end
                if c.base.id > highest.base.id then
                    highest = c
                end
            end

            G.E_MANAGER:add_event(Event({
                func = function()

                    if lowest and lowest.area == G.hand then
                        lowest:start_dissolve()
                    end

                    if highest and highest.area == G.hand then
                        local copy = copy_card(highest, nil, nil, G.deck)
      
                        copy:add_to_deck()
                        table.insert(G.playing_cards, copy)

        
                        G.hand:emplace(copy)
                        copy:start_materialize()
                    end

                    return true 
                end
            }))

            return {
                message = "Death!",
                colour = G.C.RED
            }
        end
    end
})

SMODS.Joker({
    key = "journalist",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 6, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = {"DanielDeisar"},
    ppu_team = { "Stargaze" },

    config = {
        extra = {
            chips = 0,
            last_hand = nil,
            last_round = -1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,

    calculate = function(self, card, context)

        if context.starting_new_round then
            card.ability.extra.last_hand = nil
        end

        if context.before and context.scoring_name then

            local current_hand = context.scoring_name

            if card.ability.extra.last_round ~= G.GAME.round then
                card.ability.extra.last_round = G.GAME.round
                card.ability.extra.last_hand = current_hand
                return
            end

            if card.ability.extra.last_hand == current_hand then

                local gain = 10

                if #G.jokers.cards >= G.jokers.config.card_limit then
                    gain = gain * 2
                end

                card.ability.extra.chips =
                    card.ability.extra.chips + gain

                return {
                    message = "+" .. gain,
                    colour = G.C.CHIPS
                }
            end

            card.ability.extra.last_hand = current_hand
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})

SMODS.Joker({
    key = "journalist2",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 4, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = {"DanielDeisar"},
    ppu_team = { "Stargaze" },

    config = {
        extra = {
            xchips = 1,
            played_hands = {},
            last_round = -1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xchips
            }
        }
    end,

    calculate = function(self, card, context)

        if context.starting_new_round then
            card.ability.extra.played_hands = {}
        end

        if context.before and context.scoring_name then

            local current_hand = context.scoring_name

            if card.ability.extra.last_round ~= G.GAME.round then
                card.ability.extra.last_round = G.GAME.round
                card.ability.extra.played_hands = {}
            end

            if not card.ability.extra.played_hands[current_hand] then

                card.ability.extra.played_hands[current_hand] = true

                local gain = 0.05

                if #G.jokers.cards >= G.jokers.config.card_limit then
                    gain = gain * 2
                end

                card.ability.extra.xchips =
                    card.ability.extra.xchips + gain

                return {
                    message = "X+" .. gain,
                    colour = G.C.CHIPS
                }
            end
        end

        if context.joker_main then
            return {
                x_chips = card.ability.extra.xchips
            }
        end
    end
})

SMODS.Joker({
    key = "nomanland",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 5,
    pos = { x = 5, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede"},
    ppu_team = { "Stargaze" },

    config = {
        extra = {
            sold = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.sold % 3
            }
        }
    end,

    calculate = function(self, card, context)

        if context.selling_card 
        and context.card 
        and context.card.ability 
        and context.card.ability.set == "Joker" then

            card.ability.extra.sold =
                card.ability.extra.sold + 1

            if card.ability.extra.sold % 3 == 0 then
                return {
                    dollars = 5,
                }
            else
                return {
                    message = card.ability.extra.sold % 3 .. "/3",
                    colour = G.C.FILTER
                }
            end
        end
    end
})

SMODS.Joker({
    key = "GOD",
    rarity = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 20,
    pos = { x = 0, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_team = { "Stargaze" },

    config = {
        extra = {
            planets_used = 0,
            revives = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.revives
            }
        }
    end,

    calculate = function(self, card, context)

        if context.using_consumeable then
            if context.consumeable.ability.set == "Planet" then

                card.ability.extra.planets_used =
                    card.ability.extra.planets_used + 1

                if card.ability.extra.planets_used % 10 == 0 then
                    card.ability.extra.revives =
                        card.ability.extra.revives + 1

                    return {
                        message = "UNIVERSE EXPANDS!!",
                        colour = G.C.SECONDARY_SET.Planet
                    }
                end
            end
        end

        if context.game_over and card.ability.extra.revives > 0 then

            card.ability.extra.revives =
                card.ability.extra.revives - 1

            return {
                message = "DIVINE INTERVENTION!",
                colour =  G.C.SECONDARY_SET.Planet,
                saved = true
            }
        end
    end
})

