SMODS.Sound({
    key = "hedonia_tonightsmenu_music",
    path = "music_tonightsmenu.ogg",
    pitch = 0.7,
    volume = 0.6,
    select_music_track = function()
        return G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'hedonia_menu' and 100 or nil
    end,
})
