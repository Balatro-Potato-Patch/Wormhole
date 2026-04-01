Wormhole = SMODS.current_mod

if PotatoPatchUtils then
    local file_blacklist = {
        -- Format entries as `['filename.txt'] = true`
    }

    PotatoPatchUtils.load_files(Wormhole.path .. '/content', file_blacklist)
    SMODS.handle_loc_file(Wormhole.path)
    PotatoPatchUtils.LOC.init()

    SMODS.current_mod.extra_tabs = PotatoPatchUtils.CREDITS.register_page(SMODS.current_mod)

    -- Reset Game Globals func to hook
    function Wormhole.reset_game_globals(run_start) end
end

PotatoPatchUtils.Team("Violent Violets", a83ee7, false)

PotatoPatchUtils.Developer("FireIce", HEX('AF00AF'), false, nil, "Violent Violets")
PotatoPatchUtils.Developer("Isotypical", HEX('D781FF'), false, nil, "Violent Violets")
PotatoPatchUtils.Developer("Gud", HEX("BA89F9"), false, nil, "Violent Violets")
PotatoPatchUtils.Developer("FirstTry", HEX("FFFFFF"), false, nil, "Violent Violets")