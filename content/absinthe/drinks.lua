--#region Type and Boosters

SMODS.ConsumableType {
    key = 'abs_drinks',
    default = 'c_worm_abs_stargarita',
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
    select_card = 'consumeable',
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
    select_card = 'consumeable',
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
    select_card = 'consumeable',
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
    select_card = 'consumeable',
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
            if self.visibly_filled and self.children.center.sprite_pos ~= self.filled_pos then
                self.children.center:set_sprite_pos(self.filled_pos)
            elseif not self.visibly_filled and self.children.center.sprite_pos ~= self.empty_pos then
                self.children.center:set_sprite_pos(self.empty_pos)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

function Card:refill_drink()
    self.filled = true

    if self.config.refill and type(self.config.refill) == 'function' then
        self.config:refill(self)
    end

    SMODS.calculate_effect({ message = localize('k_worm_abs_refilled_ex'), colour = G.C.ATTENTION, func = function() self.visibly_filled = true end }, self)
    SMODS.calculate_context({abs_drink_refilled = true, card = self})
end

--#endregion

--#region Drink Objects

SMODS.Consumable {
    set = 'abs_drinks',
    name = 'testname',
    key = 'test_drink'
}

--#endregion
