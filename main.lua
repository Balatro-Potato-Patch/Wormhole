Wormhole = SMODS.current_mod

if PotatoPatchUtils then
    local file_blacklist = {
        -- Format entries as `['filename.txt'] = true`
    }

    PotatoPatchUtils.load_files(Wormhole.path .. '/content', file_blacklist)
    SMODS.handle_loc_file(Wormhole.path)
    PotatoPatchUtils.LOC.init()

    SMODS.current_mod.extra_tabs = PotatoPatchUtils.CREDITS.register_page(SMODS.current_mod)

    function Wormhole.reset_game_globals(run_start)
        if Wormhole.tbp and Wormhole.tbp.reset_resuited_thruster_suit then
            Wormhole.tbp.reset_resuited_thruster_suit()
        end
    end
end