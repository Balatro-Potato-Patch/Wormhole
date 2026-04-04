SMODS.Consumable {
    key = "omnipotence",
    set = "Spectral",
    atlas = 'omnipotence',
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    hidden = true,
    soul_set = 'Spectral',
    soul_rate = 0.003,
    can_repeat_soul = true,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = 'worm_otherworldly' })
                card:juice_up(0.3, 0.5)
                if G.GAME.dollars ~= 0 then
                    ease_dollars(-G.GAME.dollars, true)
                end
                return true
            end
        }))
        local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                    destructable_jokers[#destructable_jokers + 1] =
                        G.jokers.cards[i]
                end
            end
            local joker_to_destroy = pseudorandom_element(destructable_jokers, 'worm_omnipotence')

            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
            end
        delay(0.6)
    end,
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
    end
}