if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Joker {
    key = "laika",
    --atlas = "ct_jokers",
    --pos = { x = 0, y = 0 },
    config = { extra = { levels = 0 } },
    rarity = 2,
    attributes = { "space" },
    --ppu_artist = {},
    ppu_coder = { "meta" },
    ppu_team = { ":3" },

    calculate = function(self, card, context)
        if context.before then
            for i, v in ipairs(G.jokers.cards) do
                for ii, vv in ipairs(SMODS.Attributes.space.keys) do
                    if vv == v.config.center.key then
                        card.ability.extra.levels = card.ability.extra.levels + 1
                        G.E_MANAGER:add_event(Event {
                            trigger = "after",
                            delay = 0.1,
                            func = function()
                                v:juice_up()
                                return true
                            end
                        })
                        break
                    end
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
