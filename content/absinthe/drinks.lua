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

--#endregion
