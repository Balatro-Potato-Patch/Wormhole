SMODS.Atlas {
    key = "abs_jokers",
    path = 'absinthe/abs_jokers.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'abs_clg',
    rarity = 2,
    cost = 5,
    atlas = 'worm_abs_jokers',
    pos = { x = 0, y = 0 },
    ppu_artist = { 'nixthatoneartist' },
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    attributes = {
        'generation',
        'drinks',
        'space'
    },
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local new_drink = SMODS.add_card({set = 'abs_drinks'})
                    new_drink.ability.drink_values.filled = false
                    new_drink.ability.drink_values.visibly_filled = false
                    G.GAME.consumeable_buffer = 0
                    return true;
                end
            }))
            return {
                message = localize('k_plus_drink'),
                colour = G.C.SECONDARY_SET.abs_drinks,
            }
        end
    end,
}

SMODS.Joker {
    key = 'abs_seeing_stars',
    rarity = 1,
    cost = 4,
    atlas = 'worm_abs_jokers',
    pos = { x = 1, y = 0 },
    ppu_coder = { 'pi_cubed' },
    ppu_artist = { 'AstraLuna' },
    ppu_team = { 'absinthe' },
    attributes = {
        'economy',
        'passive',
        'drinks',
        'space'
    },
    blueprint_compat = true, perishable_compat = true, eternal_compat = true,
    config = { extra = { dollars = 5, cons_slots_mod = 1 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.dollars, 
            card.ability.extra.cons_slots_mod 
        } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.cons_slots_mod
            return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.cons_slots_mod
            return true end }))
    end,
    calculate = function(self, card, context)
        if context.abs_drink_refilled then
            --[[G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }]]
            return {
                colour = G.C.MONEY,
                dollars = card.ability.extra.dollars,
			}
        end
    end,
}

SMODS.Joker {
    key = 'abs_water_world',
    rarity = 2,
    cost = 5,
    atlas = 'worm_abs_jokers',
    pos = { x = 2, y = 0 },
    ppu_artist = { 'pangaea47' },
    ppu_coder = { 'pi_cubed' },
    ppu_team = { 'absinthe' },
    attributes = {
        'passive',
        'joker_slot',
    },
    blueprint_compat = false, perishable_compat = false, eternal_compat = true,
    config = { extra_slots_used = 1, extra = { cons_slots_mod = 3 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.cons_slots_mod,
            card.ability.extra_slots_used + 1, 
        } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.cons_slots_mod
            return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.cons_slots_mod
            return true end }))
    end,
}

SMODS.Joker {
    key = 'abs_gravity_well',
    rarity = 1,
    cost = 5,
    atlas = 'worm_abs_jokers',
    pos = { x = 3, y = 0 },
    ppu_artist = { 'nixthatoneartist' },
    ppu_coder = { 'pi_cubed' },
    ppu_team = { 'absinthe' },
    attributes = {
        'chips',
        'scaling',
        'drinks',
        'space'
    },
    blueprint_compat = true, perishable_compat = false, eternal_compat = true,
    config = { extra = { chips_mod = 15, chips = 0 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.chips_mod, 
            card.ability.extra.chips 
        } }
    end,
    calculate = function(self, card, context)
        if context.abs_drink_emptied and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
            })
        end
        if context.joker_main then
            if card.ability.extra.chips > 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
}

SMODS.Joker {
    key = 'abs_binary_system',
    rarity = 2,
    cost = 6,
    atlas = 'worm_abs_jokers',
    pos = { x = 5, y = 0 },
    ppu_coder = { 'pi_cubed' },
    ppu_artist = { 'AstraLuna'},
    ppu_team = { 'absinthe' },
    attributes = {
        'hand_type',
        'generation',
        'drinks',
        'space'
    },
    blueprint_compat = false, perishable_compat = true, eternal_compat = false,
    in_pool = function(self, args)
		for k,v in ipairs(G.consumeables.cards) do
            if v.ability.set == 'abs_drinks' then
                return true
            end
        end
        return false
	end,
    calculate = function(self, card, context)
        if context.before and  
        (next(context.poker_hands["Flush House"]) or next(context.poker_hands["Five of a Kind"]) 
        or next(context.poker_hands["Straight Flush"])) and not context.blueprint then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local drink_list = {}
                for k,v in ipairs(G.consumeables.cards) do
                    if v.ability.set == 'abs_drinks' then
                        drink_list[#drink_list+1] = v
                    end
                end
                local random_drink = pseudorandom_element(drink_list, 'abs_binary_system')
                if random_drink then
                    random_drink:abs_refill_drink()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local new_drink = copy_card(random_drink)
                            G.consumeables:emplace(new_drink)
                            G.GAME.consumeable_buffer = 0
                            return true;
                        end
                    }))
                    SMODS.calculate_effect(
                        { message = localize('k_duplicated_ex'), colour = G.C.SECONDARY_SET.abs_drinks, },
                        card)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            SMODS.destroy_cards(card, nil, true)
                            return true
                        end
                    }))
                else
                    G.GAME.consumeable_buffer = 0
                end
            end
        end
    end,
}



