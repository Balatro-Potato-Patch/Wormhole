PotatoPatchUtils.Team {
    name = "riverboat",
    colour = HEX("ff8c69"),
    loc = true,
}

PotatoPatchUtils.Developer {
    name = "blamperer",
    team = "riverboat",
    atlas = "worm_riverboat_credits",
    pos = { x = 0, y = 0 },
    loc = true,
    click = function()
        love.system.openURL("https://github.com/blamperer/The-Latro")
    end
}

PotatoPatchUtils.Developer {
    name = "fooping",
    team = "riverboat",
    atlas = "worm_riverboat_credits",
    pos = { x = 1, y = 0 },
    loc = true,
    click = function()
        love.system.openURL("https://ko-fi.com/fooping")
    end
}

PotatoPatchUtils.Developer {
    name = "snipey",
    team = "riverboat",
    loc = true
}

PotatoPatchUtils.Developer {
    name = "camo",
    team = "riverboat",
    atlas = "worm_riverboat_credits",
    pos = { x = 3, y = 0 },
    loc = true,
    click = function()
        love.system.openURL("https://ko-fi.com/camostar34")
    end
}
