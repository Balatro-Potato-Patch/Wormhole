-- Team
Wormhole.LancerFanClub = PotatoPatchUtils.Team {
    name = "Lancer Fan Club",
    loc = "PotatoPatchTeam_lancer_fan_club",
    colour = HEX("5585bd"), -- this was colorpicked directly from lancer's sprite
    calculate = function(self, context)
        local effects = {}

        if context.after or context.setting_blind and not context.blueprint then
            Wormhole.LancerFanClub.get_piss()
        end

        if #effects > 0 then return SMODS.merge_effects(effects) end
    end
}

-- Misc helper functions
G.lfc_print = function(str)
    if print and G.GAME.lfc_debug then print(str) end
end
G.iter = function(table)
    local length = 0
    for _, __ in pairs(table) do
        length = length + 1
    end
    return length
end


-- Atlases
SMODS.Atlas {
    key = "lfc_devs",
    px = 71,
    py = 95,
    path = "lancer_fan_club/devs.png"
}

SMODS.Atlas {
    key = "lfc_tags",
    px = 32,
    py = 32,
    path = "lancer_fan_club/tags.png"
}

SMODS.Atlas {
    key = "lfc_jokers",
    px = 71,
    py = 95,
    path = "lancer_fan_club/jokers.png"
}

-- Sounds
SMODS.Sound {
    key = "lfc_explosion",
    path = "lfc_explosion.ogg"
}

-- Colors
loc_colour('red')
G.ARGS.LOC_COLOURS.lfc_pkmn_us = HEX('E95B2B')
G.ARGS.LOC_COLOURS.lfc_pkmn_um = HEX('226DB5')

-- Developers
PotatoPatchUtils.Developer {
    name = "ProdByProto",
    colour = HEX("d57a02"),
    loc = "PotatoPatchDev_ProdByProto",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    calculate = function(self, context)
        if context.card_added then
            if context.card.ability.set == "Joker" then
                local cck = context.card.config.center.key
                if not G.GAME.worm_log then G.GAME.worm_log = {} end
                if not G.GAME.worm_log[cck] then
                    G.GAME.worm_log[cck] = true
                    G.lfc_print(G.GAME.worm_log)
                end
            end
        end
    end
}


-- Elle
PotatoPatchUtils.Developer({
    name = "ellestuff.",
    colour = HEX('ff53a9'),
    loc = "PotatoPatchDev_ellestuff",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 }
})

-- J8-Bit
PotatoPatchUtils.Developer({
    name = "J8-Bit",
    colour = HEX('FDB157'),
    loc = "PotatoPatchDev_j8bit",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 }

})

-- Alexi
local alexi_text_colors = {
    HEX("45FFDA"),
    HEX("2AC2FF"),
    HEX("307FFF"),
    HEX("C180FF"),
    HEX("FFC7FF"),
}

-- very likely to be changed to fit "InvalidOS"
SMODS.DynaTextEffect {
    key = "alexi_text",
    func = function(dynatext, index, letter)
        local idx = math.min(index, 5)
        letter.colour = alexi_text_colors[idx]
        letter.offset.y = math.cos(G.TIMERS.REAL * 2.95 + index) * 9
    end,
}

PotatoPatchUtils.Developer {
    name = "InvalidOS",
    text_effect = "worm_alexi_text",
    loc = "PotatoPatchDev_alexi",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 }
}