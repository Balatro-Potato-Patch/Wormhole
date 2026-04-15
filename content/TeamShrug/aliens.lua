-- DEFINE COLORS
G.C.SET.shrug_alien = HEX('C87ED3')
G.C.SECONDARY_SET.shrug_alien = HEX('C87ED3')

SMODS.ConsumableType{
    key = 'shrug_alien',
    default = 'c_worm_shrug_alien_martian',
    collection_rows = {4, 4},
    primary_colour = G.C.SET.shrug_alien,
    secondary_colour = G.C.SECONDARY_SET.shrug_alien,
    shop_rate = 0.0,
}
SMODS.Atlas{ key = 'shrug_alien_cards',
    path = 'TeamShrug/consumables.png',
    px = 71,
    py = 95
}
SMODS.UndiscoveredSprite{
    key = 'shrug_alien',
    atlas = 'shrug_alien_cards',
    pos = {x = 0, y = 0}
}

SMODS.Atlas{
    key = 'shrug_boosters',
    path = 'TeamShrug/boosters.png',
    px = 71,
    py = 95
}
-- ALIEN PACKS
local alien_booster = SMODS.Booster:extend{
    group_key = "shrug_alien_pack",
    kind = "shrug_alien_pack",
    draw_hand = true,
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.choose, center.ability.extra}}
    end,
    create_card = function(self, card)
        return SMODS.create_card({set = "shrug_alien", area = G.pack_cards, skip_materialize = true})
    end,
    select_card = function(card, pack) ----- ENABLE TO ALLOW TO TAKE PACK CARD TO CONSUMABLE SLOTS
        return false
    end,
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"},
    ppu_artist = {"waffle"}
}
alien_booster{
    key = "shrug_alien_normal_1",
    config = {extra = 2, choose = 1},
    cost = 4,
    weight = 0.3,
    atlas = "shrug_boosters",
    pos = {x = 0, y = 0},
}
alien_booster{
    key = "shrug_alien_normal_2",
    config = {extra = 2, choose = 1},
    cost = 4,
    weight = 0.3,
    atlas = "shrug_boosters",
    pos = {x = 1, y = 0},
}
alien_booster{
    key = "shrug_alien_jumbo",
    config = {extra = 4, choose = 1},
    cost = 6,
    weight = 0.3,
    atlas = "shrug_boosters",
    pos = {x = 2, y = 0},
}
alien_booster{
    key = "shrug_alien_mega",
    config = {extra = 4, choose = 2},
    cost = 8,
    weight = 0.07,
    atlas = "shrug_boosters",
    pos = {x = 3, y = 0},
}


-- TAG
SMODS.Atlas{
    key = 'shrug_alien_tag',
    path = 'TeamShrug/tags.png',
    px = 34,
    py = 34
}
SMODS.Tag{
    key = "shrug_conspiracy",
    min_ante = 2,
    atlas = 'shrug_alien_tag',
    pos = {x = 0, y = 0},
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_worm_shrug_alien_normal_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.shrug_alien, function()
                local booster = SMODS.create_card{key = 'p_worm_shrug_alien_normal_1', area = G.play}
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end,
    ppu_artist = {"randomsongv2"},
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"}
}

-- suit conversion alien funcitons
local function reset_suit_conv_cardarea(offset)
    --row 1
    G.worm_shrug_alien_suit_conv = CardArea(
        G.CARD_W * 0.495 * (5.5 + offset), -- x coordinate
        G.CARD_H * 0.95 + 0.5, -- y coordinate
        G.CARD_W * 0.75, -- width
        G.CARD_H,--height
        {
            type = 'play',
            highlight_limit = 0,
            card_limit = 0, -- without this cardarea works weirdly, i dont know why
        }
    )
    --row 2
    G.worm_shrug_alien_suit_conv2 = CardArea(
        G.CARD_W * 0.495 * (5.5 + offset),
        G.CARD_H * 0.95 * 2 + 0.25,
        G.CARD_W * 0.75,
        G.CARD_H,
        {
            card_limit = 0,
            type = 'play',
            highlight_limit = 0,
        }
    )
end
-- move card to suit convert cardarea
local function add_to_suit_conv(card, cardarea_to, percent)
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.25,
        func = function()
            if card then
                local cardarea_from = card.area
                if cardarea_from then card = cardarea_from:remove_card(card) end
                if cardarea_from == G.deck or cardarea_from == G.hand or cardarea_from == G.play or cardarea_from == G.jokers or cardarea_from == G.consumeables or cardarea_from == G.discard then
                    G.VIBRATION = G.VIBRATION + 0.6
                end
                play_sound('card1', 0.85 + (percent or 100)*0.2/100, 0.6*(vol or 1))
                cardarea_to:emplace(card, nil, stay_flipped)
                card.no_ui = true
                cardarea_to.T.w = cardarea_to.T.w / math.max(#cardarea_to.cards, 1) * (#cardarea_to.cards + 1)
            end
            return true
        end
      }))
