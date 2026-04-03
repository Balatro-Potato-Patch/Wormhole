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
    loc_vars = function(self, info_queue, center)
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
}