--#region Objects

SMODS.ConsumableType {
    key = 'abs_drinks',
    default = 'c_worm_abs_stargarita',
    primary_colour = HEX('e3dbc8'),
    secondary_colour = HEX('f5c242'),
    collection_rows = { 5, 6 },
    shop_rate = 0.0
}

SMODS.Atlas {
    key = 'abs_drinks',
    path = 'absinthe/abs_drinks.png',
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'abs_boosters',
    path = 'absinthe/abs_boosters.png',
    px = 71,
    py = 95
}

SMODS.Sound({
	key = "abs_drink",
	path = "absinthe/drink.ogg",
})

-- can[dy] crush
SMODS.Sound({
	key = "abs_crush",
	path = "absinthe/crush.ogg",
})

SMODS.Sound({
	key = "abs_refill",
	path = "absinthe/refill.ogg",
})

SMODS.Attribute {
    key = 'drinks'
}

SMODS.Booster {
    key = "abs_top_shelf_normal_1",
    kind = "abs_drinks",
    group_key = "k_worm_abs_top_shelf_pack",
    atlas = "abs_boosters",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    ppu_coder = { 'theAstra' },
    ppu_artist = { 'AnneBean' },
    ppu_team = { 'absinthe' },
    cost = 5,
    weight = 0.96,
    select_card = 'consumeables',
    create_card = function(self, card)
        return create_card("abs_drinks", G.pack_cards, nil, nil, true, true, nil, "worm_abs_top_shelf")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.abs_drinks)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.abs_drinks, special_colour = G.C.BLACK, contrast = 1 })
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.03,
            scale = 0.3,
            lifespan = 5,
            speed = 3,
            vel_variation = 0.3,
            padding = -2,
            r_vel = 0,
            attach = G.ROOM_ATTACH,
            colours = { adjust_alpha(G.C.WHITE, 0.4), adjust_alpha(HEX('fddca0'), 0.2), adjust_alpha(G.C.SET.abs_drinks, 0.3) },
            fill = true,
            rotation = math.pi,
            rotation_variance = 0,
            shape = 'circle',
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end
}

SMODS.Booster {
    key = "abs_top_shelf_normal_2",
    kind = "abs_drinks",
    group_key = "k_worm_abs_top_shelf_pack",
    atlas = "abs_boosters",
    pos = {
        x = 1,
        y = 0
    },
    config = {
        extra = 2,
        choose = 1
    },
    ppu_coder = { 'theAstra' },
    ppu_artist = { 'AnneBean' },
    ppu_team = { 'absinthe' },
    cost = 5,
    weight = 0.96,
    select_card = 'consumeables',
    create_card = function(self, card)
        return create_card("abs_drinks", G.pack_cards, nil, nil, true, true, nil, "worm_abs_top_shelf")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.abs_drinks)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.abs_drinks, special_colour = G.C.BLACK, contrast = 1 })
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.03,
            scale = 0.3,
            lifespan = 5,
            speed = 3,
            vel_variation = 0.3,
            padding = -2,
            r_vel = 0,
            attach = G.ROOM_ATTACH,
            colours = { adjust_alpha(G.C.WHITE, 0.4), adjust_alpha(HEX('fddca0'), 0.2), adjust_alpha(G.C.SET.abs_drinks, 0.3) },
            fill = true,
            rotation = math.pi,
            rotation_variance = 0,
            shape = 'circle',
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end
}

SMODS.Booster {
    key = "abs_top_shelf_jumbo_1",
    kind = "abs_drinks",
    group_key = "k_worm_abs_top_shelf_pack",
    atlas = "abs_boosters",
    pos = {
        x = 2,
        y = 0
    },
    config = {
        extra = 4,
        choose = 1
    },
    ppu_coder = { 'theAstra' },
    ppu_artist = { 'AnneBean' },
    ppu_team = { 'absinthe' },
    cost = 7,
    weight = 0.48,
    select_card = 'consumeables',
    create_card = function(self, card)
        return create_card("abs_drinks", G.pack_cards, nil, nil, true, true, nil, "worm_abs_top_shelf")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.abs_drinks)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.abs_drinks, special_colour = G.C.BLACK, contrast = 1 })
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.03,
            scale = 0.3,
            lifespan = 5,
            speed = 3,
            vel_variation = 0.3,
            padding = -2,
            r_vel = 0,
            attach = G.ROOM_ATTACH,
            colours = { adjust_alpha(G.C.WHITE, 0.4), adjust_alpha(HEX('fddca0'), 0.2), adjust_alpha(G.C.SET.abs_drinks, 0.3) },
            fill = true,
            rotation = math.pi,
            rotation_variance = 0,
            shape = 'circle',
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(card.ability.choose + (G.GAME.modifiers.booster_choice_mod or 0), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0))), math.max(1, card.ability.extra + (G.GAME.modifiers.booster_size_mod or 0)) } }
    end
}

