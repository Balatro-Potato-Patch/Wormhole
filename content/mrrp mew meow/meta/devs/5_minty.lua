local once = true

PotatoPatchUtils.Developer {
    name = 'Minty',
    team = 'Mrrp Mew Meow :3',
    colour = G.C.mrrp_pink,
    loc = true,
    atlas = 'worm_mrrp', pos = { x=4, y=4 },
    click = function (self)
        local pct = (80 + math.random(40))/100
        play_sound("worm_mrrp_meow", pct)
        if once then
            once = false
            love.system.openURL("https://github.com/wingedcatgirl/")
        end
    end
}