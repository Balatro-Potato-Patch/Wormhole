loc_colour()
G.ARGS.LOC_COLOURS.worm_thorn_willow = HEX('38A336')

SMODS.Atlas {
    key = 'TeamCredits',
    path = 'thorn/TeamCredits.png',
    px = 71,
    py = 95
}

PotatoPatchUtils.Team({
    name = "thorn", 
    loc = true,
    colour = HEX("5ddaF3"),
    credit_rows = { 4, 2 }
})

PotatoPatchUtils.Developer({
    team = "thorn",
    name = "marie",
    colour = G.C.BLUE,
    loc = true,
    atlas = 'worm_TeamCredits',
    pos = {x = 5, y = 0},
    soul_pos = {x = 5, y = 1},
})

PotatoPatchUtils.Developer({
    team = "thorn",
    name = "willow",
    colour = G.ARGS.LOC_COLOURS.worm_thorn_willow,
    loc = true,
    atlas = 'worm_TeamCredits',
    pos = {x = 0, y = 0},
})

PotatoPatchUtils.Developer({
    team = "thorn",
    name = "mtw",
    colour = G.C.GOLD,
    loc = true,
    atlas = 'worm_TeamCredits',
    pos = {x = 3, y = 0},
})

PotatoPatchUtils.Developer({
    team = "thorn",
    name = "evgast",
    colour = G.C.PURPLE,
    loc = true,
    atlas = 'worm_TeamCredits',
    pos = {x = 4, y = 0},
})

PotatoPatchUtils.Developer({
    team = "thorn",
    name = "sophie",
    colour = HEX("fd72eb"),
    loc = true,
    atlas = 'worm_TeamCredits',
    pos = {x = 1, y = 0},
})

PotatoPatchUtils.Developer({
    team = "thorn",
    name = "hatstack",
    colour = G.C.PURPLE,
    loc = true,
    atlas = 'worm_TeamCredits',
    pos = {x = 0, y = 1},
})
