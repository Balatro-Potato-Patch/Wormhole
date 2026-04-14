SMODS.Sticker{
    ppu_team = {'Mrrp Mew Meow :3'},
    ppu_artist = {'Shinku'},
    ppu_coder = {'Shinku','Cyan','Minty'},
    key = "mrrp_meteoric",
    atlas = "mrrp",
    pos = {x = 1, y = 0},
    badge_colour = HEX('487C90'),
    sets = {
        Joker = true
    },
    rate = 0.3,
    calculate = function(self, card, context)
        if context.buying_card and context.buying_self then
            G.CONTROLLER.locks[card.ID] = true
            -- All of this is from VanillaRemade's Black Hole card by nh6574
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
            update_hand_text({ delay = 0 }, { mult = '-', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '-', StatusText = true })
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
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '÷2' })
            delay(1.3)
            -- end of referenced code
            G.CONTROLLER.locks[card.ID] = false
            for k, v in pairs(G.GAME.hands) do
                local reduction = -math.floor(v.level/2)
                if reduction ~= 0 then
                    SMODS.upgrade_poker_hands({
                        hands = k,
                        level_up = reduction,
                        from = card,
                        instant = true,
                    })
                end
            end
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                { mult = 0, chips = 0, handname = '', level = '' })
        end
    end,
}