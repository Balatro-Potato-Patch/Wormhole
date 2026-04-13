if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

local function has_attribute (card, key)
    local card_key = card
    if Object.is(card, Card) then card_key = card.config.center.key end
    local pool = SMODS.get_attribute_pool(key)
    for _, c in pairs(pool) do
        if c == card_key then return true end
    end
    return false
end

SMODS.Joker {
    key = "ct_laika",
    atlas = "ct_jokers",
    pos = { x = 6, y = 0 },
    config = { extra = { levels = 0 } },
    rarity = 2,
    cost = 8,
    attributes = { "space", "hand_type" },
    ppu_artist = { "lordruby" },
    ppu_coder = { "meta" },
    ppu_team = { ":3" },

    calculate = function(self, card, context)
        if context.before then
            for i, v in ipairs(G.jokers.cards) do
                if has_attribute(v, "space") then
                    card.ability.extra.levels = card.ability.extra.levels + 1
                    G.E_MANAGER:add_event(Event {
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            v:juice_up()
                            return true
                        end
                    })
                end
            end
            return {
                level_up = card.ability.extra.levels
            }
        end

        if context.after then
            if card.ability.extra.levels > 0 then
                local level_down = -card.ability.extra.levels
                card.ability.extra.levels = 0
                return {
                    level_up = level_down
                }
            end
        end
    end
}
