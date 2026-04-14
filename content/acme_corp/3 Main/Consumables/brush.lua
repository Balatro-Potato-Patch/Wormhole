SMODS.Consumable{
    key = 'acme_brush',
    set = 'ACME_Gadget',
    atlas = 'ACME_gadgets',
    pos = {x=6, y=0},
    soul_pos = {x=6, y=1},
    ppu_coder = {'Opal'},
    ppu_artist = {'RadiationV2'},
	config = {extra = {active = false, odds = 2, suits_required = 4}},
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'acme_brush')
        return{ vars = {n, d, card.ability.extra.suits_required}, key = card.ability.extra.active and self.key..'_alt' or nil}
    end,
    use = function(self, card, area, copier)
        local new_suit = SMODS.Suits[G.hand.highlighted[1].base.suit].card_key
        local _cards = G.hand.cards
        for i = 1, #_cards do
            _cards[i].ability.acme_temp_brush = SMODS.pseudorandom_probability(card, 'acme_brush', 1, card.ability.extra.odds)
            if _cards[i] ~= G.hand.highlighted[1] and _cards[i].ability.acme_temp_brush then
                local percent = 1.15 - (i - 0.999) / (#_cards - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        _cards[i]:flip()
                        play_sound('card1', percent)
                    return true end
                }))
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.8,
            func = function()
                for i = 1, #_cards do
                    if _cards[i] ~= G.hand.highlighted[1] and _cards[i].ability.acme_temp_brush then
                    local new_val = SMODS.Ranks[_cards[i].base.value].card_key
                    local new_card = G.P_CARDS[new_suit..'_'..new_val]
                    _cards[i]:set_base(new_card)
                    G.GAME.blind:debuff_card(_cards[i])
                    _cards[i]:juice_up(0.3, 0.3)
                    end
                end
            return true end
        }))
        for i = 1, #_cards do
            if _cards[i] ~= G.hand.highlighted[1] and _cards[i].ability.acme_temp_brush then
            local percent = 0.85 + (i - 0.999) / (#_cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    _cards[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    _cards[i]:juice_up(0.3, 0.3)
                    _cards[i].ability.acme_temp_brush = nil
                return true end
            }))
            end
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local _suits = {}
            for k, v in ipairs(context.scoring_hand) do
                _suits[v.base.suit] = true
            end
            local suit_num = 0
            for k, v in pairs(_suits) do
                suit_num = suit_num + 1
            end
            if suit_num >= card.ability.extra.suits_required then
                card.ability.extra.active = true
                return {
                    message = localize('k_active_ex'),
                    colour = G.C.RED
                }
            end
        end
    end,
    can_use = function(self, card)
        return card.ability.extra.active and G.hand and #G.hand.highlighted == 1
    end,
}