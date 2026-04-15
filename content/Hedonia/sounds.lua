SMODS.Sound({
    key = "hedonia_tonightsmenu_music",
    path = "Hedonia/music_tonightsmenu.ogg",
    pitch = 1,
    volume = 1,
    select_music_track = function()
        return G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'hedonia_menu' and 100 or nil
    end,
})
