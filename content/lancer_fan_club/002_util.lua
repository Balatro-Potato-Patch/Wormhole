Wormhole.LFC_Util = {}

Wormhole.LFC_Util.debug_print = function(str)
    if print and G.GAME.lfc_debug then print(str) end
end
Wormhole.LFC_Util.total_keys = function(table)
    local length = 0
    for _, __ in pairs(table) do
        length = length + 1
    end
    return length
end

-- Copied from slimeutils :)
Wormhole.LFC_Util.card_obscured = function(card)
    return not card.config.center.discovered and (card.ability.consumeable or card.config.center.unlocked) and
        not card.bypass_discovery_center
end

-- Copied from one of J8's mods
Wormhole.LFC_Util.create_random_tag = function(rng_key)
    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            --- Credits to Eremel
            local tag_pool = get_current_pool('Tag')
            local selected_tag = pseudorandom_element(tag_pool, rng_key)
            local it = 1
            while selected_tag == 'UNAVAILABLE' do
                it = it + 1
                selected_tag = pseudorandom_element(tag_pool, rng_key .. it)
            end
            local tag = Tag(selected_tag)
            if tag.name == "Orbital Tag" then
                local _poker_hands = {}
                for k, v in pairs(G.GAME.hands) do
                    if v.visible then
                        _poker_hands[#_poker_hands + 1] = k
                    end
                end
                tag.ability.orbital_hand = pseudorandom_element(_poker_hands,
                    rng_key .. "_orbital_tag")
            end
            tag:set_ability()
            add_tag(tag)
            return true
        end
    }))
end
