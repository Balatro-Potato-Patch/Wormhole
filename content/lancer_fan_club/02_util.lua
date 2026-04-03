Wormhole.LFC_Util = {}

Wormhole.LFC_Util.debug_print = function(str)
    if print and G.GAME.lfc_debug then print(str) end
end
Wormhole.LFC_Util.total_keys = function(table)
    local length = 0
    for _, __ in pairs(table) do
        length = length + 1
    end
    return length
end

-- Copied from slimeutils :)
Wormhole.LFC_Util.card_obscured = function(card)
	return not card.config.center.discovered and (card.ability.consumeable or card.config.center.unlocked) and not card.bypass_discovery_center
end