end
-- change suits in suit convert cardareas
local function alien_suit_change(suit)
    for i, c in ipairs(G.worm_shrug_alien_suit_conv.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.05, func = function() c:flip() return true end}))
    end
    for i, c in ipairs(G.worm_shrug_alien_suit_conv2.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.05, func = function() c:flip() return true end}))
    end
    for i, c in ipairs(G.worm_shrug_alien_suit_conv.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.05, func = function() SMODS.change_base(c, suit) return true end}))
    end
    for i, c in ipairs(G.worm_shrug_alien_suit_conv2.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.05, func = function() SMODS.change_base(c, suit) return true end}))
    end
    for i, c in ipairs(G.worm_shrug_alien_suit_conv.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.05, func = function() c:flip() return true end}))
    end
    for i, c in ipairs(G.worm_shrug_alien_suit_conv2.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.1, func = function() c:flip() return true end}))
    end
    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function() return true end}))
end
-- move card from suit convert cardarea to initial cardarea
local function draw_card_back(from, to, percent, card, no_ui)
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.25,
        func = function()
            card = from:remove_card(card)
            from.T.w = from.T.w / (#from.cards + 1) * #from.cards
            card.no_ui = no_ui
            to:emplace(card, nil, stay_flipped)
            play_sound('card1', 0.85 + percent*0.2/100, 0.6*(vol or 1))
            return true
        end
      }))
end
local function alien_suit_convert(suit, amount)
    local line_size = amount > 5 and math.max(math.ceil(amount / 2), 3) or amount
    reset_suit_conv_cardarea((5 - line_size) / 2)
    local _cards = {}
    for _, c in ipairs(G.playing_cards) do
        if c.config.card.suit ~= suit then
            table.insert(_cards, c)
        end
    end
    pseudoshuffle(_cards, "worm_shrug_alien_suit_" .. suit)
    local cards = {}
    local areas = {}
    local no_uis = {}
    for i, c in ipairs(_cards) do
        if #cards < amount then
            cards[i] = c
            areas[i] = c.area
            no_uis[i] = c.no_ui
        else
            break
        end
    end
    for i, c in ipairs(cards) do
        if i <= line_size and i <= amount then
             add_to_suit_conv(c, G.worm_shrug_alien_suit_conv, i * 100 / amount)
        elseif i <= amount then
             add_to_suit_conv(c, G.worm_shrug_alien_suit_conv2, i * 100 / amount)
        end
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.25,
        func = function()
            alien_suit_change(suit)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.25,
        func = function()
            for i, c in ipairs(G.worm_shrug_alien_suit_conv.cards) do
                draw_card_back(G.worm_shrug_alien_suit_conv, areas[i], i*100/amount, c, no_uis[i])
            end
            for i, c in ipairs(G.worm_shrug_alien_suit_conv2.cards) do
                draw_card_back(G.worm_shrug_alien_suit_conv2, areas[i + line_size], (i + line_size)*100/amount, c, no_uis[i + line_size])
            end
            return true
        end
    }))
end

local suit_alien = SMODS.Consumable:extend{
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.consumeable.extra.convert,
                card.ability.consumeable.extra.pay
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        card:juice_up(0.3, 0.5)
        ease_dollars(-card.ability.consumeable.extra.pay)
        delay(0.6)
        alien_suit_convert(card.ability.consumeable.extra.suit, card.ability.consumeable.extra.convert)
    end,
    unlocked = true,
    cost = 4,
    set = 'shrug_alien',
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"}
}
-- ALIEN CARDS
-- Flatwoods Monster
suit_alien{
    key = 'shrug_alien_spades',
    atlas = 'shrug_alien_cards',
    pos = {x = 2, y = 0},
    config = {extra = {suit = 'Spades', convert = 6, pay = 3}},
    ppu_artist = {"waffle", "microwave"}
}
-- Fresno Nightcrawlers
suit_alien{
    key = 'shrug_alien_hearts',
    atlas = 'shrug_alien_cards',
    pos = {x = 4, y = 0},
    config = {extra = {suit = 'Hearts', convert = 6, pay = 3}},
    ppu_artist = {"waffle", "microwave"}
}
-- Reptiloid
suit_alien{
    key = 'shrug_alien_clubs',
    atlas = 'shrug_alien_cards',
    pos = {x = 8, y = 0},
    config = {extra = {suit = 'Clubs', convert = 6, pay = 3}},
    ppu_artist = {"waffle", "microwave"}
}
-- Hopkinsville Goblin
suit_alien{
    key = 'shrug_alien_diamonds',
    atlas = 'shrug_alien_cards',
    pos = {x = 6, y = 0},
    config = {extra = {suit = 'Diamonds', convert = 6, pay = 3}},
    ppu_artist = {"waffle", "microwave"}
}

