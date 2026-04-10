-- Set all Jokers to properly discovered, removable with ease if at the end of testing we decide we don't want them to be discovered
Wormhole.SHRUG_Joker = SMODS.Joker:extend{
    discovered = true
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
    pos = { x = 0, y = 0 },
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
                        trigger = "after",
                        delay = 0.4,
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