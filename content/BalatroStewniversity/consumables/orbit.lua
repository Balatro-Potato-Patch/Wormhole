
SMODS.Consumable {

    ppu_team = { "Balatro Stewniversity" },
    ppu_artist = { "dottykitty" },
    ppu_coder = { "stupxd" },

    key = 'stew_orbit',
    set = 'Tarot',
    atlas = "stewconsumables",
    pos = { x = 0, y = 0 },
    config = { extra = { max = 30, per_level = 3 } },
    loc_vars = function(self, info_queue, card)
        local total_levels = 0 --copy pasted this code here so the preview of how much money youll get shows up
        for handname, values in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and values.level > 1 then
                total_levels = total_levels + values.level - 1
            end
        end
        return { vars = { card.ability.extra.per_level, card.ability.extra.max, math.max(0, math.min(total_levels * card.ability.extra.per_level, card.ability.extra.max)) } }
    end,
    use = function(self, card, area, copier)
        local total_levels = 0
        for handname, values in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and values.level > 1 then
                total_levels = total_levels + values.level - 1
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(math.max(0, math.min(total_levels * card.ability.extra.per_level, card.ability.extra.max)), true)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}
