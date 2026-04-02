-- Set all Jokers to properly discovered, removable with ease if at the end of testing we decide we don't want them to be discovered
Wormhole.SHRUG_Joker = SMODS.Joker:extend{
    discovered = true
}

---SPACEWALK---
---------------
---SPACEWALK---

SMODS.Atlas {
    key = "spacewalk",
    px = 71,
    py = 95,
    path = "TeamShrug/j_spacewalk.png"
}

Wormhole.SHRUG_Joker {
    key = "shrug_spacewalk",
    atlas = "spacewalk",
    rarity = 2,
    cost = 6,
    config = { extra = { used = false } },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    --
    -- Calculations
    calculate = function(self, card, context)
        if not context.blueprint then

            -- Disable when a planet card is used
            if context.using_consumeable and context.consumeable.ability.set == "Planet" then
                card.ability.extra.used = true
            end
            --
            -- Create Meteor Tag at end of round
            if context.end_of_round and context.main_eval then

                -- Create tag
                if not card.ability.extra.used then
                    -- NOTE - Add animation here, I don't know how to do that - Microwave
                    add_tag(Tag("tag_meteor"))
                end

                -- Reset Used Variable
                card.ability.extra.used = false
            end

        end
    end,
}
