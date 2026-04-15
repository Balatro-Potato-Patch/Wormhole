SMODS.Joker {
    key = "alienx",
    cost = 20,
    rarity = 4,
    atlas = 'VVjokers',
    pos = {x = 1, y = 0},
    soul_pos = {x = 2, y = 0},
    config = {
        extra = {
            alienx = 1,
            denom = 4
        }
    },
    ppu_team = { "Violent Violets" },
    ppu_artist = { "FirstTry" },
    ppu_coder = { "FirstTry" },
    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_black_hole
        local oddwin, oddnope = SMODS.get_probability_vars(card, 1, card.ability.extra.denom, self.key)
        return {
            vars = {
                oddwin, oddnope
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" and not context.blueprint then
            if SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.denom) then
                    update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
        delay(1.3)
        SMODS.upgrade_poker_hands({ instant = true })
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
    else
        return { message = localize("k_nope_ex")}
    end
    end
end
}