SMODS.Booster {
    key = "abs_top_shelf_mega_1",
    kind = "abs_drinks",
    group_key = "k_worm_abs_top_shelf_pack",
    atlas = "abs_boosters",
    pos = {
        x = 3,
        y = 0
    },
    config = {
        extra = 4,
        choose = 2
    },
    ppu_coder = { 'theAstra' },
    ppu_artist = { 'AnneBean' },
    ppu_team = { 'absinthe' },
    cost = 10,
    weight = 0.12,
    select_card = 'consumeables',
    create_card = function(self, card)
        return create_card("abs_drinks", G.pack_cards, nil, nil, true, true, nil, "worm_abs_top_shelf")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.abs_drinks)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.abs_drinks, special_colour = G.C.BLACK, contrast = 1 })
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.03,
            scale = 0.3,
            lifespan = 5,
            speed = 3,
            vel_variation = 0.3,
            padding = -2,
            r_vel = 0,
            attach = G.ROOM_ATTACH,
            colours = { adjust_alpha(G.C.WHITE, 0.4), adjust_alpha(HEX('fddca0'), 0.2), adjust_alpha(G.C.SET.abs_drinks, 0.3) },
            fill = true,
            rotation = math.pi,
            rotation_variance = 0,
            shape = 'circle',
        })
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
        if (self.ability.set == 'abs_drinks' or self.config.center.soul_set == 'abs_drinks') and self.config.center.discovered then
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

        SMODS.calculate_effect({ message = localize('k_worm_abs_refilled_ex'), colour = G.C.SECONDARY_SET.abs_drinks, sound = 'worm_abs_refill', per = 1 }, self)
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

        local can_drink_twice = G.GAME.used_vouchers['v_worm_abs_on_the_house']

        if can_drink_twice and self.first_drink or not can_drink_twice then
            G.E_MANAGER:add_event(Event({
                func = function()
                    self.ability.drink_values.visibly_filled = false
                    return true;
                end
            }))
        end

        if can_drink_twice and not self.first_drink then
            self.first_drink = true
            self.ability.drink_values.filled = true
            SMODS.calculate_effect({ message = localize('k_worm_abs_sipped_ex'), colour = G.C.SECONDARY_SET.abs_drinks, sound = self.ability.drink_values.empty_sound, per = 1 }, self)
        else
            self.first_drink = nil
            SMODS.calculate_effect({ message = localize('k_worm_abs_emptied_ex'), colour = G.C.SECONDARY_SET.abs_drinks, sound = self.ability.drink_values.empty_sound, per = 1 }, self)
        end

        SMODS.calculate_context({ abs_drink_emptied = true, card = self })
    end
end

