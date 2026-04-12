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
        --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/jokers.lua#L2586
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_lucky') then
            -- add drunk if lucky card not drunk
            local edition = SMODS.poll_edition({guaranteed = true, options = {{name = "e_worm_hedonia_drunk", weight = 1}}})
            if not context.other_card.edition or (context.other_card.edition and not context.other_card.edition == edition) then
                context.other_card:set_edition(edition, true, true)
            end
            -- spawn menu item if lucky card triggered
            --https://github.com/nh6574/VanillaRemade/blob/369e7c28f3cf9a0c6976f84bacaf4a17cfe7c3aa/src/jokers.lua#L608
            if context.other_card.lucky_trigger and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({set = "worm_hedonia_menu", area = G.consumeables, key_append = '_casino'})
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            end
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
    end,
    add_to_deck = function()
        G.jokers:change_size(-1)
    end,
    remove_from_deck = function()
        G.jokers:change_size(1)
    end
}
