SMODS.Atlas {
    key = "joker",
    px = 71,
    py = 95,
    path = "Hedonia/jokers.png"
}

SMODS.Joker {
    key = "hedonia_casino",
    atlas = "joker",
    pos = {x = 0, y = 0},
    rarity = 3,
    cost = 6,
    blueprint_compat = false,
    pools = {
        Bartender = true
    },
    config = { extra = {
        items = 1
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.items}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card.lucky_trigger and #G.consumeables.cards < G.consumeables.config.card_limit then --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/jokers.lua#L2586 and https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/jokers.lua#L4472
            SMODS.add_card({set = "worm_hedonia_menu", area = G.consumeables, key_append = '_casino'}) --https://github.com/Trif3ctal/Lucky-Rabbit/blob/82b67214f7865d37953771fe58e80ba6cd7aee25/content/jokers/sad_clown.lua#L36
        end
    end
}

SMODS.Joker {
    key = "hedonia_trash",
    atlas = "joker",
    pos = {x = 0, y = 1},
    rarity = 3,
    cost = 6,
    blueprint_compat = false,
    config = { extra = {
        copied = {}
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.copied}}
    end,
    calculate = function(self, card, context) --used a lot of pinkprint for this https://github.com/EremelMods/Ortalab/blob/main/objects/jokers/pinkprint.lua
        if context.joker_type_destroyed or context.selling_card then
            if context.card.ability.set == 'Joker' then
                card.ability.extra.copied[#card.ability.extra.copied+1] = context.card.ability
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
        --when end of round
            --empty list
    end
}
