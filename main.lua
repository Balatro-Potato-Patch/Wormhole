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
  function Wormhole.reset_game_globals(run_start)
    G.GAME.jr = {
      satellite_hands = {
        ['High Card'] = { level = 0 },
        ['Pair'] = { level = 0 },
        ['Two Pair'] = { level = 0 },
        ['Three of a Kind'] = { level = 0 },
        ['Straight'] = { level = 0 },
        ['Flush'] = { level = 0 },
        ['Full House'] = { level = 0 },
        ['Four of a Kind'] = { level = 0 },
        ['Straight Flush'] = { level = 0 },
        ['Royal Flush'] = { level = 0 },
        ['Flush House'] = { level = 0 },
        ['Five of a Kind'] = { level = 0 }
      },
    }
  end
end
