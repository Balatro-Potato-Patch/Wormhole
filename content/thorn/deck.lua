SMODS.Atlas {
    key = 'thorn_back',
    path = 'thorn/back.png',
    px = 71,
    py = 95
}

function thorn_renamelater_deck_played_this_ante(handname)
    if G.GAME and G.GAME.selected_back and G.GAME.selected_back.effect.center.key == 'b_worm_thorn_renamelater' 
    and G.GAME.hands[handname] and G.GAME.hands[handname].played_this_ante >= 1 then
        return true
    end
    return false
end

SMODS.Back{
    name = "Unnamed Deck", 
    key = "thorn_renamelater",
    
    pos = {
        x = 0,
        y = 0,
    },
    atlas = 'thorn_back',
    
    loc_vars = function(self, info_queue, center)
        return {vars = {}}
    end,
    
    config = {
        requirement = 3,
        current = 3,
    },
    
    loc_vars = function(self, info_queue, center)
        return {vars = {G.GAME.selected_back.effect.config.requirement or self.config.requirement, G.GAME.selected_back.effect.config.current or self.config.current}}
    end,
    
    apply = function(self, back)
        G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 1
    end,
    
    calculate = function(self, back, context)
        if context.end_of_round and context.main_eval then
            back.effect.config.current = back.effect.config.current - 1 
            if back.effect.config.current <= 0 then
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    play_sound('tarot1')
                    G.TAROT_INTERRUPT_PULSE = true
                    return true end }))
                update_hand_text({delay = 0}, {mult = '+', StatusText = true})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('tarot1')
                    return true end }))
                update_hand_text({delay = 0}, {chips = '+', StatusText = true})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('tarot1')
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true end }))
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
                delay(1.3)
                SMODS.upgrade_poker_hands({ instant = true })
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 }, { mult = 0, chips = 0, handname = '', level = '' })
                back.effect.config.current = back.effect.config.requirement
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.FILTER
                }
            else
                return {
                    message = ''..back.effect.config.current,
                    colour = G.C.FILTER
                }
            end
        elseif context.debuff_hand then
            if context.check then
                if G.GAME.hands[context.scoring_name].played_this_ante and G.GAME.hands[context.scoring_name].played_this_ante > 0 then
                    return {
                        debuff = true
                    }
                end
            elseif G.GAME.hands[context.scoring_name].played_this_ante and G.GAME.hands[context.scoring_name].played_this_ante > 1 then
                return {
                    debuff = true
                }
            end
        end
    end,
}
