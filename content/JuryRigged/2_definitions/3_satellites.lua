SMODS.ConsumableType({
  key = "worm_jr_satellite",
  class_prefix = "sat",
  primary_colour = HEX("CC56CC"),
  secondary_colour = HEX("A85D7C"),
  collection_rows = { 6, 6 },
  default = 'sat_worm_new_horizon'
})

Wormhole.JR_UTILS.Satellite = SMODS.Consumable:extend {
  set = "worm_jr_satellite",
  class_prefix = "sat",
  unlocked = true,
  discovered = false,
  cost = 4,
  ppu_coder = { 'dowfrin' },
  ppu_artist = { 'DoggFly', 'Inky' },
  ppu_team = { 'jr' },
  atlas = 'worm_jr_Satellites',

  use = function(self, card, area, copier)
    Wormhole.JR_UTILS.level_up_satellite(card)
    print('Using ' .. card.config.center.key)
    print('Set: ' .. card.config.center.set)
  end,

  can_use = function(self, card)
    return true
  end
}


Wormhole.JR_UTILS.Satellite {
  key = 'new_horizon',
  config = { extra = { hand = 'High Card' } },
  pos = { x = 0, y = 0 },
  soul_pos = { x = 0, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
}