SMODS.Joker {
    key = 'abs_glass_storm',
    rarity = 2,
    cost = 7,
    atlas = 'worm_abs_jokers',
    pos = { x = 4, y = 0 },
    ppu_artist = { 'AstraLuna' },
    ppu_coder = { 'pi_cubed' },
    ppu_team = { 'absinthe' },
    attributes = {
        'full_deck',
        'enhancements',
        'modify_card',
        'on_sell',
        'drinks',
        'space'
    },
    blueprint_compat = true, perishable_compat = true, eternal_compat = true,
    config = { extra = { glassed_cards = 5 }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { 
            card.ability.extra.glassed_cards
        } }
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'abs_drinks' 
        and context.card.ability.drink_values.filled == false then
            local glassed_list = {}
            if #G.deck.cards > card.ability.extra.glassed_cards then -- pick 5 random cards
                local available_cards = {}
                for k,v in ipairs(G.deck.cards) do
                    if not v.glass_stormed then
                        available_cards[#available_cards+1] = v
                    end
                end
                for i = 1, card.ability.extra.glassed_cards do
                    local chosen_card = pseudorandom_element(available_cards, 'abs_glass_storm')
                    for j = 1, #available_cards do
                        if available_cards[j] == chosen_card then
                            available_cards[j] = nil
                        end
                    end
                    if chosen_card and not chosen_card.glass_stormed then
                        glassed_list[#glassed_list+1] = chosen_card
                        chosen_card.glass_stormed = true
                    end
                end
            else -- pick all remaining cards
                for k,v in ipairs(G.deck.cards) do
                    if not v.glass_stormed then
                        glassed_list[#glassed_list+1] = v
                    end
                end
            end
            if #glassed_list > 0 then
                local original_state = G.STATE
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        if G.STATE == G.STATES.SELECTING_HAND then
                            G.STATE = G.STATES.HAND_PLAYED
                        end
                        card:juice_up()
                        play_sound('generic1')
                        for i = 1, #glassed_list do
                            G.play.config.card_limits.total_slots = G.play.config.card_limits.total_slots + 1
                            draw_card(G.deck, G.play, 90, 'up', nil, glassed_list[i])
                        end
                        
                        G.E_MANAGER:add_event(Event({
                            delay = 0,
                            trigger = 'after',
                            func = function()
                                for i = 1, #glassed_list do
                                    if glassed_list[i].ability.effect ~= 'Glass Card' then
                                        glassed_list[i].glass_storm_shadow = true
                                    end
                                    glassed_list[i]:set_ability('m_glass', nil, true)
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            glassed_list[i]:juice_up()
                                            glassed_list[i].glass_storm_shadow = nil
                                            return true
                                        end
                                    }))
                                end
                                return true
                            end
                        }))

                        G.E_MANAGER:add_event(Event({
                            delay = 0.1,
                            trigger = 'after',
                            func = function()
                                SMODS.calculate_effect({message = localize('k_glass'), 
                                    colour = G.C.SECONDARY_SET.Enhanced}, 
                                    context.blueprint_card or card)
                                return true
                            end
                        }))

                        G.E_MANAGER:add_event(Event({
                            delay = 1,
                            trigger = 'after',
                            func = function()
                                for i = 1, #glassed_list do
                                    G.play.config.card_limits.total_slots = G.play.config.card_limits.total_slots - 1
                                    draw_card(G.play, G.deck, 90, 'up', nil, glassed_list[i])
                                    glassed_list[i].glass_stormed = false
                                end
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    func = function()
                                        if #G.play.cards <= #glassed_list then
                                            G.STATE = original_state
                                        end
                                        return true
                                    end
                                }))
                                return true
                            end
                        }))

                        return true
                    end
                }))

            end
        end
    end,
}