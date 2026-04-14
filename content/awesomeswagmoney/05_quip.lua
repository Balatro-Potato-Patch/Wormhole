local sounds = {}
for i = 1, 11 do
    SMODS.Sound{
        key = "eviltalk"..i,
        path = "awesomeswagmoney/voice"..i..".ogg"
    }
end
for i = 11, 1, -1 do
    sounds[#sounds+1] = "worm_eviltalk"..i
end

SMODS.JimboQuip{
    key = "kartana_jumpscare",
    type = 'loss',
    extra = {
        center = "c_worm_kartana",
        particle_colours = { --kartana colours
            G.C.ORANGE,
            G.C.WHITE,
            G.C.GOLD,
        },
        materialize_colours = {
            G.C.ORANGE,
            G.C.GOLD,
            G.C.RED,
        },
        sound = sounds,
    },
}