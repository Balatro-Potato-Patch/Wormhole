SMODS.Atlas({
    key = "asm_ubs",
    path = "awesomeswagmoney/ubs.png",
    px = 89,
    py = 109,
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.Consumable {
    key = 'nihilego',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs',
    pos = {x = 2, y = 2},
    soul_pos = {x = 3, y = 2},
    display_size = {w = 89, h = 109},
    config = {extra_slots_used = 1, extra = {Xmult = 3, counter = 2}},

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
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
                return {Xmult = card.ability.extra.Xmult}
            end
        end

        if context.end_of_round and context.main_eval and card.ability.active then
            card.ability.extra.counter = card.ability.extra.counter - 1
            if card.ability.extra.counter == 0 then
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

        if context.hand_drawn then
            if card.ability.active then
                local any_forced = nil
                for _, playing_card in ipairs(G.hand.cards) do
                    if playing_card.ability.forced_selection then
                        any_forced = true
                    end
                end
                if not any_forced then
                    G.hand:unhighlight_all()
                    local forced_card = pseudorandom_element(G.hand.cards,
                                                             'nihilego')
                    forced_card.ability.forced_selection = true
                    G.hand:add_to_highlighted(forced_card)
                end
            end
        end
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Sound({key = "asm_buzz", path = 'awesomeswagmoney/buzz.ogg'})
SMODS.Consumable {
    key = 'buzzwole',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs',
    pos = {x = 0, y = 2},
    soul_pos = {x = 1, y = 2},
    display_size = {w = 89, h = 109},
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
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Consumable {
    key = 'pheromosa',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    display_size = {w = 89, h = 109},
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
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Consumable {
    key = "xurkitree",
    set = "worm_ultrabeast",
    atlas = 'worm_asm_ubs',
    pos = {x = 2, y = 1},
    soul_pos = {x = 3, y = 1},
    display_size = {w = 89, h = 109},
    config = {extra_slots_used = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {PRIMES[G.GAME.asm_xurkitree] or 17}}
    end,
    can_use = function(self, card) return true end,
    use = function(self, card, area, copier)
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
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_garb","worm_eris"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Consumable {
    key = "celesteela",
    set = "worm_ultrabeast",
    atlas = 'worm_asm_ubs',
    pos = {x = 0, y = 4},
    soul_pos = {x = 1, y = 4},
    display_size = {w = 89, h = 109},
    config = {extra_slots_used = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = {PRIMES[G.GAME.asm_celesteela] or 2}}
    end,
    can_use = function(self, card) return true end,
    use = function(self, card, area, copier)
        G.GAME.asm_celesteela = G.GAME.asm_celesteela or 1
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                G.hand:change_size(PRIMES[G.GAME.asm_celesteela])
                G.GAME.round_resets.temp_handsize =
                    (G.GAME.round_resets.temp_handsize or 0) +
                        PRIMES[G.GAME.asm_celesteela]
                G.GAME.asm_celesteela = G.GAME.asm_celesteela + 1
                return true
            end
        }))
        delay(0.6)
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_eris","worm_poker"},
    ppu_team = {"awesomeswagmoney"},
}

function conversionTarot(hand, newcenter)
    for i = 1, #hand do
        local percent = 1.15 - (i - 0.999) / (#hand - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                hand[i]:flip();
                play_sound('card1', percent);
                hand[i]:juice_up(0.3, 0.3);
                return true
            end
        }))
    end
    delay(0.2)

    -- Handle the conversion
    for i = 1, #hand do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                hand[i]:set_ability(G.P_CENTERS[newcenter])
                return true
            end
        }))
    end

    for i = 1, #hand do
        local percent = 0.85 + (i - 0.999) / (#hand - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                hand[i]:flip();
                play_sound('tarot2', percent, 0.6);
                hand[i]:juice_up(0.3, 0.3);
                return true
            end
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            G.hand:unhighlight_all();
            return true
        end
    }))
    delay(0.5)
end

