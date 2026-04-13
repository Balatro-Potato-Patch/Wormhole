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
    rarity = 3,
    cost = 6,
    blueprint_compat = false,
    pools = {
        ["Bartender"] = true
    },
    config = { extra = {
        items = 1
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.items}}
    end,
    calculate = function(self, card, context)
        --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/jokers.lua#L2586
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_lucky') then
            -- add drunk if lucky card not drunk
            local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_drunk", weight = 1}}})
            if not context.other_card.edition or (context.other_card.edition and not context.other_card.edition == edition) then
                context.other_card:set_edition(edition, true, true)
            end
            -- spawn menu item if lucky card triggered
            --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/jokers.lua#L608
            if context.other_card.lucky_trigger and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({set = "worm_hedonia_menu", area = G.consumeables, key_append = '_casino'})
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Joker {
    key = "hedonia_trash",
    atlas = "joker",
    pos = {x = 0, y = 1},
    rarity = 3,
    cost = 6,
    blueprint_compat = false,
    config = { extra = {
        copied = {}
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.copied}}
    end,
    calculate = function(self, card, context) --used a lot of pinkprint for this https://github.com/EremelMods/Ortalab/blob/main/objects/jokers/pinkprint.lua
        if context.selling_card and context.card.ability.set == 'Joker' then
            -- table.insert(self.ability.extra.copied, context.card.)
            print(#card.ability.extra.copied)
        end
        if context.joker_main then
            print(#card.ability.extra.copied)
            for i = 1, #card.ability.extra.copied do
                SMODS.blueprint_effect(self.ability.extra.copied[i], card, context)
                print(i)
            end
        end
        if context.end_of_round and context.game_over == false then
            local length = #card.ability.extra.copied
            for i = 1, length do
               card.ability.extra.copied.remove()
            end
            return {
                message = "Clear!"
            }
        end
        --when scoring
            --for each item in list
                --trigger blueprint func
        --when end of round
            --empty list
    end,
    add_to_deck = function()
        G.jokers:change_size(-1)
    end,
    remove_from_deck = function()
        G.jokers:change_size(1)
    end
}

SMODS.Joker {
    key = "hedonia_patron",
    atlas = "joker",
    pos = {x = 1, y = 1},
    rarity = 3,
    cost = 6,
    blueprint_compat = false,
    config = { extra = {
        mult = 10
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local counter = 0
            for i,v in pairs(G.hand.cards) do
                if v.edition and (
                    v.edition.key == 'e_worm_hedonia_tipsy' or
                    v.edition.key == 'e_worm_hedonia_drunk' or
                    v.edition.key == 'e_worm_hedonia_very_drunk' or
                    v.edition.key == 'e_worm_hedonia_blackout'
                ) then
                    counter = counter + 1
                end
            end
            if counter > 0 then 
                return {
                    mult = card.ability.extra.mult * counter
                }
            end
        end
    end
}

SMODS.Joker {
    key = "hedonia_speed",
    atlas = "joker",
    pos = {x = 1, y = 0},
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    pools = {
        ["Bartender"] = true
    },
    loc_vars = function(self,info_queue,center)
        local num, denom
        if G.jokers ~= nil then
            num = #G.jokers.cards
            denom = G.jokers.config.card_limit
        else
            num = 1
            denom = 5
        end
        return {vars = {num, denom}}
    end,
    calculate = function(self,card,context)
        if context.joker_main and pseudorandom('speed') < #G.jokers.cards / G.jokers.config.card_limit and 
        #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({set = "worm_hedonia_menu", area = G.consumeables, key_append = 'speed'})
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
        end
    end
}

SMODS.Joker {
    key = "hedonia_bar_mitzvah",
    atlas = "joker",
    pos = {x = 2, y = 0},
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    pools = {
        ["Bartender"] = true
    },
    config = { extra = {
        current = 0,
        threshold = 13
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.threshold, center.ability.extra.threshold - center.ability.extra.current}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if card.ability.extra.current == card.ability.extra.threshold then
                local empty_slots = G.consumeables.config.card_limit - (#G.consumeables.cards)
                if empty_slots > 0 then
                    for i=1,empty_slots do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('timpani')
                                SMODS.add_card({set = "worm_hedonia_menu", area = G.consumeables, key_append = 'bar_mitzvah'})
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                    end
                    card.ability.extra.current = 0
                end
            else
                card.ability.extra.current = card.ability.extra.current + 1
                return {
                    message = 'Upgrade!'
                }
            end
        end
    end
}

SMODS.Joker {
    key = "hedonia_happy_hour",
    atlas = "joker",
    pos = {x = 2, y = 1},
    rarity = 3,
    cost = 6,
    blueprint_compat = false,
    config = { extra = {
        discount = 2
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.discount}}
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