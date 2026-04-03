Wormhole.LancerFanClub.piss_info = {
    current = {
        urine = {
            value = 50
        },
        wasteWater = {
            value = 50
        },
        cleanWater = {
            value = 50
        },
    }
}
local json = require("json")
local https = require("SMODS.https")
local last_piss_ping

local function process_piss_info(...)
    print(...)
    local ret = ({ ... })
    if ret[1] == 200 then
        Wormhole.LancerFanClub.piss_info = json.decode(ret[2])
    end
end

function Wormhole.LancerFanClub.get_piss()
    if last_piss_ping and ((G.TIMERS.REAL - last_piss_ping) > 10) then
        last_piss_ping = G.TIMERS.REAL
        https.asyncRequest("https://api.peeonauts.com/live", process_piss_info)
    end
end

G.E_MANAGER:add_event(Event({
    func = function()
        Wormhole.LancerFanClub.get_piss()
        return true
    end
}))

SMODS.Joker {
    key = "lfc_pissstream",
    --atlas = "placeholders",
    --pos = {x = 2, y = 0},

    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    demicoloncompat = true,
    atlas = "lfc_jokers",
    pos = { x = 0, y = 0 },

    config = {
        extra = {
            water = 1,
            shit = 0.25,
            piss = 0.1,
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.water,
                card.ability.extra.shit,
                card.ability.extra.piss,
                math.ceil(card.ability.extra.water * Wormhole.LancerFanClub.piss_info.current.cleanWater.value),
                math.ceil(card.ability.extra.shit * Wormhole.LancerFanClub.piss_info.current.wasteWater.value),
                math.ceil(card.ability.extra.piss * Wormhole.LancerFanClub.piss_info.current.urine.value)
            },
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                mult = math.ceil(card.ability.extra.shit * Wormhole.LancerFanClub.piss_info.current.wasteWater.value),
                chips = math.ceil(card.ability.extra.water * Wormhole.LancerFanClub.piss_info.current.cleanWater.value)
            }
        end
    end,

    calc_dollar_bonus = function(self, card)
        return math.ceil(card.ability.extra.piss * Wormhole.LancerFanClub.piss_info.current.urine.value)
    end
}
