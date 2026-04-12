
local card_can_calculate = Card.can_calculate
function Card:can_calculate(ignore_debuff, ignore_sliced)
    if self.solar_flare_debuff then
        self.debuff = true
        return false
    else
        return card_can_calculate(self, ignore_debuff, ignore_sliced)
    end
end

SMODS.Consumable {
    key = 'solar_flare',
    set = 'Spectral',
    atlas = "stewconsumables",
    pos = { x = 1, y = 0 },
    -- config = { extra = { destroy = 5, dollars = 20 } },
    -- loc_vars = function(self, info_queue, card)
    --     return { vars = { card.ability.extra.destroy, card.ability.extra.dollars } }
    -- end,
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
                card.debuff = true
                card.solar_flare_debuff = true
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
