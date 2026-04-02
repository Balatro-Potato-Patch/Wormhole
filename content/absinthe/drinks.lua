--#region Type and Boosters

SMODS.ConsumableType {
    key = 'abs_drinks',
    default = 'c_worm_abs_test_drink',
    primary_colour = HEX('e3dbc8'),
    secondary_colour = HEX('f5c242'),
    collection_rows = { 5, 4 },
    shop_rate = 0.8
}

SMODS.Booster {
    key = "abs_top_shelf_jumbo_1",
    kind = "abs_drinks",
    group_key = "k_worm_abs_top_shelf_pack",
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 4,
        choose = 1
    },
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    cost = 7,
    weight = 0.48,
    select_card = 'consumeables',
    create_card = function(self, card)
        return create_card("abs_drinks", G.pack_cards, nil, nil, true, true, nil, "worm_abs_top_shelf")
    end,
    ease_background_colour = function(self)

    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end
}

SMODS.Booster {
    key = "abs_top_shelf_mega_1",
    kind = "abs_drinks",
    group_key = "k_worm_abs_top_shelf_pack",
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 4,
        choose = 2
    },
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    cost = 10,
    weight = 0.12,
    select_card = 'consumeables',
    create_card = function(self, card)
        return create_card("abs_drinks", G.pack_cards, nil, nil, true, true, nil, "worm_abs_top_shelf")
    end,
    ease_background_colour = function(self)

    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end
}

SMODS.Booster {
    key = "abs_top_shelf_normal_1",
    kind = "abs_drinks",
    group_key = "k_worm_abs_top_shelf_pack",
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    cost = 5,
    weight = 0.96,
    select_card = 'consumeables',
    create_card = function(self, card)
        return create_card("abs_drinks", G.pack_cards, nil, nil, true, true, nil, "worm_abs_top_shelf")
    end,
    ease_background_colour = function(self)

    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end
}

SMODS.Booster {
    key = "abs_top_shelf_normal_2",
    kind = "abs_drinks",
    group_key = "k_worm_abs_top_shelf_pack",
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    cost = 5,
    weight = 0.96,
    select_card = 'consumeables',
    create_card = function(self, card)
        return create_card("abs_drinks", G.pack_cards, nil, nil, true, true, nil, "worm_abs_top_shelf")
    end,
    ease_background_colour = function(self)

    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end
}


--#endregion

--#region Drink Utils

SMODS.DrawStep {
    key = 'abs_drinks',
    order = -9,
    func = function(self, layer)
        if self.ability.set == 'abs_drinks' then
        --if self.ability.set == 'abs_drinks' and self.discovered then
            if self.ability.drink_values.visibly_filled and self.children.center.sprite_pos ~= self.ability.drink_values.filled_pos then
                self.children.center:set_sprite_pos(self.ability.drink_values.filled_pos)
            elseif not self.ability.drink_values.visibly_filled and self.children.center.sprite_pos ~= self.ability.drink_values.empty_pos then
                self.children.center:set_sprite_pos(self.ability.drink_values.empty_pos)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

function Card:abs_refill_drink()
    if not self.ability.drink_values.filled then
        self.ability.drink_values.filled = true

        if self.config.center.refill and type(self.config.center.refill) == 'function' then
            self.config.center:refill(self)
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                self.ability.drink_values.visibly_filled = true
                return true;
            end
        }))

        SMODS.calculate_effect({ message = localize('k_worm_abs_refilled_ex'), colour = G.C.ATTENTION }, self)
        SMODS.calculate_context({ abs_drink_refilled = true, card = self })
    end
end

function Card:abs_empty_drink()
    if self.ability.drink_values.filled then
        self.ability.drink_values.filled = false

        if self.config.center.empty and type(self.config.center.empty) == 'function' then
            self.config.center:empty(self)
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                self.ability.drink_values.visibly_filled = false
                return true;
            end
        }))

        SMODS.calculate_effect({ message = localize('k_worm_abs_emptied_ex'), colour = G.C.ATTENTION }, self)
        SMODS.calculate_context({ abs_drink_emptied = true, card = self })
    end
end

--#endregion

--#region Drink Objects

SMODS.Consumable { -- Please god delete this before we finish
    set = 'abs_drinks',
    key = 'test_drink',
    pos = { x = 0, y = 0 },
    config = {
        drink_values = {
            filled_pos = { x = 0, y = 0 },
            empty_pos = { x = 1, y = 0 },
            filled = true,
            visibly_filled = true,
        }
    },
    calculate = function(self, card, context)
        if card.ability.drink_values.filled and context.setting_blind then
            card:abs_empty_drink()
        end

        if not card.ability.drink_values.filled and context.end_of_round and not context.individual and not context.repetition then
            card:abs_refill_drink()
        end
    end,
    empty = function(self, card)
        ease_dollars(4)
    end
}

SMODS.Consumable { -- Supergiant Cider
    set = 'abs_drinks',
    key = 'abs_supergiant_cider',
    pos = { x = 2, y = 0 },
    config = {
        drink_values = {
            filled_pos = { x = 2, y = 0 },
            empty_pos = { x = 3, y = 0 },
            filled = true,
            visibly_filled = true,
        },
        extra = { discards = 1, poker_hand = 'Full House' },
    },
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return { key = key, vars = { 
            card.ability.extra.discards, 
            localize(card.ability.extra.poker_hand, 'poker_hands') 
        } }
    end,
    calculate = function(self, card, context)
        if context.before and not card.ability.drink_values.filled and  
        (next(context.poker_hands["Full House"]) or next(context.poker_hands["Four of a Kind"]) 
        or next(context.poker_hands["Straight Flush"])) and not context.repetition then
            card:abs_refill_drink()
        end
        
        if context.hand_drawn and card.ability.drink_values.filled and not context.repetition then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(card.ability.extra.discards)
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_discards', vars = { card.ability.extra.discards } }, colour = G.C.RED, },
                        card)
                    card:abs_empty_drink()
                    return true
                end
            }))
        end
    end,
    --empty = function(self, card)
    --    ease_dollars(4)
    --end
}

SMODS.Consumable { -- Hubble Trouble
    set = 'abs_drinks',
    key = 'abs_hubble_trouble',
    pos = { x = 4, y = 0 },
    config = {
        drink_values = {
            filled_pos = { x = 4, y = 0 },
            empty_pos = { x = 5, y = 0 },
            filled = true,
            visibly_filled = true,
        },
    },
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return { key = key }
    end,
    calculate = function(self, card, context)
        if context.selling_card and not card.ability.drink_values.filled and 
        context.card.config.center.set == 'Planet' and not context.repetition then
            card:abs_refill_drink()
        end
        
        if context.after and card.ability.drink_values.filled and not context.repetition then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    if context.scoring_name and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        local _planet = nil
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == context.scoring_name then
                                _planet = v.key
                            end
                        end
                        if _planet then
                            --SMODS.add_card({ key = _planet })
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local planet_card = SMODS.create_card({ key = _planet })
                                    planet_card.sell_cost = 0
                                    G.consumeables:emplace(planet_card)
                                    return true
                                end
                            }))
                            SMODS.calculate_effect(
                                { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }, card )
                            card:abs_empty_drink()
                        end
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end
            }))
        end
    end,
    --empty = function(self, card)
    --    ease_dollars(4)
    --end
}

--#endregion
