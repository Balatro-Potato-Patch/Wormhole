SMODS.Joker{
key = "orrery",
atlas = "mrrp",
pos = {x = 4, y = 5},
    config = { extra = { tarots = 1 } },
unlocked = true, 
discovered = false, 
rarity = 2,
cost = 6,
calculate = function(self, card, context)
    if context.poker_hand_changed and context.old_level and context.new_level then
        if context.new_level > context.old_level then
            local orrery_cards = {"c_star", "c_moon", "c_sun", "c_world"}
            for i = 1, math.min(card.ability.extra.tarots, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound('timpani')
                            SMODS.add_card({ key = pseudorandom_element(orrery_cards, "orrery") })
                            card:juice_up(0.3, 0.5)
                        end
                        return true
                    end
                }))
            end
            delay(0.6)
        end
    end
end,
}