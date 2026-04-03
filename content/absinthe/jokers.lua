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
    blueprint_compat = true, perishable_compat = true, eternal_compat = true,
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