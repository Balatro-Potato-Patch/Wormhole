-- Define the Cosmic rarity tier (Step above Legendary)
SMODS.Rarity({
    key = 'cosmic',
    loc_txt = { name = 'Cosmic' },
    badge_colour = HEX('011638'), 
    default_weight = 0.005,
    pools = {["Joker"] = true}
})

-- Global tracking for the entire run
SMODS.current_mod.calculate = function(self, context)
    if G.GAME and context.buying_card and not context.blueprint then
        -- Track Joker purchases for "The Future"
        if context.card and context.card.ability.set == 'Joker' then
            G.GAME.wh_jokers_bought = (G.GAME.wh_jokers_bought or 0) + 1
        end
    end
end

-- Helper to check if both cosmic jokers are held simultaneously
function get_pair_status()
    local past = SMODS.find_card('j_wh_the_past')
    local future = SMODS.find_card('j_wh_the_future')
    
    if #past > 0 and #future > 0 then
        return true, past[1]
    end
    return false
end
