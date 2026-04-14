SMODS.Joker {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "tuzzo" },
    ppu_coder = { "stupxd" },

    key = 'stew_astrologer',
    rarity = "Common",
    cost = 4,
    atlas = 'stewjokers',
    pos = {x=0, y=3},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function (self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Tarot'
            and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            
            -- Fuckass vanilla consumables 
            local actual_consumable_buffer = G.GAME.consumeable_buffer
            if context.consumeable.ability.name == 'The Fool' and G.GAME.last_tarot_planet ~= 'c_fool' then
                actual_consumable_buffer = actual_consumable_buffer + 1
            end
            if context.consumeable.ability.name == 'The Emperor' or context.consumeable.ability.name == 'The High Priestess' then
                actual_consumable_buffer = actual_consumable_buffer + 2
            end
            if #G.consumeables.cards + actual_consumable_buffer >= G.consumeables.config.card_limit then
                return
            end

            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    SMODS.add_card {
                        set = 'Planet',
                        key_append = 'astrologer'
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            return {
                message = localize('k_plus_planet'),
                colour = G.C.SECONDARY_SET.Planet,
            }
        end
    end
}