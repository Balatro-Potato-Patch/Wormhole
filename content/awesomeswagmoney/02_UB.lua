SMODS.Atlas({key = "asm_ubs", path = "awesomeswagmoney/ubs.png", px = 89, py = 109, atlas_table = "ASSET_ATLAS"}):register()

SMODS.Consumable {
    key = 'pheromosa',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs', 
    pos = { x = 0, y = 0 }, 
    soul_pos = { x = 1, y = 0 }, 
    config = {extra_slots_used = 1, extra = {chips = 251}},

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,

    keep_on_use = function(self, card) return true end,

    can_use = function(self, card) return (not card.ability.active) end,

    use = function(self, card, area, copier)
        play_sound('timpani')
        card.ability.active = true
        local eval = function() return card.ability.active end
        juice_card_until(card, eval, true)
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            card:juice_up()
            if card.ability.active then
                return {chips = card.ability.extra.chips}
            end
        end

        if context.after then
            if card.ability.active then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card:start_dissolve({G.C.BLUE})
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Sound({key = "asm_buzz", path = 'buzz.ogg'})
SMODS.Consumable {
    key = 'buzzwole',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs', 
    pos = { x = 2, y = 0 }, 
    soul_pos = { x = 3, y = 0 }, 
    config = {extra_slots_used = 1, extra = {mult = 53}},

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    keep_on_use = function(self, card) return true end,

    can_use = function(self, card) return (not card.ability.active) end,

    use = function(self, card, area, copier)
        play_sound('timpani')
        card.ability.active = true
        local eval = function() return card.ability.active end
        juice_card_until(card, eval, true)
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.active then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up()
                        play_sound('worm_asm_buzz')
                        return true
                    end
                }))
                return {mult = card.ability.extra.mult}
            end
        end

        if context.after then
            if card.ability.active then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card:start_dissolve({G.C.BLUE})
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Consumable {
    key = "xurkitree",
    set = "worm_ultrabeast",
    atlas = 'worm_asm_ubs', 
    pos = { x = 2, y = 1 }, 
    soul_pos = { x = 3, y = 1 }, 
    config = { extra_slots_used = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { PRIMES[G.GAME.asm_xurkitree] or 17 }}
    end,
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        G.GAME.asm_xurkitree = G.GAME.asm_xurkitree or 7
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(PRIMES[G.GAME.asm_xurkitree], true)
                G.GAME.asm_xurkitree = G.GAME.asm_xurkitree + 1
                return true
            end
        }))
        delay(0.6)
    end
}

SMODS.Consumable {
    key = "kartana",
    set = "worm_ultrabeast",
    atlas = 'worm_asm_ubs', 
    pos = { x = 2, y = 0 }, 
    soul_pos = { x = 3, y = 0 }, 
    config = { extra_slots_used = 1, extra = { copies = 4, reduction = 2}},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.copies, card.ability.extra.reduction }}
    end,
    can_use = function (self, card)
        return #G.hand.highlighted == 1
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                local _card = G.hand.highlighted[1]
                play_sound('slice1', 0.96+math.random()*0.08)
                for i = 1, card.ability.extra.copies do
                    local copy = copy_card(_card, nil, nil, G.playing_card)
                    copy:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copy)
                    G.hand:emplace(copy)
                    assert(SMODS.modify_rank(copy, -card.ability.extra.reduction))
                end
                _card:juice_up(0.3, 0.5)
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.6)

    end
}

SMODS.Sound({key = "asm_clownhonk", path = 'clownhonk.ogg'})
SMODS.Sound({key = "asm_boom", path = 'explosion.ogg'})

SMODS.Consumable {
    key = "blacephalon",
    set = "worm_ultrabeast",
    atlas = 'worm_asm_ubs', 
    pos = { x = 0, y = 1 }, 
    soul_pos = { x = 1, y = 1 }, 

    config = { extra_slots_used = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = {  }}
    end,
    can_use = function (self, card)
        return G.hand
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('worm_asm_boom', 0.96+math.random()*0.08, 0.3)
                local _card = pseudorandom_element(G.hand.cards,pseudoseed('clown'))
                _card:set_edition('e_polychrome')
                for k, v in ipairs(G.hand.cards) do
                    if v ~= _card then 
                        v:juice_up(5, 0.5)
                        delay(0.5/#G.hand.cards)
                        SMODS.destroy_cards(v, nil, true)
                    end
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.8,
            func = function()
                for i = 1, G.hand.config.card_limit-1 do
                    draw_card(G.deck,G.hand, 90,'up', true)
                end
                return true
            end
        }))

        delay(0.6)

    end
}

SMODS.Consumable {
    key = "celesteela",
    set = "worm_ultrabeast",
    atlas = 'worm_asm_ubs', 
    pos = { x = 2, y = 1 }, 
    soul_pos = { x = 3, y = 1 }, 
    config = { extra_slots_used = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { PRIMES[G.GAME.asm_celesteela] or 2 }}
    end,
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        G.GAME.asm_celesteela = G.GAME.asm_celesteela or 1
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                G.hand:change_size(PRIMES[G.GAME.asm_celesteela])
                G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + PRIMES[G.GAME.asm_celesteela]
                G.GAME.asm_celesteela = G.GAME.asm_celesteela + 1
                return true
            end
        }))
        delay(0.6)
    end
}

SMODS.Consumable {
    key = 'guzzlord',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 },
    config = { extra = { destroy = 5, levels = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroy, card.ability.extra.levels } }
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )

        pseudoshuffle(temp_hand, 'asm_guzzlord')

        for i = 1, card.ability.extra.destroy do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        SMODS.destroy_cards(destroyed_cards)
        delay(0.5)
        local hand, played = "High Card", -1
        for k, t in pairs(G.GAME.hands) do
            if t.played > played then
                hand = k
                played = t.played
            end
        end
        SMODS.upgrade_poker_hands{ level_up = card.ability.extra.levels, hands = hand, from = card, }

        delay(0.3)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
}