-- PLACEHOLDER ART ATLAS
SMODS.Atlas {
    key = "placeholder",
    px = 71,
    py = 95,
    path = "Hedonia/sungwon.png"
}

SMODS.Joker {
    key = "hedonia_trash",
    atlas = "placeholder",
    pos = {x = 0, y = 0},
    rarity = 3,
    cost = 6,
    blueprint_compat = false,
    config = { extra = {
        copied = {}
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.copied}}
    end,
    calculate = function(self, card, context)
        if context.joker_type_destroyed or context.selling_card then
            if context.card.ability_UIBox_table.card_type == 'Joker' then
                card.ability.extra.copied[#card.ability.extra.copied+1] = context.card
            end
        end
        if context.joker_main then
            for i = 1, #card.ability.extra.copied do
                SMODS.blueprint_effect(card, card.ability.extra.copied[i], context)
            end
        end
        --when scoring
            --for each item in list
                --trigger blueprint func
            --empty list
    end
}