-- for martian and ???
local function flip_multiple(cards)
    for i, c in ipairs(cards) do
        local percent = 1.15 - (i - 0.999) / (#cards - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                c:flip()
                play_sound('card1', percent)
                c:juice_up(0.3, 0.3)
                return true
            end
        }))
    end
end

-- Martian
SMODS.Consumable{
    key = 'shrug_alien_martian',
    cost = 4,
    set = 'shrug_alien',
    atlas = 'shrug_alien_cards',
    pos = {x = 1, y = 0},
    unlocked = true,
    config = {extra = {selection = 4}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.selection}}
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted >= 2 and #G.hand.highlighted <= card.ability.extra.selection
    end,
    use = function(self, card, area, copier)
        local rank = G.hand.highlighted[1].config.card.value
        flip_multiple(G.hand.highlighted)
        for _, c in ipairs(G.hand.highlighted) do
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    SMODS.change_base(c, nil, rank)
                    return true
                end
            }))
        end
        delay(0.4)
        flip_multiple(G.hand.highlighted)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    ppu_artist = {"waffle", "microwave"},
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"}
}

-- ???
SMODS.Consumable{
    key = 'shrug_alien_nebulous',
    cost = 4,
    set = 'shrug_alien',
    atlas = 'shrug_alien_cards',
    pos = {x = 5, y = 0},
    unlocked = true,
    config = {extra = {odds = 2}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_worm_shrug_nebulous
        return {vars = {G.GAME.probabilities.normal, card.ability.extra.odds}}
    end,
    can_use = function(self, card)
        return G.hand and true
    end,
    use = function(self, card, area, copier)
        flip_multiple(G.hand.cards)
        for _, c in ipairs(G.hand.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if pseudorandom('worm_shrug_alien_nebulous_') < G.GAME.probabilities.normal / card.ability.extra.odds then
                        c:set_ability('m_worm_shrug_nebulous')
                    end
                    return true
                end
            }))
        end
        flip_multiple(G.hand.cards)
    end,
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"},
    ppu_artist = {"waffle", "microwave"}
}

-- Zeta Reticulan
SMODS.Consumable{
    key = 'shrug_alien_destroy',
    cost = 4,
    set = 'shrug_alien',
    atlas = 'shrug_alien_cards',
    pos = {x = 7, y = 0},
    unlocked = true,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted == 1
    end,
    use = function(self, card, area, copier)
        local to_destroy = {}
        for _, c in ipairs(G.hand.cards) do
            if c ~= G.hand.highlighted[1] then
                to_destroy[#to_destroy + 1] = c
            end
        end
        SMODS.destroy_cards(to_destroy)
    end,
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"},
    ppu_artist = {"waffle", "microwave"}
}

-- Skyfish
SMODS.Consumable{
    key = 'shrug_alien_skyfish',
    cost = 4,
    set = 'shrug_alien',
    atlas = 'shrug_alien_cards',
    pos = {x = 3, y = 0},
    unlocked = true,
    config = {extra = {}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'perishable', set = 'Other', vars = {5, 5}}
    end,
    can_use = function(self, card)
        return #G.jokers.cards ~= 0 and #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        local selected = pseudorandom_element(G.jokers.cards, 'worm_shrug_alien_joker_copy')
        local copied = copy_card(selected)
        if copied.ability.eternal then copied:remove_sticker('eternal') end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                card:juice_up(0.3, 0.5)
                copied:add_to_deck()
                G.jokers:emplace(copied)
                attention_text({
                    text = localize('k_duplicated_ex'),
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.shrug_alien,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0},
                    silent = true
                })

                -- adds perishable even for incompatable cards
                local perish_compat = copied.config.center.perishable_compat
                copied.config.center.perishable_compat = true
                if not copied.ability.perishable then copied:set_perishable() end
                copied.config.center.perishable_compat = perish_compat

                -- im not sure about resetting perishable state
                copied.ability.perish_tally = G.GAME.perishable_rounds

                return true
            end
        }))
    end,
    ppu_coder = {"randomsongv2"},
    ppu_team = {"shrug"},
    ppu_artist = {"waffle", "microwave"}
}
