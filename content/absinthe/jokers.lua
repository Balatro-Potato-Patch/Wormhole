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
    key = 'abs_put_it_on_my_tab',
    rarity = 1,
    cost = 4,
    --atlas = 'worm_abs_jokers',
    pos = { x = 1, y = 0 },
    --ppu_artist = { '' },
    ppu_coder = { 'pi_cubed' },
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
    key = 'abs_drinkmaxxing',
    rarity = 2,
    cost = 4,
    --atlas = 'worm_abs_jokers',
    pos = { x = 2, y = 0 },
    --ppu_artist = { '' },
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
    key = 'abs_heavyweight_joker',
    rarity = 1,
    cost = 5,
    --atlas = 'worm_abs_jokers',
    pos = { x = 3, y = 0 },
    --ppu_artist = { '' },
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
    --atlas = 'worm_abs_jokers',
    pos = { x = 4, y = 0 },
    --ppu_artist = { '' },
    ppu_coder = { 'pi_cubed' },
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