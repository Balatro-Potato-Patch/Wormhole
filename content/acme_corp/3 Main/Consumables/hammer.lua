SMODS.Consumable{
    key = 'acme_hammer',
    set = 'ACME_Gadget',
    atlas = 'ACME_gadgets',
    pos = {x=3, y=0},
    soul_pos = {x=3, y=1},
    ppu_artist = {'RadiationV2'},
    ppu_coder = {'Opal'},
    config = {extra = {cards = 5, active = false}},
    loc_vars = function(self, info_queue, card)
        if not card.ability.extra.active then
            info_queue[#info_queue+1] = G.P_CENTERS.c_strength
        end
        return{vars = {card.ability.extra.cards}, key = card.ability.extra.active and self.key..'_alt' or nil}
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.config.center.key == 'c_strength' then
            card.ability.extra.active = true
            return{
                message = localize('k_active_ex'),
                colour = G.C.RED
            }
        end
    end,
    can_use = function(self, card) return (card.ability.extra.active and #G.hand.highlighted == 5) end,
    use = function(self, card, area, copier)
        local lowest_card = nil
        for k, v in ipairs(G.hand.highlighted) do
            if not lowest_card then
                lowest_card = v
            elseif v:get_id() < lowest_card:get_id() then
                lowest_card = v
            end
        end
        local new_val = SMODS.Ranks[lowest_card.base.value].card_key
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                return true end
            }))
        end
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.8,
                func = function()
                    for i = 1, #G.hand.highlighted do
                        local new_suit = SMODS.Suits[G.hand.highlighted[i].base.suit].card_key
                        local new_card = G.P_CARDS[new_suit..'_'..new_val]
                        G.hand.highlighted[i]:set_base(new_card)
                        G.GAME.blind:debuff_card(G.hand.highlighted[i])
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    end
                    play_sound('cancel', 0.7, 1.5)
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                return true end
            }))
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                return true end
            }))
        end
    end,
}