function Card:abs_toggle_drink_prime()
    if self.ability.set == 'abs_drinks' or self.config.center.soul_set == 'abs_drinks' then
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
    pos = { x = 4, y = 0 },
    atlas = 'abs_drinks',
    ppu_coder = { 'pi_cubed' },
    ppu_artist = { 'AstraLuna' },
    ppu_team = { 'absinthe' },
    config = {
        drink_values = {
            filled_pos = { x = 4, y = 0 },
            empty_pos = { x = 5, y = 0 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
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
        return {
            key = key,
            vars = {
                card.ability.extra.discards,
                localize(card.ability.extra.poker_hand, 'poker_hands')
            }
        }
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
                    SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_discards', vars = { card.ability.extra.discards } }, colour = G.C.RED }, card)
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
                    SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_discards', vars = { card.ability.extra.discards } }, colour = G.C.RED, }, card)
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
    atlas = 'abs_drinks',
    pos = { x = 0, y = 1 },
    ppu_coder = { 'pi_cubed' },
    ppu_artist = { 'AstraLuna' },
    ppu_team = { 'absinthe' },
    config = {
        drink_values = {
            filled_pos = { x = 0, y = 1 },
            empty_pos = { x = 1, y = 1 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
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
            SMODS.calculate_effect({ level_up = true, level_up_hand = text }, card)
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
    atlas = 'abs_drinks',
    pos = { x = 0, y = 3 },
    ppu_coder = { 'AstraLuna' },
    ppu_artist = { 'AstraLuna' },
    ppu_team = { 'absinthe' },
    config = {
        drink_values = {
            filled_pos = { x = 0, y = 3 },
            empty_pos = { x = 1, y = 3 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
        },
        extra = { chips = 60, light_counter = 0, light_counter_req = 5, dark_counter = 0 },
    },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return {
            key = key,
            vars = {
                card.ability.extra.chips, card.ability.extra.light_counter, card.ability.extra.light_counter_req
            }
        }
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
        if context.individual and context.cardarea == G.play and card.ability.drink_values.filled and card.ability.drink_values.primed and
            (context.other_card:is_suit("Clubs") or context.other_card:is_suit("Spades")) then
            card.ability.extra.dark_counter = card.ability.extra.dark_counter + 1
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.after and card.ability.drink_values.filled and card.ability.drink_values.primed 
        and card.ability.extra.dark_counter > 0 and not context.repetition then
            card.ability.extra.dark_counter = 0
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:abs_empty_drink()
                    return true
                end
            }))
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
    atlas = 'abs_drinks',
    ppu_coder = { 'AstraLuna' },
    ppu_artist = { 'AstraLuna' },
    ppu_team = { 'absinthe' },
    pos = { x = 0, y = 0 },
    config = {
        drink_values = {
            filled_pos = { x = 0, y = 0 },
            empty_pos = { x = 1, y = 0 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
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
        return {
            key = key,
            vars = {
                card.ability.extra.xmult, card.ability.extra.dark_counter, card.ability.extra.dark_counter_req
            }
        }
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
    atlas = 'abs_drinks',
    ppu_coder = { 'theAstra' },
    ppu_artist = { 'pangaea47' },
    ppu_team = { 'absinthe' },
    pos = { x = 0, y = 2 },
    config = {
        drink_values = {
            filled_pos = { x = 0, y = 2 },
            empty_pos = { x = 1, y = 2 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
        },
        extra = { hands = 1, enh_discarded = 0, goal = 4 },
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
                    SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } }, colour = G.C.BLUE  }, card)
                    card:abs_empty_drink()
                    return true;
                end
            }))
        end

        if context.discard and next(SMODS.get_enhancements(context.other_card)) and not card.ability.extra.goal_met and not card.ability.drink_values.filled then
            card.ability.extra.enh_discarded = card.ability.extra.enh_discarded + 1
            SMODS.calculate_effect({ message = card.ability.extra.enh_discarded .. '/' .. card.ability.extra.goal, colour = G.C.ATTENTION, delay = 0.2 }, card)
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
    atlas = 'abs_drinks',
    ppu_coder = { 'theAstra' },
    ppu_artist = { 'pangaea47' },
    ppu_team = { 'absinthe' },
    pos = { x = 4, y = 2 },
    config = {
        drink_values = {
            filled_pos = { x = 4, y = 2 },
            empty_pos = { x = 5, y = 2 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
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
        local team_name = PotatoPatchUtils.Teams[card.ability.extra.current_team].loc and
            localize { type = 'name', set = 'PotatoPatch', key = PotatoPatchUtils.Teams[card.ability.extra.current_team].loc } or
            PotatoPatchUtils.Teams[card.ability.extra.current_team].name
        return { key = key, vars = { team_name, card.ability.extra.planets_used, card.ability.extra.goal, colours = { PotatoPatchUtils.Teams[card.ability.extra.current_team].colour } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and card.ability.drink_values.primed and card.ability.drink_values.filled then
            local key = SMODS.poll_object({ attributes = { card.ability.extra.current_team }, rarity = false })
            local area = G[Wormhole.Absinthe.get_card_area_to_emplace(key)]
            if area then
                local buffer = area == G.jokers and 'joker_buffer' or 'consumeable_buffer'
                if #area.cards + G.GAME[buffer] < area.config.card_limit then
                    G.GAME[buffer] = G.GAME[buffer] + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = SMODS.add_card({ key = key, area = area })
                            if _card.ability.set == 'Voucher' or _card.ability.set == 'Booster' then
                                _card.cost = 0
                            end
                            card:abs_empty_drink()
                            G.GAME[buffer] = 0
                            return true;
                        end
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            Wormhole.Absinthe.alert_no_space(card, area, {0.51, 0.28, 0.43, 0.7})
                            return true;
                        end
                    }))
                end
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = SMODS.add_card({ key = key })
                        if _card.ability.set == 'Voucher' or _card.ability.set == 'Booster' then
                            _card.cost = 0
                        end
                        card:abs_empty_drink()
                        return true;
                    end
                }))
            end
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
    refill = function(self, card)
        card.ability.extra.current_team = 'worm_' .. Wormhole.Absinthe.get_random_team().name
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.current_team = 'worm_' .. Wormhole.Absinthe.get_random_team().name
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

SMODS.Consumable { -- Voidka
    set = 'abs_drinks',
    key = 'abs_voidka',
    atlas = 'abs_drinks',
    ppu_coder = { 'pi_cubed' },
    ppu_artist = { 'AstraLuna' },
    ppu_team = { 'absinthe' },
    pos = { x = 2, y = 1 },
    config = {
        drink_values = {
            filled_pos = { x = 2, y = 1 },
            empty_pos = { x = 3, y = 1 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
        },
        extra = { dollars_req = 10, dollars_spent = 0 },
    },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return {
            key = key,
            vars = {
                card.ability.extra.dollars_req, card.ability.extra.dollars_spent
            }
        }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroying_card -- somehow this successfully only destroys the 1st card??
            and card.ability.drink_values.filled and card.ability.drink_values.primed and not context.repetition then
            card:abs_empty_drink()
            return {
                remove = true,
            }
        end

        if context.money_altered and context.amount < 0 and not card.ability.drink_values.filled then
            card.ability.extra.dollars_spent = card.ability.extra.dollars_spent - context.amount
            if card.ability.extra.dollars_spent >= card.ability.extra.dollars_req then
                card.ability.extra.dollars_spent = 0
                card:abs_refill_drink()
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

SMODS.Consumable { -- Big Bang Brandy
    set = 'abs_drinks',
    key = 'abs_big_bang_brandy',
    ppu_coder = { 'pi_cubed' },
    ppu_artist = { 'pangaea47' },
    ppu_team = { 'absinthe' },
    atlas = 'abs_drinks',
    pos = { x = 4, y = 1 },
    config = {
        drink_values = {
            filled_pos = { x = 4, y = 1 },
            empty_pos = { x = 5, y = 1 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
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
        if context.before and card.ability.drink_values.filled
            and card.ability.drink_values.primed and not context.repetition
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    SMODS.add_card {
                        set = 'Spectral',
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            SMODS.calculate_effect({ message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral }, card)
            card:abs_empty_drink()
        end

        if context.skipping_booster and not card.ability.drink_values.filled then
            card:abs_refill_drink()
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

SMODS.Consumable { -- John Absinthe
    set = 'Spectral',
    soul_set = 'abs_drinks',
    key = 'abs_absinthe',
    ppu_coder = { 'pi_cubed', 'theAstra' },
    ppu_artist = { 'pangaea47' },
    ppu_team = { 'absinthe' },
    pos = { x = 4, y = 3 },
    atlas = "abs_drinks",
    config = {
        drink_values = {
            filled_pos = { x = 4, y = 3 },
            empty_pos = { x = 5, y = 3 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
        },
        extra = { gain = 2 },
    },
    hidden = true,
    cost = 20,
    select_card = 'consumeables',
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return {
            key = key,
            vars = {
                card.ability.extra.gain
            }
        }
    end,
    calculate = function(self, card, context)

        if context.before and card.ability.drink_values.filled and card.ability.drink_values.primed then
            for k, v in ipairs(context.scoring_hand) do
                v.ability.perma_p_dollars = v.ability.perma_p_dollars + card.ability.extra.gain
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v.absinthe_modified = true
                        v:juice_up()
                        return true
                    end
                }))
            end
            card:abs_empty_drink()
        end

        if context.using_consumeable and context.consumeable.config.center.set == 'Spectral' and not card.ability.drink_values.filled then
            card:abs_refill_drink()
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
    end,
}

SMODS.Consumable {                -- Spacewalk Seltzer
    set = 'abs_drinks',
    key = 'abs_spacewalk_selzer', -- yes I misspelled this on purpose because of vanilla balatro lmao
    ppu_coder = { 'theAstra' },
    ppu_artist = { 'AnneBean' },
    ppu_team = { 'absinthe' },
    atlas = 'abs_drinks',
    pos = { x = 2, y = 2 },
    config = {
        drink_values = {
            filled_pos = { x = 2, y = 2 },
            empty_pos = { x = 3, y = 2 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
        },
        extra = { reps = 1 },
    },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return { key = key, vars = { card.ability.extra.reps } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and card.ability.drink_values.primed and card.ability.drink_values.filled then
            return {
                repetitions = card.ability.extra.reps
            }
        end

        if context.after and card.ability.drink_values.primed and card.ability.drink_values.filled then
            card:abs_empty_drink()
        end

        if context.remove_playing_cards and not card.ability.extra.filled then
            card:abs_refill_drink()
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

SMODS.Consumable { -- Stargarita
    set = 'abs_drinks',
    key = 'abs_stargarita',
    pos = { x = 2, y = 0 },
    atlas = 'abs_drinks',
    ppu_coder = { 'base4' },
    ppu_artist = { 'AstraLuna' },
    ppu_team = { 'absinthe' },
    config = {
        drink_values = {
            filled_pos = { x = 2, y = 0 },
            empty_pos = { x = 3, y = 0 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_drink",
        },
        extra = { drawn_cards = 2 },
    },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return {
            key = key,
            vars = {
                card.ability.extra.drawn_cards
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not card.ability.drink_values.filled and
            context.consumeable.config.center.set == 'Tarot' then
            card:abs_refill_drink()
        end

        if context.drawing_cards and card.ability.drink_values.filled and card.ability.drink_values.primed and not context.repetition then
            G.E_MANAGER:add_event(Event({
                func = function()
                    draw_card(G.deck, G.hand)
                    draw_card(G.deck, G.hand)
                    SMODS.calculate_effect({ message = localize { type = 'variable', key = 'a_drawn', vars = { card.ability.extra.drawn_cards } }, colour = G.C.BLUE, }, card)
                    card:abs_empty_drink()
                    return true
                end
            }))
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

SMODS.Consumable { -- Nebulager
    set = 'abs_drinks',
    key = 'abs_nebulager',
    ppu_coder = { 'theAstra' },
    ppu_artist = { 'nixthatoneartist' },
    ppu_team = { 'absinthe' },
    pos = { x = 2, y = 3 },
    atlas = 'abs_drinks',
    config = {
        drink_values = {
            filled_pos = { x = 2, y = 3 },
            empty_pos = { x = 3, y = 3 },
            filled = true,
            visibly_filled = true,
            primed = false,
            empty_sound = "worm_abs_crush",
        },
        extra = { current_sold = 0, sold_goal = 2 },
    },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        local key
        if not card.ability.drink_values.filled then
            key = self.key .. '_empty'
        else
            key = self.key
        end
        return { key = key, vars = { card.ability.extra.current_sold, card.ability.extra.sold_goal } }
    end,
    calculate = function(self, card, context)
        if card.ability.drink_values.primed and card.ability.drink_values.filled and context.stay_flipped and context.from_area == G.play and context.to_area == G.discard then
            return {
                modify = {to_area = G.hand},
                func = function()
                    if not card.ability.extra.triggered then
                        card.ability.extra.triggered = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card.ability.extra.triggered = nil
                                card:abs_empty_drink()
                                return true;
                            end
                        }))
                    end
                end
            }
        end

        if context.selling_card and not card.ability.drink_values.filled then
            card.ability.extra.current_sold = card.ability.extra.current_sold + 1
            SMODS.calculate_effect({ message = card.ability.extra.current_sold .. '/' .. card.ability.extra.sold_goal, colour = G.C.ATTENTION }, card)
            if card.ability.extra.current_sold >= card.ability.extra.sold_goal then
                card.ability.extra.current_sold = 0
                card:abs_refill_drink()
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

--#endregion
