
local card_save = Card.save
function Card:save()
    local t = card_save(self)
    t.actually_permanent_debuff = self.actually_permanent_debuff
    return t
end

local card_load = Card.load
function Card:load(cardTable, other_card)
    self.actually_permanent_debuff = cardTable.actually_permanent_debuff
    card_load(self, cardTable, other_card)
end

SMODS.Consumable {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty" },
    ppu_coder = { "stupxd" },

    key = 'stew_solar_flare',
    set = 'Spectral',
    atlas = "stewconsumables",
    pos = { x = 1, y = 0 },
    use = function(self, card, area, copier)

        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))

        local poker_hands = {}
        local cards_in_hand = {}

        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) then
                poker_hands[#poker_hands + 1] = handname
            end
        end

        for _, playing_card in ipairs(G.hand.cards) do
            if playing_card:can_calculate() then
                cards_in_hand[#cards_in_hand + 1] = playing_card
            end
        end
        
        for _, card in ipairs(cards_in_hand) do
            local hand_type = pseudorandom_element(poker_hands, "worm_solar_flare")

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                card:juice_up(0.8, 0.5)
                card.actually_permanent_debuff = true
                return true
            end }))

            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
                handname = localize(hand_type, 'poker_hands'),
                chips = G.GAME.hands[hand_type].chips,
                mult = G.GAME.hands[hand_type].mult,
                level=G.GAME.hands[hand_type].level
            })
            level_up_hand(used_card, hand_type)
        end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})

    end,
    can_use = function(self, card)
        if not G.hand then
            return false
        end

        local has_poker_hands = false
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) then
                has_poker_hands = true
                break
            end
        end
        if not has_poker_hands then
            return false
        end
        
        local has_cards = false
        for _, playing_card in ipairs(G.hand.cards) do
            if playing_card:can_calculate() then
                has_cards = true
                break
            end
        end

        return has_cards
    end,
}
