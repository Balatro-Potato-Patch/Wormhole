-- Booster type definition
Wormhole.JR_UTILS.SatelliteBooster = SMODS.Booster:extend {
  group_key = 'worm_jr_orbital_pack',
  kind = 'worm_jr_satellite',

  loc_vars = function(self, info_queue, card)
    local orig = SMODS.Booster.loc_vars(self, info_queue, card)
    orig['key'] = self.key:gsub('_%d$', '')
    return orig
  end,

  create_card = function(self, card, i)
    return {
      set = 'worm_jr_satellite',
      area = G.pack_cards,
      skip_materialize = true,
    }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.worm_jr_satellite)
    ease_background_colour { new_colour = G.C.SET.worm_jr_satellite, special_colour = G.C.BLACK, contrast = 2 }
  end,
  ppu_coder = { 'DowFrin' },
  ppu_team = { 'JuryRigged' },
}

-- Normal
Wormhole.JR_UTILS.SatelliteBooster {
  key = 'jr_orbital_normal_1',
  atlas = 'worm_jr_boosters',
  pos = { x = 0, y = 0 },
  config = {
    extra = 2,
    choose = 1
  },
  weight = 1,
  cost = 4,
  discovered = false,
  ppu_artist = { 'DoggFly', 'Inky' },
}

Wormhole.JR_UTILS.SatelliteBooster {
  key = 'jr_orbital_normal_2',
  atlas = 'worm_jr_boosters',
  pos = { x = 3, y = 0 },
  config = {
    extra = 2,
    choose = 1
  },
  weight = 1,
  cost = 4,
  discovered = false,
  ppu_artist = { 'DoggFly', 'Inky' },
}

-- Jumbo
Wormhole.JR_UTILS.SatelliteBooster {
  key = 'jr_orbital_jumbo_1',
  atlas = 'worm_jr_boosters',
  pos = { x = 0, y = 1 },
  config = {
    extra = 4,
    choose = 1
  },
  weight = 1,
  cost = 4,
  discovered = false,
  ppu_artist = { 'DoggFly' },
}

-- Mega
Wormhole.JR_UTILS.SatelliteBooster {
  key = 'jr_orbital_mega_1',
  atlas = 'worm_jr_boosters',
  pos = { x = 2, y = 1 },
  config = {
    extra = 4,
    choose = 2
  },
  weight = 0.25,
  cost = 4,
  discovered = false,
  ppu_artist = { 'DoggFly', 'Inky' },
}
