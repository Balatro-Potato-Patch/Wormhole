-- Dev Atlas
SMODS.Atlas {
    key = "shrug_developers",
    px = 71,
    py = 95,
    path = "TeamShrug/developers.png"
}

SMODS.Atlas{
    key = 'shrug_randomsong',
    path = 'TeamShrug/rory_nyte.png',
    px = 80,
    py = 97,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 71,
    fps = 30
}

-- Team establish
PotatoPatchUtils.Team({
    name = "shrug", 
    loc = true,
    colour = HEX("B6334C"),
    --colour = HEX("A65A60"), --low contrast variant
})

-- RandomsongV2
PotatoPatchUtils.Developer({
    team = "shrug",
    name = "randomsongv2",
    loc = true,
    colour = HEX("7b1414"),
    atlas = 'worm_shrug_randomsong',
    pos = {y = -1},
    soul_pos = {y = 0},
})

-- Microwave
PotatoPatchUtils.Developer({
    team = "shrug",
    name = "microwave",
    loc = true,
    colour = HEX("845aad"),
    atlas = "worm_shrug_developers",
    pos = {x = 0, y = 0},
})

-- Waffle
PotatoPatchUtils.Developer({
    team = "shrug",
    name = "waffle",
    loc = true,
    colour = HEX("45ad71"),
    atlas = 'worm_shrug_developers',
    pos = {x = 0, y = 1},
    soul_pos = {x = 1, y = 1},
})

-- A Tired Guy
PotatoPatchUtils.Developer({
    team = "shrug",
    name = "atiredguy",
    loc = true,
    colour = HEX("8f8275"),
    atlas = 'Joker',
    pos = {x = 5, y = 8},
    soul_pos = {x = 5, y = 9},
})

-- Edward Robinson
PotatoPatchUtils.Developer({
    team = "shrug",
    name = "edwardrobinson",
    loc = true,
    colour = HEX("ffffff"),
    atlas = 'worm_shrug_developers',
    pos = {x = 0, y = 2},
})
