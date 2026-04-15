
PotatoPatchUtils.Team {
  name = 'Balatro Stewniversity',
  colour = HEX('bb6528'),
  loc = "stew",
  short_credit = true,
}

PotatoPatchUtils.Developer {
  name = 'PLagger',
  colour = HEX('943A48'),
  loc = "PLagger",
  team = 'Balatro Stewniversity'
}

PotatoPatchUtils.Developer {
  name = 'stupxd',
  colour = HEX('61b5ff'),
  loc = "stupxd",
  team = 'Balatro Stewniversity'
}

PotatoPatchUtils.Developer {
  name = 'dottykitty',
  colour = HEX('62afe3'),
  loc = "dottykitty",
  team = 'Balatro Stewniversity'
}

PotatoPatchUtils.Developer {
  name = 'Wingcap',
  colour = HEX('FF1F00'),
  loc = "Wingcap",
  team = 'Balatro Stewniversity'
}

PotatoPatchUtils.Developer {
  name = 'tuzzo',
  colour = HEX('ff7d5b'),
  loc = "tuzzo",
  team = 'Balatro Stewniversity'
}

PotatoPatchUtils.Developer {
  name = 'HonuKane',
  colour = HEX('15A61C'),
  loc = "HonuKane",
  team = 'Balatro Stewniversity'
}

PotatoPatchUtils.Developer {
  name = 'harmonywoods',
  colour = HEX('ffffff'),
  loc = "harmonywoods",
  team = 'Balatro Stewniversity'
}

local custom_colours = {
  stew_inactive_lighter = lighten(G.C.UI.TEXT_INACTIVE, 0.8),
  -- stew_yellow = lighten(G.C.YELLOW, 0.1)
}

local loc_col_ref = loc_colour
function loc_colour(_c, _default)
  return custom_colours[_c] or  loc_col_ref(_c, _default)
end
