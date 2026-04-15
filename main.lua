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


PotatoPatchUtils.Team {
  name = 'Violent Violets',
  colour = HEX('A83EE7'),
  loc = "VV", -- Can also be `loc = 'k_exampleteam_name'` where the string is an arbitrary localization dictionary entry
}

PotatoPatchUtils.Developer {
  name = 'FireIce',
  colour = HEX('AF00AF'),
  loc = 'FireIce', -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Violent Violets' -- Must match an already existing Team name
}
PotatoPatchUtils.Developer {
  name = 'Gud',
  colour = HEX('D781FF'),
  loc = 'Gud', -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Violent Violets' -- Must match an already existing Team name
}
PotatoPatchUtils.Developer {
  name = 'Iso',
  colour = HEX("BA89F9"),
  loc = 'Iso', -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Violent Violets' -- Must match an already existing Team name
}
PotatoPatchUtils.Developer {
  name = 'FirstTry',
  colour = HEX("FFFFFF"),
  loc = 'FirstTry', -- Can also be `loc = 'k_doofus_name'` where the string is an arbitrary localization dictionary entry
  team = 'Violent Violets',
  atlas = 'worm_devs',
  pos = { x = 0, y = 0 }
}