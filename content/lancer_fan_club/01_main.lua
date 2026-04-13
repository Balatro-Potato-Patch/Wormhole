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

        if context.remove_playing_cards and #context.removed > 0 then
            G.GAME.lfc_can_blacephalon_appear = true
        end

        if #effects > 0 then return SMODS.merge_effects(effects) end
    end
}

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

SMODS.Atlas {
    key = "lfc_spectrals",
    px = 65,
    py = 95,
    path = "lancer_fan_club/spectrals.png"
}

SMODS.Atlas {
    key = "lfc_seals",
    px = 65,
    py = 95,
    path = "lancer_fan_club/seals.png"
}

SMODS.Atlas {
    key = "lfc_blinds",
    px = 34,
    py = 34,
    path = "lancer_fan_club/blinds.png",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21
}

SMODS.Atlas {
    key = "lfc_spacebar",
    px = 95,
    py = 23,
    path = "lancer_fan_club/spacebar.png"
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
G.ARGS.LOC_COLOURS.lfc_meteor  = HEX('a97a51')

-- Developers
PotatoPatchUtils.Developer {
    name = "ProdByProto",
    colour = HEX("d57a02"),
    loc = "PotatoPatchDev_ProdByProto",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 6, y = 1 },
    soul_pos = { x = 7, y = 1 },
    calculate = function(self, context)
        if context.card_added then
            if context.card.ability.set == "Joker" then
                local cck = context.card.config.center.key
                if not G.GAME.worm_log then G.GAME.worm_log = {} end
                if not G.GAME.worm_log[cck] then
                    G.GAME.worm_log[cck] = true
                    G.GAME.worm_log_count = (G.GAME.worm_log_count or 0) + 1
                    Wormhole.LFC_Util.debug_print(G.GAME.worm_log)
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
    pos = { x = 2, y = 1 },
    soul_pos = { x = 3, y = 1 }
})

-- J8-Bit
local j8_text_colors = {
    HEX("F1641F"),
    HEX("F1641F"),
    HEX("8306C1"),
    HEX("8306C1"),
}

SMODS.DynaTextEffect {
    key = "j8_text",
    func = function(dynatext, index, letter)
        local s = #j8_text_colors
        local o = index * 0.1
        local t = G.TIMERS.REAL + o
        --print(tostring(index) .. ": " .. tostring(idx + 1) .. " " .. tostring(next_idx + 1) .. " " .. tostring(t) .. " " .. tostring(t / s))
        letter.colour = mix_colours(j8_text_colors[(math.floor(t) % s) + 1],
            j8_text_colors[((math.floor(t) + 1) % s) + 1], t % 1.0)
        letter.offset.y = math.abs(math.cos(G.TIMERS.REAL * 4.0 + index * 0.1)) * 16
    end,
}

PotatoPatchUtils.Developer({
    name = "J8-Bit",
    --colour = HEX('F1641F'),
    text_effect = "worm_j8_text",
    loc = "PotatoPatchDev_j8bit",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1 }

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

--[[
--  Note: i did code for all the forcetrigger compat stuff,
--        but it's fairly simple to do and doesn't affect
--        wormhole on its own, so it's not included in the
--        code credits
--      - alexi
--]]
PotatoPatchUtils.Developer {
    name = "InvalidOS",
    text_effect = "worm_alexi_text",
    loc = "PotatoPatchDev_alexi",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 4, y = 1 },
    soul_pos = { x = 5, y = 1 }
}
