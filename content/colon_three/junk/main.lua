if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

Wormhole.COLON_THREE.C.JunkSet = HEX("ff5e25")

SMODS.ConsumableType {
    key = "JunkSet",
    primary_colour = Wormhole.COLON_THREE.C.JunkSet,
    secondary_colour = Wormhole.COLON_THREE.C.JunkSet,
    collection_rows = { 4, 4 },
    shop_rate = 0.0,
    default = "c_worm_asteroid_harvester"
}

SMODS.Enhancement {
    key = "junk_card",
    ppu_coder = "lordruby",
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = 1
            }
        end
    end
}

function Wormhole.COLON_THREE.junk_get_highlighted_cards(cards)
    local all_junk_selected = true
    local highlighted = {}
    for i, v in pairs(cards) do
        if v.highlighted then
            table.insert(highlighted, v) --t[#t+1] is marginally faster perf-wise, but this is cleaner
            if v.config.center.key ~= "m_worm_junk_card" then all_junk_selected = false end
        end
    end
    return highlighted, all_junk_selected
end

function Wormhole.COLON_THREE.flip_cards_events(cards, sound, sound_pitch, sound_direction)
    for i, card in ipairs(cards) do
        local percent = (sound_pitch or 1) + (i - 0.999) / (#cards - 0.998) * 0.3 * (sound_direction or 1)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.25,
            func = function()
                if sound then play_sound(sound, percent) end
                card:flip()
                return true
            end
        }))
    end
end

function Wormhole.COLON_THREE.junk_can_use(func)
    return function(self, card)
        local junk_num = card.ability.extra.junk_num or 1
        local cleanup_num = card.ability.extra.cleanup_num or 1
        local junk = 0
        for i, v in pairs(G.hand.highlighted) do
            if v.config.center.key == "m_worm_junk_card" then junk = junk + 1 end
        end
        local will_cleanup = #G.hand.highlighted == cleanup_num and junk == cleanup_num
        local will_convert = #G.hand.highlighted ~= 0 and #G.hand.highlighted <= junk_num and junk == 0
        return G.hand and #G.hand.highlighted ~= 0 and (not func or func(self, card)) and (will_convert or will_cleanup)
    end
end

local empty_function = function() end

function Wormhole.COLON_THREE.junk_use(config)
    --[[
    used config values:
        config.junk_func | Function | Called with parameters (self, card, cards) while playing cards are flipped. Called during junking
        config.clean_func | Function | Same as config.junk_func but called during cleaning.
        config.individual | Function |  Called with parameters (self, card, playing_card, clean_up) on each individual
            playing card while flipped. Only called if cleaning up.
    ]]

    config.junk_func = config.junk_func or empty_function
    config.clean_func = config.clean_func or empty_function
    config.individual = config.individual or empty_function
    -- Avoids checks later

    return function(self, card)
        local hand, clean_up = Wormhole.COLON_THREE.junk_get_highlighted_cards(G.hand.cards)
        Wormhole.COLON_THREE.flip_cards_events(hand, "card1", 1.15, -1)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.25,
            func = function()
                if clean_up then
                    config.clean_func(self, card, hand)
                else
                    config.junk_func(self, card, hand)
                end
                return true
            end
        }))
        for _, playing_card in ipairs(hand) do
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.25,
                func = function()
                    if clean_up then
                        config.individual(self, card, playing_card, clean_up)
                        playing_card:set_ability("c_base")
                    else
                        playing_card:set_ability("m_worm_junk_card")
                    end
                    return true
                end
            }))
        end
        Wormhole.COLON_THREE.flip_cards_events(hand, "tarot2", 0.85, 1)

        if clean_up then
            SMODS.calculate_context { worm_c3_cleanup = true, cards = hand }
        end
    end
end
