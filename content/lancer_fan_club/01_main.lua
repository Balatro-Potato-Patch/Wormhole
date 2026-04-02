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

-- Atlases
SMODS.Atlas {
    key = "lfc_devs",
    px = 71,
    py = 95,
    path = "lancer_fan_club/devs.png"
}

-- Sounds
SMODS.Sound {
    key = "lfc_explosion",
    path = "lfc_explosion.ogg"
}

-- Developers
PotatoPatchUtils.Developer {
    name = "ProdByProto",
    colour = HEX("d57a02"),
    loc = "PotatoPatchDev_ProdByProto",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    calculate = function(self,context)
        if context.card_added then
            if context.card.ability.set == "Joker" then
                if not G.GAME.worm_log then G.GAME.worm_log = 0 end
                G.GAME.worm_log = G.GAME.worm_log + 1
                if G.GAME.worm_debug then
                    print("scale jokers log")
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