SMODS.Consumable {
    key = "kartana",
    set = "worm_ultrabeast",
    atlas = 'worm_asm_ubs',
    pos = {x = 2, y = 5},
    soul_pos = {x = 3, y = 5},
    display_size = { w = 89, h = 109 },
    config = {extra_slots_used = 1, extra = {copies = 3, reduction = 2}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.copies - 1, card.ability.extra.reduction}
        }
    end,
    can_use = function(self, card) return #G.hand.highlighted == 1 end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                local _card = G.hand.highlighted[1]
                play_sound('slice1', 0.96 + math.random() * 0.08)
                for i = 1, card.ability.extra.copies do
                    local copy = copy_card(_card, nil, nil, G.playing_card)
                    copy:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copy)
                    G.hand:emplace(copy)
                    assert(
                        SMODS.modify_rank(copy, -card.ability.extra.reduction))
                end
                _card:juice_up(0.3, 0.5)
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.6)

    end,
    ppu_artist = {"worm_superb"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Consumable {
    key = 'guzzlord',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs',
    pos = {x = 0, y = 3},
    soul_pos = {x = 1, y = 3},
    display_size = { w = 89, h = 109 },
    config = {extra_slots_used = 1, extra = {destroy = 5, levels = 3}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.destroy, card.ability.extra.levels}}
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do
            temp_hand[#temp_hand + 1] = playing_card
        end
        table.sort(temp_hand, function(a, b)
            return not a.playing_card or not b.playing_card or a.playing_card <
                       b.playing_card
        end)

        pseudoshuffle(temp_hand, 'asm_guzzlord')

        for i = 1, card.ability.extra.destroy do
            destroyed_cards[#destroyed_cards + 1] = temp_hand[i]
        end

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
        SMODS.upgrade_poker_hands {
            level_up = card.ability.extra.levels,
            hands = hand,
            from = card
        }

        delay(0.3)
    end,
    can_use = function(self, card) return G.hand and #G.hand.cards > 0 end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_eris"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Consumable {
    key = 'poipole',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs',
    pos = {x = 0, y = 5},
    soul_pos = {x = 1, y = 5},
    display_size = { w = 89, h = 109 },
    config = {extra_slots_used = 1},
    loc_vars = function(self, info_queue, card)
        if not (card.edition and card.edition.holo) then
            info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        end
    end,
    use = function(self, card, area, copier)
        local eligible_card = pseudorandom_element(G.jokers.cards, 'popo')
        local playing = pseudorandom_element(G.hand.cards, 'popo')
        eligible_card:set_eternal(true)
        for i = 1, 4 do
            playing = pseudorandom_element(G.hand.cards, 'popo')
            playing:set_edition('e_holo', true)
        end
        play_sound('cancel', 0.3)
        check_for_unlock({type = 'have_edition'})
    end, -- that was easy
    can_use = function(self, card) return G.jokers and (#G.jokers.cards > 0) and G.hand and #G.hand.cards > 0 end,
    ppu_artist = {"worm_superb"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Consumable {
    key = 'naganadel',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs',
    pos = {x = 2, y = 4},
    soul_pos = {x = 3, y = 4},
    display_size = {w = 89, h = 109},
    config = {extra_slots_used = 1},
    loc_vars = function(self, info_queue, card)
        if not (card.edition and card.edition.polychrome) then
            info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        end
        if not (card.ability and card.ability.eternal) then
            info_queue[#info_queue+1] = { set = "Other", key = "eternal" }
        end
    end,
    use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers,
                                                                   true)
        local eligible_card = pseudorandom_element(editionless_jokers,
                                                   'naganada')
        eligible_card:set_edition('e_polychrome', true)
        eligible_card:set_eternal(true)
        play_sound('cancel', 0.3)
        check_for_unlock({type = 'have_edition'})
    end, -- that was easy
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Consumable {
    key = 'stakataka',
    set = 'worm_ultrabeast',
    atlas = 'worm_asm_ubs',
    pos = {x = 0, y = 6},
    soul_pos = {x = 1, y = 6},
    display_size = {w = 89, h = 109},
    config = {extra_slots_used = 1, max_highlighted = 3, mod_conv = 'm_stone'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        if not (card.edition and card.edition.polychrome) then
            info_queue[#info_queue + 1] = G.P_CENTERS['e_polychrome']
        end
        return {
            vars = {
                card.ability.max_highlighted,
                localize {
                    type = 'name_text',
                    set = 'Enhanced',
                    key = card.ability.mod_conv
                }
            }
        }
    end,

    use = function(self, card)
        for k, v in pairs(G.hand.highlighted) do
            v:set_edition('e_polychrome')
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        conversionTarot(G.hand.highlighted, card.ability.mod_conv)
        delay(0.6)

        return true
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Sound({key = "asm_clownhonk", path = 'awesomeswagmoney/clownhonk.ogg'})
SMODS.Sound({key = "asm_boom", path = 'awesomeswagmoney/explosion.ogg'})

SMODS.Consumable {
    key = "blacephalon",
    set = "worm_ultrabeast",
    atlas = 'worm_asm_ubs',
    pos = {x = 0, y = 1},
    soul_pos = {x = 1, y = 1},
    display_size = { w = 89, h = 109 },
    config = {extra_slots_used = 1},
    loc_vars = function(self, info_queue, card)
        if not (card.edition and card.edition.polychrome) then
            info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        end
    end,
    can_use = function(self, card) return G.hand and #G.hand.cards > 0 end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('worm_asm_boom', 0.96 + math.random() * 0.08, 0.3)
                local _card = pseudorandom_element(G.hand.cards,
                                                   pseudoseed('clown'))
                _card:set_edition('e_polychrome')
                for k, v in ipairs(G.hand.cards) do
                    if v ~= _card then
                        v:juice_up(5, 0.5)
                        delay(0.5 / #G.hand.cards)
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
                for i = 1, G.hand.config.card_limit - 1 do
                    draw_card(G.deck, G.hand, 90, 'up', true)
                end
                return true
            end
        }))

        delay(0.6)

    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Consumable{
    key = "ultramegaopolis",
    set = "Spectral",
    atlas = "worm_asm_ubs",
    pos = { x = 2, y = 6 },
    display_size = { w = 89, h = 109 },
    hidden = true,
    soul_set = "worm_ultrabeast",
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = "worm_necrozma_r", key = "j_worm_necrozma" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_eris"},
    ppu_team = {"awesomeswagmoney"},
}

SMODS.Rarity{
    key = "necrozma_r",
    badge_colour = HEX("000000"),
}
SMODS.Joker {
    key = 'necrozma',
    atlas = 'worm_asm_ubs',
    rarity = "worm_necrozma_r",
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 2, y = 3},
    soul_pos = {x = 3, y = 3},
    display_size = {w = 89, h = 109},
    config = {extra = {tag = "tag_worm_ub"}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize {
                    type = 'name_text',
                    set = 'Tag',
                    key = card.ability.extra.tag
                }
            }
        }
    end,
    set_ability = function(self, card)
        card:set_edition('e_negative', true, true)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss then
            add_tag(Tag(card.ability.extra.tag))
            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
            return {
                card = card,
                message = localize("k_asm_necrozmaspawn"),
                colour = G.C.DARK_EDITION
            }
        end
    end,
    ppu_artist = {"worm_omega"},
    ppu_coder = {"worm_garb"},
    ppu_team = {"awesomeswagmoney"},
}
