--#region Type and Boosters

SMODS.ConsumableType {
    key = 'abs_drinks',
    default = 'c_worm_abs_hubble_trouble',
    primary_colour = HEX('e3dbc8'),
    secondary_colour = HEX('f5c242'),
    collection_rows = { 5, 4 },
    shop_rate = 0.0
}

SMODS.Attribute {
    key = 'drinks'
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

--#endregion

--#region Drink Utils

SMODS.DrawStep {
    key = 'abs_drinks',
    order = -9,
    func = function(self, layer)
        if self.ability.set == 'abs_drinks' and self.config.center.discovered then
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

        SMODS.calculate_effect({ message = localize('k_worm_abs_refilled_ex'), colour = G.C.SECONDARY_SET.abs_drinks }, self)
        SMODS.calculate_context({ abs_drink_refilled = true, card = self })
    end
end

function Card:abs_empty_drink()
    if self.ability.drink_values.filled then
        self.ability.drink_values.filled = false
        self.ability.drink_values.primed = false

        if self.config.center.empty and type(self.config.center.empty) == 'function' then
            self.config.center:empty(self)
        end

        G.E_MANAGER:add_event(Event({
            func = function()
                self.ability.drink_values.visibly_filled = false
                return true;
            end
        }))

        SMODS.calculate_effect({ message = localize('k_worm_abs_emptied_ex'), colour = G.C.SECONDARY_SET.abs_drinks }, self)
        SMODS.calculate_context({ abs_drink_emptied = true, card = self })
    end
end

function Card:abs_toggle_drink_prime()
    if self.ability.set == 'abs_drinks' then
        self.ability.drink_values.primed = not self.ability.drink_values.primed
        if self.ability.drink_values.primed then
            local eval = function(self) return self.ability.drink_values.primed end
            juice_card_until(self, eval, true)
        end
    end
end

--#endregion

--#region Drink Objects

SMODS.Consumable { -- Supergiant Cider
    set = 'abs_drinks',
    key = 'abs_supergiant_cider',
    pos = { x = 2, y = 0 },
    ppu_coder = { 'pi_cubed' },
    ppu_team = { 'absinthe' },
    config = {
        drink_values = {
            filled_pos = { x = 2, y = 0 },
            empty_pos = { x = 3, y = 0 },
            filled = true,
            visibly_filled = true,
            primed = false
        },
        extra = { discards = 1, poker_hand = 'Full House' },
    },
    cost = 3,
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

        if context.hand_drawn and card.ability.drink_values.filled and card.ability.drink_values.primed and not context.repetition then
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
    use = function(self, card, area, copier)
        if G.GAME.blind.in_blind then
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
        else
            card:abs_toggle_drink_prime()
        end
    end,
    can_use = function(self, card)
        return card.ability.drink_values.filled
    end,
    keep_on_use = function(self, card)
        return true;
    end
}

SMODS.Consumable { -- Hubble Trouble
    set = 'abs_drinks',
    key = 'abs_hubble_trouble',
    pos = { x = 4, y = 0 },
    ppu_coder = { 'pi_cubed' },
    ppu_team = { 'absinthe' },
    config = {
        drink_values = {
            filled_pos = { x = 4, y = 0 },
            empty_pos = { x = 5, y = 0 },
            filled = true,
            visibly_filled = true,
            primed = false,
        },
    },
    cost = 3,
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

        if context.before and card.ability.drink_values.filled and card.ability.drink_values.primed and not context.repetition then
            local text, _ = G.FUNCS.get_poker_hand_info(G.play.cards)
            SMODS.calculate_effect(
                { level_up = true, level_up_hand = text }, card)
            card:abs_empty_drink()
        end
    end,
    use = function(self, card, area, copier)
        card:abs_toggle_drink_prime()
    end,
    can_use = function(self, card)
        return card.ability.drink_values.filled
    end,
    keep_on_use = function(self, card)
        return true;
    end
}

SMODS.Consumable { -- Moonshine
    set = 'abs_drinks',
    key = 'abs_moonshine',
    pos = { x = 8, y = 1 },
    ppu_coder = { 'iwas_nevergood' },
    ppu_team = { 'absinthe' },
    config = {
        drink_values = {
            filled_pos = { x = 8, y = 1 },
            empty_pos = { x = 1, y = 2 },
            filled = true,
            visibly_filled = true,
            primed = false
        },
        extra = { xchips = 2, light_counter = 0, light_counter_req = 5 },
    },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return { key = key, vars = { 
            card.ability.extra.xchips, card.ability.extra.light_counter, card.ability.extra.light_counter_req
        } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not card.ability.drink_values.filled and
            (context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds")) and not context.repetition then
            card.ability.extra.light_counter = card.ability.extra.light_counter + 1
            if card.ability.extra.light_counter >= card.ability.extra.light_counter_req then
                card.ability.extra.light_counter = 0
                card:abs_refill_drink()
            end
        end
        if context.joker_main and card.ability.drink_values.filled and card.ability.drink_values.primed and not context.repetition then
            local has_black = false
            for k, v in ipairs(G.hand.cards) do
                if v:is_suit('Clubs', nil, true) or v:is_suit('Spades', nil, true) then
                    has_black = true
                    break
                end
            end
            if has_black then
                card.ability.extra.light_counter = 0
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:abs_empty_drink()
                        return true
                    end
                }))
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end
    end,
    use = function(self, card, area, copier)
        card:abs_toggle_drink_prime()
    end,
    can_use = function(self, card)
        return card.ability.drink_values.filled
    end,
    keep_on_use = function(self, card)
        return true;
    end
}

SMODS.Consumable { -- Pina Solada
    set = 'abs_drinks',
    key = 'abs_pina_solada',
    ppu_coder = { 'iwas_nevergood' },
    ppu_team = { 'absinthe' },
    pos = { x = 9, y = 1 },
    config = {
        drink_values = {
            filled_pos = { x = 9, y = 1 },
            empty_pos = { x = 7, y = 1 },
            filled = true,
            visibly_filled = true,
            primed = false
        },
        extra = { xmult = 2, dark_counter = 0, dark_counter_req = 5 },
    },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return { key = key, vars = { 
            card.ability.extra.xmult, card.ability.extra.dark_counter, card.ability.extra.dark_counter_req
        } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not card.ability.drink_values.filled and
            (context.other_card:is_suit("Clubs") or context.other_card:is_suit("Spades")) and not context.repetition then
            card.ability.extra.dark_counter = card.ability.extra.dark_counter + 1
            if card.ability.extra.dark_counter >= card.ability.extra.dark_counter_req then
                card.ability.extra.dark_counter = 0
                card:abs_refill_drink()
            end
        end
        if context.joker_main and card.ability.drink_values.filled and card.ability.drink_values.primed and not context.repetition then
            local has_light = false
            for k, v in ipairs(G.hand.cards) do
                if v:is_suit('Hearts', nil, true) or v:is_suit('Diamonds', nil, true) then
                    has_light = true
                    break
                end
            end
            if has_light then
                card.ability.extra.light_counter = 0
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:abs_empty_drink()
                        return true
                    end
                }))
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
    use = function(self, card, area, copier)
        card:abs_toggle_drink_prime()
    end,
    can_use = function(self, card)
        return card.ability.drink_values.filled
    end,
    keep_on_use = function(self, card)
        return true;
    end
}

