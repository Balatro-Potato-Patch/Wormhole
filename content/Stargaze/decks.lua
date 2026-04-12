local COSMOS_POOLS = {
    Tarot = {},
    Spectral = {}
}

local COSMOS_INITIALIZED = false

local function init_cosmos_pools()
    if COSMOS_INITIALIZED then return end

    for k, v in pairs(G.P_CENTERS) do
        if v.set == "Tarot" then
            table.insert(COSMOS_POOLS.Tarot, k)
        elseif v.set == "Spectral" then
            table.insert(COSMOS_POOLS.Spectral, k)
        end
    end

    COSMOS_INITIALIZED = true
end

SMODS.Atlas({
    key = "stargaze_deck",
    px = 71,
    py = 95,
    path = "Stargaze/deck.png"
})

SMODS.Back({
    key = "cosmos",
    pos = { x = 0, y = 0 },
    atlas = "stargaze_deck",
    ppu_coder = { "FALATRO" },
    ppu_artist = { "KaitlynTheStampede", "DanielDeisar"},
    ppu_team = { "Stargaze" },
    unlocked = true,

    apply = function(self, back)

        G.E_MANAGER:add_event(Event({
            func = function()
                local key = "j_space"

                if G.P_CENTERS[key] then
                    SMODS.add_card({ key = key })

                    local card = G.jokers.cards[#G.jokers.cards]
                    if card then
                        card:set_edition({negative = true})
                    end
                end

                if not G.GAME.cosmos_planet_effect then
                    G.GAME.cosmos_planet_effect = true

                    local old_calculate = SMODS.calculate_context

                    SMODS.calculate_context = function(context, ...)
                        local result = old_calculate(context, ...)

                        if context.using_consumeable then
                            if context.consumeable
                            and context.consumeable.ability
                            and context.consumeable.ability.set == "Planet" then

                                G.E_MANAGER:add_event(Event({
                                    func = function()

                                        init_cosmos_pools()

                                        local roll = pseudorandom("cosmos_roll")

                                        if roll < 0.55 then
                                            return true
                                        end

                                        local pool = nil

                                        if roll < 0.85 then
                                            pool = COSMOS_POOLS.Tarot
                                        else
                                            pool = COSMOS_POOLS.Spectral
                                        end

                                        if pool and #pool > 0 then
                                            local chosen = pseudorandom_element(
                                                pool,
                                                pseudoseed("cosmos_card")
                                            )

                                            local created = create_card(
                                                "Consumeables",
                                                G.consumeables,
                                                nil, nil, nil, nil,
                                                chosen
                                            )

                                            if created then
                                                G.consumeables:emplace(created)
                                                created:start_materialize()
                                            end
                                        end

                                        return true
                                    end
                                }))
                            end
                        end

                        return result
                    end
                end

                return true
            end
        }))
    end
})