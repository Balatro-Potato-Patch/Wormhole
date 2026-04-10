SMODS.Atlas({key = "asm_credits", path = "awesomeswagmoney/credits.png", px = 89, py = 109, atlas_table = "ASSET_ATLAS"}):register()


PotatoPatchUtils.Team{
    name = "awesomeswagmoney",
    colour = HEX("345678"),
    loc = true,
}
--extra prefix isnt technically needed but could avoid duplicate register conflicts with other event mods
PotatoPatchUtils.Developer{
    atlas = 'worm_asm_credits', 
    pos = { x = 0, y = 0 }, 
    soul_pos = { x = 1, y = 0 }, 
    name = "worm_garb",
    team = "awesomeswagmoney",
    loc = true,
}

PotatoPatchUtils.Developer{
    name = "worm_poker",
    team = "awesomeswagmoney",
    loc = true,
}

PotatoPatchUtils.Developer{
    name = "worm_omega",
    team = "awesomeswagmoney",
    loc = true,
}

PotatoPatchUtils.Developer{
    name = "worm_superb",
    team = "awesomeswagmoney",
    loc = true,
}

PotatoPatchUtils.Developer{
    name = "worm_eris",
    team = "awesomeswagmoney",
    loc = true,
}