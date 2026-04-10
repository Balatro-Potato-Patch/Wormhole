local shader = SMODS.Shader {
    key = 'dum_Celestial',
    path = 'Dummies/dum_Celestial.fs'
}

local sound = SMODS.Sound {
    key = 'dum_Celestial',
    path = 'Dummies/Celestial.ogg'
}

-- TODO: Do something else on playing cards? I kinda like how it encourages you to use planets during gameplay though

SMODS.Edition {
    key = 'dum_Celestial',
    shader = shader.key,
    ppu_coder = { 'bagels' },
    ppu_team = { 'dummies' },
    weight = 9,
    in_shop = true,
    extra_cost = 2,
    sound = { sound = sound.key, per = 0.8, vol = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { SMODS.get_probability_vars(card, 1, 2, 'dum_Celestial') } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.config.center.set == 'Planet' then
            if SMODS.pseudorandom_probability(card, 'dum_Celestial', 1, 2) then
                local visible_hands = {}
                for hand, _ in pairs(G.GAME.hands) do
                    if SMODS.is_poker_hand_visible(hand) then
                        visible_hands[#visible_hands + 1] = hand
                    end
                end
                local hand = pseudorandom_element(visible_hands, 'dum_Celestial')
                SMODS.smart_level_up_hand(card, hand)
            end
            return {}, {}
        end
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end
}
