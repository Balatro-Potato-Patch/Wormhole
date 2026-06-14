SMODS.Atlas({
    key = "stargaze_jokers",
    px = 71,
    py = 95,
    path = "Stargaze/jokers.png"
})

SMODS.Joker({
    key = "sg_typhoon",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 9,
    pos = { x = 1, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede" },
    ppu_team = { "Stargaze" },

    attributes = { "hand_type", "scaling", "xmult", "space" },

    config = {
        extra = {
            xmult = 1,
            xmult_mod = 0.2,
            poker_hand = "High Card"
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                localize(card.ability.extra.poker_hand, 'poker_hands'),
                card.ability.extra.xmult_mod,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vash')
            return {
                message = localize('k_reset')
            }
        end

        if context.before and not context.blueprint then
            if context.scoring_name == card.ability.extra.poker_hand then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'vash')
    end
})


SMODS.Joker({
    key = "sg_punisher",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 8,
    pos = { x = 2, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede" },
    ppu_team = { "Stargaze" },

    attributes = { "mult", "prevents_death", "xmult", "scaling", "space" },

    config = {
        extra = {
            mult = 15,
            used_revive = false
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.j_worm_sg_punisher2
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.game_over then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:set_ability('j_worm_sg_punisher2')
                    return true
                end
            }))

            return {
                message = "Revived",
                colour = G.C.BLACK,
                saved = localize("j_worm_sg_punisher", "dictionary")
            }
        end

        if context.joker_main and context.full_hand and #context.full_hand == 5 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})


SMODS.Joker({
    key = "sg_punisher2",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,
    cost = 8,
    pos = { x = 3, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede" },
    ppu_team = { "Stargaze" },

    attributes = { "mult", "prevents_death", "xmult", "scaling", "space" },

    config = {
        extra = {
            xmult = 15,
            deplete = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.deplete
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            card.ability.extra.xmult = math.max(1, card.ability.extra.xmult - card.ability.extra.deplete)

            if card.ability.extra.xmult <= 1 then
                SMODS.destroy_cards(card)

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

        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end,
    in_pool = function(self, args)
        return false
    end
})


SMODS.Joker({
    key = "sg_knives",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 9,
    pos = { x = 7, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede" },
    ppu_team = { "Stargaze" },

    attributes = { "hands", "destroy_card", "generation", "space" },

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
                        local copy = SMODS.copy_card(highest)
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
    key = "sg_journalist",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 6, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "DanielDeisar" },
    ppu_team = { "Stargaze" },

    attributes = { "chips", "scaling", "hand_type", "hands", "joker_slot", "space" },

    config = {
        extra = {
            chips = 0,
            chips_mod = 10,
            chips_mod_bonus = 2,
            last_hand = nil,
            last_round = -1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips, card.ability.extra.chips_mod, card.ability.extra.chips_mod *
            card.ability.extra.chips_mod_bonus
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
                local gain = card.ability.extra.chips_mod

                if #G.jokers.cards >= G.jokers.config.card_limit then
                    gain = gain * card.ability.extra.chips_mod_bonus
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
    key = "sg_journalist2",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 4, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "DanielDeisar" },
    ppu_team = { "Stargaze" },

    attributes = { "scaling", "xchips", "hand_type", "hands", "joker_slot", "space" },

    config = {
        extra = {
            xchips = 1,
            xchips_mod = 0.05,
            xchips_mod_bonus = 2,
            played_hands = {},
            last_round = -1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xchips, card.ability.extra.xchips_mod, card.ability.extra.xchips_mod *
            card.ability.extra.xchips_mod_bonus
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

                local gain = card.ability.extra.xchips_mod

                if #G.jokers.cards >= G.jokers.config.card_limit then
                    gain = gain * card.ability.extra.xchips_mod_bonus
                end

                card.ability.extra.xchips =
                    card.ability.extra.xchips + gain

                return {
                    message = "+X" .. gain,
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
    key = "sg_nomanland",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 3,
    pos = { x = 5, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede" },
    ppu_team = { "Stargaze" },

    attributes = { "economy", "joker", "space" },

    config = {
        extra = {
            sold = 0,
            goal = 3,
            money = 6,
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.sold % card.ability.extra.goal, card.ability.extra.goal, card.ability.extra.money
            }
        }
    end,

    calculate = function(self, card, context)
        if context.selling_card
            and context.card
            and context.card.ability
            and context.card.ability.set == "Joker"
            and context.card ~= card then
            card.ability.extra.sold =
                card.ability.extra.sold + 1

            if card.ability.extra.sold % card.ability.extra.goal == 0 then
                return {
                    dollars = card.ability.extra.money,
                }
            else
                return {
                    message = card.ability.extra.sold % card.ability.extra.goal .. "/3",
                    colour = G.C.FILTER
                }
            end
        end
    end
})

SMODS.Joker({
    key = "sg_GOD",
    rarity = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 20,
    pos = { x = 0, y = 0 },
    atlas = "stargaze_jokers",
    ppu_coder = { "FALATRO" },
    ppu_team = { "Stargaze" },

    attributes = { "planet", "prevents_death", "space" },

    config = {
        extra = {
            planets_used = 0,
            planets_req = 10,
            revives = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.revives,
                card.ability.extra.planets_req - (card.ability.extra.planets_used % card.ability.extra.planets_req),
                card.ability.extra.planets_req,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.ability.set == "Planet" then
                card.ability.extra.planets_used =
                    card.ability.extra.planets_used + 1

                if card.ability.extra.planets_used % card.ability.extra.planets_req == 0 then
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
                colour = G.C.SECONDARY_SET.Planet,
                saved = localize("j_worm_sg_GOD", "dictionary")
            }
        end
    end
})
