if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

Wormhole.COLON_THREE.C.JunkSet = HEX("ff5e25")

SMODS.ConsumableType {
    key = "JunkSet",
	primary_colour = Wormhole.COLON_THREE.C.JunkSet,
	secondary_colour = Wormhole.COLON_THREE.C.JunkSet,
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	default = "c_worm_asteroid_harvester"
}

SMODS.Enhancement {
    key = "junk_card",
    ppu_coder = "lordruby",
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = 1
            }
        end
    end
}

function Wormhole.COLON_THREE.junk_can_use(func)
    return function(self, card)
        local num = card.ability.extra.cleanup_num or card.ability.extra.junk_num or 1
        local junk = 0
        for i, v in pairs(G.hand.highlighted) do
            if v.config.center.key == "m_worm_junk_card" then junk = junk + 1 end
        end
        return G.hand and #G.hand.highlighted == num and (not func or func(self, card)) and (junk == 0 or junk == num)
    end
end

function Wormhole.COLON_THREE.junk_use(func, once)
    return function(self, card)
        local h = {}
        local aj = true
        for i, v in pairs(G.hand.cards) do
            if v.highlighted then 
                h[#h+1] = v 
                if v.config.center.key ~= "m_worm_junk_card" then aj = nil end
            end
        end
        for i, v in ipairs(h) do
            local card = h[i]
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.25,
                func = function()
                    card:flip()
                    return true
                end
            }))
        end
        if aj and once then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.3,
                func = function()
                    func(self, card)
                    for i, v in ipairs(h) do
                        v:set_ability(G.P_CENTERS.c_base)
                    end
                    return true
                end
            }))
        else
            for i, v in ipairs(h) do
                local card = h[i]
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.3,
                    func = function()
                        if aj then
                            func(self, card, v)
                            v:set_ability(G.P_CENTERS.c_base)
                        else
                            v:set_ability(G.P_CENTERS.m_worm_junk_card)
                        end
                        return true
                    end
                }))
            end
        end
        for i, v in ipairs(h) do
            local card = h[i]
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.25,
                func = function()
                    card:flip()
                    return true
                end
            }))
        end
    end
end