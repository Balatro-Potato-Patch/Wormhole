if not to_big then to_big = function(val) return val end end

SMODS.Atlas {
  key = "dum_pulsar",
  path = "Dummies/pulsar.png",
  px = 71,
  py = 95
}

SMODS.Consumable {
    set = "Spectral",
    key = "dum_pulsar",
    pos = { x = 0, y = 0 },
    atlas = "dum_pulsar",
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local hand = G.GAME.current_round.most_played_poker_hand
        if G.GAME.hands[hand].level > to_big(1) then
            level_up_hand(card, hand, false, 1 - G.GAME.hands[hand].level)
        end
        delay(0.8)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8}, { chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult, handname = localize(hand, 'poker_hands'), level = 1 })
        G.E_MANAGER:add_event(Event({
            no_delete = true,
            func = (function()
                G.GAME.hands[hand].level = 1
                ease_colour(G.C.UI_CHIPS, G.C.SECONDARY_SET.Planet)
                ease_colour(G.C.UI_MULT, G.C.SECONDARY_SET.Planet)
                return true
            end)
        }))
        G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips * 2
        G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult * 2
        delay(0.8)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].l_mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].l_chips, StatusText = true})
        delay(2)
        G.E_MANAGER:add_event(Event({
            no_delete = true,
            func = (function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE)
                ease_colour(G.C.UI_MULT, G.C.RED)
                return true
            end)
        }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0.8}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
    
    soul_set = 'Planet',

    ppu_team = { "dummies" },
    ppu_coder = { "baltdev" },
    ppu_artist = { "vissa" },
}
