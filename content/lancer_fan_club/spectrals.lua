-- Dark Matter
SMODS.Consumable {
    key = 'lfc_dark_matter',
    set = 'Spectral',
    atlas = "lfc_spectrals",
    pos = { x = 0, y = 0 },
    cost = 4,
    config = { extra = { destroy = { min = 1, max = 3 }, tags = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroy.min, card.ability.extra.destroy.max, card.ability.extra.tags } }
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}
        local amount = math.min(
            pseudorandom("lfc_dark_matter", card.ability.extra.destroy.min, card.ability.extra.destroy.max),
            #G.hand.cards)

        for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )

        pseudoshuffle(temp_hand, 'lfc_dark_matter')

        for i = 1, amount do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

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
        for i = 1, card.ability.extra.tags * amount do
            Wormhole.LFC_Util.create_random_tag("lfc_dark_matter")
        end
        delay(0.3)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 1
    end,
    set_sprites = function(self, card, front)
        local secret = pseudorandom("lfc_dark_matter_secret", 1, 5) <= 1
        if secret then
            --print("Oooh, secret!")
            card.children.center:set_sprite_pos({ x = 1, y = 0 })
        end
    end,
    ppu_artist = { "J8-Bit" },
    ppu_coder = { "J8-Bit" },
    ppu_team = { "Lancer Fan Club" },
}

-- Time Dilation
SMODS.Consumable {
    key = 'lfc_time_dilation',
    set = 'Spectral',
    atlas = "lfc_spectrals",
    pos = { x = 2, y = 0 },
    cost = 4,
    config = { extra = { ante_inc = -1, win_ante_inc = 1 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (card.ability.extra.ante_inc > 0 and "+" or "-") .. math.abs(card.ability.extra.ante_inc),
                (card.ability.extra.win_ante_inc > 0 and "+" or "-") .. math.abs(card.ability.extra.win_ante_inc),
            }
        }
    end,
    use = function(self, card, area, copier)
        -- Ante Stuff
        ease_ante(card.ability.extra.ante_inc)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.ante_inc
        G.GAME.win_ante = G.GAME.win_ante + card.ability.extra.win_ante_inc
        -- Joker banning
        local target = pseudorandom_element(G.jokers.cards, "lfc_time_dilation")
        if target ~= nil then
            local cards_to_destroy = {}
            for index, joker in ipairs(G.jokers.cards) do
                if joker.config.center.key == target.config.center.key then
                    table.insert(cards_to_destroy, joker)
                end
            end
            G.GAME.banned_keys[target.config.center_key] = true
            for index, joker in ipairs(cards_to_destroy) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        joker:juice_up(.4, .4)
                        joker:start_dissolve()
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.destroy_cards(joker, nil, nil, true)
                        return true
                    end
                }))
            end
        end
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
    end,
    ppu_artist = { "J8-Bit" },
    ppu_coder = { "J8-Bit" },
    ppu_team = { "Lancer Fan Club" },
}
