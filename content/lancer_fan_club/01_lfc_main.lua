-- Team
Wormhole.LancerFanClub = PotatoPatchUtils.Team {
    name = "Lancer Fan Club",
    loc = "PotatoPatchTeam_lancer_fan_club",
    colour = HEX("5585bd") -- this was colorpicked directly from lancer's sprite
}

-- Atlases
SMODS.Atlas({
    key = "worm_proot",
    px = 71,
    py = 95,
    path = "lancer_fan_club/icons.png"
})

-- Proto
PotatoPatchUtils.Developer {
    name = "ProdByProto",
    colour = HEX("d57a02"),
    loc = true, -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
    team = "Lancer Fan Club", -- Must match an already existing Team name
    atlas = "worm_proot",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
}

PotatoPatchUtils.Developer({
    name = "ellestuff",
    colour = HEX('ff53a9'),
    loc = true,
    team = "Lancer Fan Club"
})