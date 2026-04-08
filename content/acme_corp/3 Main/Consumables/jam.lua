SMODS.Consumable{
    key = 'acme_jam',
    set = 'ACME_Gadget',
    atlas = 'ACME_gadgets',
    pos = {x=2, y=0},
    soul_pos = {x=2, y=1},
    ppu_artist = {'RadiationV2'},
    ppu_coder = {'Opal'},
    config = {extra = {hands = {}, effects_triggered = 0, effects_required = 5}},
    loc_vars = function(self, info_queue, card)
        local _amt = card.ability.extra.effects_required - card.ability.extra.effects_triggered
        if card.ability.extra.effects_triggered < card.ability.extra.effects_required then
            if _amt == 1 then
                return{ vars = {_amt, localize('k_card')}}
            else
                return{ vars = {_amt, localize('k_cards')}}
            end
        else
            return{key = self.key..'_alt'}
        end
    end,
    use = function(self, card)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {handname = localize('k_all_hands'), chips = '...', mult = '...', level = ''})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            return true end }))
        update_hand_text({delay = 0}, {chips = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level = '+1'})
        SMODS.upgrade_poker_hands{instant = true}
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {handname = '', mult = 0, chips = 0, level = ''})
    end,
    can_use = function(self, card)
        return card.ability.extra.effects_triggered >= card.ability.extra.effects_required
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand and context.full_hand then
            if next(context.card_effects[1]) or (#context.card_effects > 1) then
                card.ability.extra.effects_triggered = card.ability.extra.effects_triggered + 1
                if card.ability.extra.effects_triggered >= card.ability.extra.effects_required then
                    card_eval_status_text(card, 'extra', nil, 1, nil, {
                        message = localize('k_active_ex'),
                        colour = G.C.RED
                    })
                    return {
                        repetitions = 0,
                    }
                else
                    card_eval_status_text(card, 'extra', nil, 1, nil, {
                        message = localize{type = 'variable', key = 'a_remaining', vars = {card.ability.extra.effects_required - card.ability.extra.effects_triggered}},
                        colour = G.C.ORANGE
                    })
                    return {
                        repetitions = 0,
                    }
                end
            end
        end
    end,
}