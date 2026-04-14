SMODS.Atlas {
    key = "deck",
    px = 71,
    py = 95,
    path = "Hedonia/deck.png"
}

SMODS.Back {
    key = 'hedonia_bar',
    atlas = 'deck',
    pos = {x=0, y=0},
    ppu_artist = {'qunumeru'},
    ppu_coder = {'axyraandas', 'wombatcountry'},
    ppu_team = {'Hedonia'},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    local candidates = {}
                    for i,v in pairs(G.P_CENTER_POOLS.Joker) do
                        if v.pools and v.pools.Bartender then
                            candidates[#candidates+1] = v.key
                        end
                    end
                    
                    SMODS.add_card({area = G.jokers, key = pseudorandom_element(candidates)})
                end
                return true
            end
        }))
    end
}
