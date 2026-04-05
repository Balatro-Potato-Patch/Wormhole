Wormhole.Riverboat = {}

-- Define the Cosmic rarity tier (Step above Legendary)
SMODS.Rarity({
    key = 'cosmic',
    loc_txt = { name = 'Cosmic' },
    badge_colour = HEX('011638'),
    default_weight = 0.005,
    pools = { ["Joker"] = true }
})

SMODS.Attribute {
    key = "unscored"
}

-- Global tracking for the entire run
SMODS.current_mod.calculate = function(self, context)
    if G.GAME and context.buying_card and not context.blueprint then
        -- Track Joker purchases for "The Future"
        if context.card and context.card.ability.set == 'Joker' then
            G.GAME.worm_jokers_bought = (G.GAME.worm_jokers_bought or 0) + 1
        end
    end
end

-- Helper to check if both cosmic jokers are held simultaneously
function get_pair_status()
    local past = SMODS.find_card('j_worm_the_past')
    local future = SMODS.find_card('j_worm_the_future')

    if #past > 0 and #future > 0 then
        return true, past[1]
    end
    return false
end

Wormhole.Riverboat.level_params_for_planet = function(planet)
    local hand_for_planet = planet.ability.hand_type
    local hand_info = G.GAME.hands[hand_for_planet]
    local hand_chips = hand_info.l_chips
    local hand_mult = hand_info.l_mult
    return hand_chips, hand_mult
end

Wormhole.Riverboat.get_planet_for_hand = function(hand)
    for _, v in pairs(G.P_CENTER_POOLS.Planet) do
        if v.config.hand_type == hand then return v.key end
    end
end

---Base game flip + unflip code.
---Delays after flipping not included
---@param cards table[]|Card[]
---@param direction "f2b"|"b2f"
Wormhole.Riverboat.flip_cards = function(cards, direction)
    for i = 1, #cards do
        local percent = 0
        local delta = (i - 0.999) / (#cards - 0.998) * 0.3
        if direction == "f2b" then
            percent = 1.15 - delta
        else
            percent = 0.85 + delta
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                cards[i]:flip()
                play_sound(direction == "f2b" and 'card1' or 'tarot2', percent, direction == "b2f" and 0.6 or 1)
                cards[i]:juice_up(0.3, 0.3)
                return true
            end
        }))
    end
end

Wormhole.Riverboat.upgrade_hands = function(hand_list, params, card)
    if type(hand_list) == "string" then hand_list = { hand_list } end
    local param_keys = {}
    for k, _ in pairs(params) do
        param_keys[#param_keys + 1] = k
    end
    SMODS.upgrade_poker_hands {
        hands = hand_list,
        parameters = param_keys,
        func = function(base, _, param, _)
            return base + params[param]
        end,
        from = card
    }
end
