-- Set all Jokers to properly discovered, removable with ease if at the end of testing we decide we don't want them to be discovered
Wormhole.SHRUG_Joker = SMODS.Joker:extend{
}


-- Atlas
SMODS.Atlas {
    key = "shrug_jokers",
    px = 71,
    py = 95,
    path = "TeamShrug/jokers.png"
}



---SPACEWALK---
---------------
---SPACEWALK---

Wormhole.SHRUG_Joker {
    key = "shrug_spacewalk",
    atlas = "shrug_jokers",
    pos = { x = 5, y = 0 },
    rarity = 2,
    cost = 6,
    config = { extra = { used = false } },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    -- Return tag type
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_meteor
    end,

    -- Calculations
    calculate = function(self, card, context)
        if not context.blueprint then
            
            -- Disable when a planet card is used
            if context.using_consumeable and context.consumeable.ability.set == "Planet" then
                card.ability.extra.used = true
            end

            -- Create Meteor Tag at end of round
            if context.end_of_round and context.main_eval then
                
                -- Create tag
                if not card.ability.extra.used then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_shrug_plus_meteor'), colour = G.C.SECONDARY_SET.Planet})
                    -- RandomsongV2: G.C.SET.Planet shows black for some reason? its supposed to be planet cards colour
                    -- Microwave: G.C.SECONDARY_SET.Planet is the one that's blue.
                    add_tag(Tag("tag_meteor"))
                end
                
                -- Reset Used Variable
                card.ability.extra.used = false
            end

        end
    end,

    

    -- Credits
    ppu_coder = {
        "microwave",
        "randomsongv2"
    },
    ppu_artist = {
        "microwave",
    },
    ppu_team = { "shrug" }
}



---OKAY WITH IT---
------------------
---OKAY WITH IT---

Wormhole.SHRUG_Joker {
    key = "shrug_okay_with_it",
    atlas = "shrug_jokers",
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 5,
    config = { extra = { card_table = {} } },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    -- Return Enhancement Type
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS["m_worm_shrug_nebulous"]
    end,

    -- Check if a card is in scoring hand
    is_scored = function(played, context)
        for _, check in pairs(context.scoring_hand) do
            if check == played then
                return true
            end
        end
        return false
    end,

    -- Calculations
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before then

                -- Reset card table
                card.ability.extra.card_table = {}
                local trigger_effect = false

                -- Add all unscored cards to a table
                for _, played in pairs(context.full_hand) do
                    if not card.config.center.is_scored(played, context) and not SMODS.has_enhancement(played, "m_worm_shrug_nebulous") then
                        card.ability.extra.card_table[#card.ability.extra.card_table + 1] = played
                        trigger_effect = true
                    end
                end

                -- Ensure there is a card to choose
                if trigger_effect then

                    -- Find card to be given enhancement
                    local eff_card = pseudorandom_element(card.ability.extra.card_table, "j_worm_shrug_okay_with_it")

                    -- Card Flip Effect
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("tarot1")
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                    delay(0.2)
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            eff_card:flip()
                            play_sound("card1")
                            eff_card:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                    delay(0.2)
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            eff_card:set_ability("m_worm_shrug_nebulous")
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            eff_card:flip()
                            play_sound("tarot2")
                            eff_card:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                    delay(1)
                end
            end
        end
    end,

    -- Credits
    ppu_coder = {
        "microwave",
    },
    ppu_artist = {
        "edwardrobinson",
    },
    ppu_team = { "shrug" }
}



---BINARY SUNSET---
-------------------
---BINARY SUNSET---

Wormhole.SHRUG_Joker {
    key = "shrug_binary_sunset",
    atlas = "shrug_jokers",
    pos = { x = 2, y = 0 },
    rarity = 2,
    cost = 5,
    config = { extra = { once = false } },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    -- Calculations
    calculate = function(self, card, context)
        if context.after and context.scoring_name == "Two Pair" then
            if card.ability.extra.once and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                
                -- Establish extra card space and reset card ability
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                if not context.blueprint then card.ability.extra.once = false end

                -- Event
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{
                            set = "shrug_alien"
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end,
                }))

                -- Return message
                return {
                    message = "+1 Alien",
                    colour = G.C.SET.shrug_alien
                }

            elseif not card.ability.extra.once then
                
                -- First of 2 hands played
                if not context.blueprint then card.ability.extra.once = true end
                return {
                    message = "1/2",
                    colour = G.C.SET.shrug_alien
                }
            end
        elseif context.after and card.ability.extra.once then
            
            -- Reset for wrong hand played
            if not context.blueprint then card.ability.extra.once = false end
            return {
                message = "Reset!",
                colour = G.C.SET.shrug_alien
            }
        end
    end,

    -- Credits
    ppu_coder = {
        "microwave",
    },
    ppu_artist = {
        "edwardrobinson",
    },
    ppu_team = { "shrug" }
}



---DARK MATTER---
-----------------
---DARK MATTER---

Wormhole.SHRUG_Joker {
    key = "shrug_dark_matter",
    atlas = "shrug_jokers",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 4, y = 0 },
    rarity = 3,
    cost = 7,
    config = { extra = { scale = 0.1 } },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    -- Check if a card is in the current tallied suits
    check_suit = function(playing_card, suits_used)
        
        -- Iterate through the suit types
        for i, suit_type in pairs(suits_used) do
            if suit_type == playing_card.base.suit then
                return {
                    new_suit = false,
                    pos = i
                }
            end
        end

        -- New suit type
        return {
            new_suit = true,
            pos = #suits_used + 1
        }

    end,

    -- Get Xmult amount
    find_mult = function(card)
        if G.playing_cards then
            
            -- Set up suit tallies
            local suits_used = { }
            local suit_tally = { }

            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(playing_card) then

                    -- Establish proper suit position
                    local suit_pos = card.config.center.check_suit(playing_card, suits_used)

                    -- Add a new suit to the counter
                    if suit_pos.new_suit then
                        suits_used[suit_pos.pos] = playing_card.base.suit
                        suit_tally[suit_pos.pos] = 0
                    end

                    -- Tick up tally
                    suit_tally[suit_pos.pos] = suit_tally[suit_pos.pos] + 1
                
                end
            end

            -- Set up first and second highest suit types
            local high_type = 0
            local low_type = 0

            -- Iterate through suits
            for _, amount in pairs(suit_tally) do
                if amount > high_type then
                    low_type = high_type
                    high_type = amount
                elseif amount > low_type then
                    low_type = amount
                end
            end

            -- Establish final value
            local xmult_return = (high_type - low_type) * card.ability.extra.scale

            -- Return final value
            return 1 + xmult_return

        else

            -- Return 1
            return 1

        end
        
    end,

    -- Return Xmult amount
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.scale, card.config.center.find_mult(card) } }
    end,

    -- Calculations
    calculate = function(self, card, context)
        if context.joker_main then
            local xmult_return = card.config.center.find_mult(card)
            return {
                xmult = xmult_return
            }
        end
    end,

    -- Credits
    ppu_coder = {
        "microwave",
    },
    ppu_artist = {
        "microwave",
    },
    ppu_team = { "shrug" }
}
