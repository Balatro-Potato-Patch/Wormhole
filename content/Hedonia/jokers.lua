SMODS.Atlas {
    key = "joker",
    px = 71,
    py = 95,
    path = "Hedonia/jokers.png"
}

SMODS.Joker {
    key = "hedonia_casino",
    atlas = "joker",
    pos = {x = 0, y = 0},
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    pools = {
        ["Bartender"] = true
    },
    config = {
        extra = {
            prob = 1,
            odds = 3
        }
    },
    attributes = {"editions", "enhancements", "generation", "space"},
    ppu_artist = {'qunumeru'},
    ppu_coder = {'axyraandas', 'professorrenderer'},
    ppu_team = {'Hedonia'},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_hedonia_drunk
        return { vars = { card.ability.extra.prob, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local num_drunk_cards = 0
            for k,v in ipairs(context.scoring_hand) do
                if v.edition and string.sub(v.edition.key, 1, 15) == 'e_worm_hedonia_' then
                    if SMODS.pseudorandom_probability(card, 'hedonia_casino', card.ability.extra.prob, card.ability.extra.odds) then
                        num_drunk_cards = num_drunk_cards + 1
                        v:set_ability('m_lucky', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                return true
                            end
                        }))
                    end
                end
            end
            if num_drunk_cards > 0 then
                return {
                    message = localize('k_lucky'),
                }
            end
        end
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
            local spawn_key = SMODS.poll_object({ attributes = {'hedonia_menu_drink'} })
            if spawn_key == 'j_joker' then spawn_key = 'c_worm_hedonia_hadron' end

            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('timpani')
                    SMODS.add_card({area = G.consumeables, key_append = 'casino', key = spawn_key})
                    card:juice_up()
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            SMODS.calculate_effect(
                { message = localize('k_worm_hedonia_menu_plus'), colour = G.C.SECONDARY_SET.worm_hedonia_menu, },
                card)
        end
    end
}

SMODS.Joker {
    key = "hedonia_bar_mitzvah",
    atlas = "joker",
    pos = {x = 2, y = 0},
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    pools = {
        ["Bartender"] = true
    },
    config = { extra = {
        current = 0,
        threshold = 13
    }},
    attributes = {"generation", "scaling", "space"},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.threshold, card.ability.extra.threshold - card.ability.extra.current}}
    end,
    ppu_artist = {'hellboydante'},
    ppu_coder = {'wombatcountry'},
    ppu_team = {'Hedonia'},
    calculate = function(self,card,context)
        if context.before and not context.blueprint then
            if card.ability.extra.current >= card.ability.extra.threshold - #context.scoring_hand then
                local empty_slots = G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
                if empty_slots > 0 then
                    G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                    card.ability.extra.current = 0
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({set = "worm_hedonia_menu", area = G.consumeables, key_append = 'bar_mitzvah'})
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect(
                        { message = localize('k_worm_hedonia_menu_plus'), colour = G.C.SECONDARY_SET.worm_hedonia_menu, },
                        card)
                else    
                    alert_no_space(card, G.consumeables)
                end
            else
                card.ability.extra.current = card.ability.extra.current + #context.scoring_hand
                return {
                    message = tostring(card.ability.extra.threshold - card.ability.extra.current),
                    message_card = card
                }
            end
        end
    end
}

SMODS.Joker {
    key = "hedonia_speed",
    atlas = "joker",
    pos = {x = 1, y = 0},
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    pools = {
        ["Bartender"] = true
    },
    ppu_artist = {'hellboydante'},
    ppu_coder = {'wombatcountry', 'axyraandas'},
    ppu_team = {'Hedonia'},
    attributes = {"generation", "joker", "chance", "space"},
    loc_vars = function(self,info_queue,card)
        local num = 1
        local denom = 5
        if G.jokers and G.jokers.cards then
            num, denom = SMODS.get_probability_vars(card, #G.jokers.cards, G.jokers.config.card_limit)
        end
        return {vars = {num, denom}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local can_spawn = #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
            local can_spawn = can_spawn and SMODS.pseudorandom_probability(card, 'rings', #G.jokers.cards, G.jokers.config.card_limit)
            if can_spawn then
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                local spawn_key = SMODS.poll_object({ attributes = {'hedonia_menu_food'} })
                if spawn_key == 'j_joker' then spawn_key = 'c_worm_hedonia_rings' end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({area = G.consumeables, key_append = 'speed', key = spawn_key})
                        card:juice_up()
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                SMODS.calculate_effect(
                    { message = localize('k_worm_hedonia_menu_plus'), colour = G.C.SECONDARY_SET.worm_hedonia_menu, },
                    card)
            end
        end
    end
}

SMODS.Joker {
    key = "hedonia_trash",
    atlas = "joker",
    pos = {x = 0, y = 1},
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    config = { extra = {
        chips = 0
    }},
    attributes = {"chips", "scaling", "space"},
    ppu_artist = {'alxndr2000'},
    ppu_coder = {'wombatcountry', 'axyraandas'},
    ppu_team = {'Hedonia'},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for i, v in ipairs(context.removed) do
                card.ability.extra.chips = card.ability.extra.chips + v.base.nominal + v.ability.perma_bonus
            end
            return {
                message = 'Upgraded!',
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                card = card,
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
        if context.end_of_round and G.GAME.blind.boss then
            card.ability.extra.chips = 0
            return {
                message = 'Cleared!',
                colour = G.C.CHIPS
            }
        end
    end
}

SMODS.Joker {
    key = "hedonia_patron",
    atlas = "joker",
    pos = {x = 1, y = 1},
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    config = { extra = {
        mult = 0,
        mult_mod = 4 
    }},
    attributes = {"mult", "scaling", "editions", "space"},
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_hedonia_tipsy
        info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_hedonia_drunk
        info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_hedonia_very_drunk
        info_queue[#info_queue + 1] = G.P_CENTERS.e_worm_hedonia_blackout
        return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod}}
    end,
    ppu_artist = {'hellboydante'},
    ppu_coder = {'axyraandas'},
    ppu_team = {'Hedonia'},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.edition 
        and string.sub(context.other_card.edition.key, 1, 15) == 'e_worm_hedonia_' then
            return {
                message_card = card,
                func = function()
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "mult",
                        scalar_value = "mult_mod",
                        scaling_message = {
                            message = localize("k_upgrade_ex"),
                            colour = G.C.MULT,
                        }
                    })
                end
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
    key = "hedonia_happy_hour",
    atlas = "joker",
    pos = {x = 2, y = 1},
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    config = { extra = {
        discount = 2,
        money = 4,
    }},
    attributes = {"economy", "passive", "space"},
    ppu_artist = {'hellboydante'},
    ppu_coder = {'professorrenderer'},
    ppu_team = {'Hedonia'},
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.discount, card.ability.extra.money}}
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'worm_hedonia_menu' then
            return {
                dollars = card.ability.extra.money
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
}

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    local hedonia_happy_hour = SMODS.find_card("j_worm_hedonia_happy_hour")
    if next(hedonia_happy_hour) and self.ability.set == 'worm_hedonia_menu' or self.config.center.kind == 'hedonia_menu' then
        for _,v in pairs(hedonia_happy_hour) do
            self.cost = math.max(0, self.cost - v.ability.extra.discount)
        end
        self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
        self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
    end
end