SMODS.Consumable { -- Meteor Sour
    set = 'abs_drinks',
    key = 'abs_meteor_sour',
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    pos = { x = 0, y = 0 },
    config = {
        drink_values = {
            filled_pos = { x = 0, y = 0 },
            empty_pos = { x = 1, y = 0 },
            filled = true,
            visibly_filled = true,
            primed = false
        },
        extra = { hands = 1, enh_discarded = 0, goal = 5 },
    },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return { key = key, vars = { card.ability.extra.hands, localize(Wormhole.Absinthe.get_most_played_hand(), 'poker_hands'), card.ability.extra.enh_discarded, card.ability.extra.goal } }
    end,
    calculate = function(self, card, context)
        if context.after and G.GAME.hands[context.scoring_name].played >= G.GAME.hands[Wormhole.Absinthe.get_most_played_hand()].played and card.ability.drink_values.filled and card.ability.drink_values.primed then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_hands_played(card.ability.extra.hands, true)
                    SMODS.calculate_effect( { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } }, colour = G.C.BLUE }, card)
                    card:abs_empty_drink()
                    return true;
                end
            }))
        end

        if context.discard and next(SMODS.get_enhancements(context.other_card)) and not card.ability.extra.goal_met and not card.ability.drink_values.filled then
            card.ability.extra.enh_discarded = card.ability.extra.enh_discarded + 1
            SMODS.calculate_effect( { message = card.ability.extra.enh_discarded .. '/' .. card.ability.extra.goal, colour = G.C.ATTENTION, delay = 0.2 }, card )
            if card.ability.extra.enh_discarded >= card.ability.extra.goal then
                card.ability.extra.goal_met = true
                card.ability.extra.enh_discarded = 0
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.goal_met = nil
                        card:abs_refill_drink()
                        return true;
                    end
                }))
            end
        end
    end,
    use = function(self, card, area, copier)
        card:abs_toggle_drink_prime()
    end,
    can_use = function(self, card)
        return card.ability.drink_values.filled
    end,
    keep_on_use = function(self, card)
        return true;
    end
}

SMODS.Consumable { -- Cosmospolitan
    set = 'abs_drinks',
    key = 'abs_cosmospolitan',
    ppu_coder = { 'theAstra' },
    ppu_team = { 'absinthe' },
    pos = { x = 0, y = 0 },
    config = {
        drink_values = {
            filled_pos = { x = 0, y = 0 },
            empty_pos = { x = 1, y = 0 },
            filled = true,
            visibly_filled = true,
            primed = false
        },
        extra = { current_team = nil, planets_used = 0, goal = 2 },
    },
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        local team_name = card.ability.extra.current_team.loc and localize{ type = 'name', set = 'PotatoPatch', key = card.ability.extra.current_team.loc } or card.ability.extra.current_team.name
        return { key = key, vars = { team_name, card.ability.extra.planets_used, card.ability.extra.goal, colours = { card.ability.extra.current_team.colour } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and card.ability.drink_values.primed and card.ability.drink_values.filled then
            SMODS.add_card({ key = Wormhole.Absinthe.get_team_card_key(card.ability.extra.current_team.name, 'abs_cosmos') })
            card:abs_empty_drink()
        end

        if context.using_consumeable and context.consumeable.ability.set == 'Planet' and not card.ability.drink_values.filled and not card.ability.extra.goal_met then
            card.ability.extra.planets_used = card.ability.extra.planets_used + 1
            SMODS.calculate_effect({ message = card.ability.extra.planets_used .. '/' .. card.ability.extra.goal, colour = G.C.ATTENTION }, card)
            if card.ability.extra.planets_used >= card.ability.extra.goal then
                card.ability.extra.goal_met = true
                card.ability.extra.planets_used = 0
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.goal_met = nil
                        card:abs_refill_drink()
                        return true;
                    end
                }))
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.current_team = Wormhole.Absinthe.get_random_team()
    end,
    use = function(self, card, area, copier)
        card:abs_toggle_drink_prime()
    end,
    can_use = function(self, card)
        return card.ability.drink_values.filled
    end,
    keep_on_use = function(self, card)
        return true;
    end
}


--#endregion
