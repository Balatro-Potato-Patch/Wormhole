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
  ppu_coder = { 'DowFrin', 'Maelmc' },
  ppu_artist = { 'DoggFly', 'Inky' },
  ppu_team = { 'JuryRigged' },
  atlas = 'worm_jr_Satellites',

  inject = function(self, i)
    SMODS.Consumable.inject(self)
    Wormhole.JR_UTILS.Satellites[self.key] = {
      name = self.name,
      vars = self.config.extra,
      calculate = self.jr_calculate,
      loc_vars = self.jr_loc_vars
    }
  end,

  use = function(self, card, area, copier)
    Wormhole.JR_UTILS.level_up_satellite(card)
  end,

  can_use = function(self, card)
    return true
  end
}


Wormhole.JR_UTILS.Satellite {
  key = 'new_horizon',
  name = 'new_horizon',
  config = { extra = { hand_type = 'High Card' }, },
  pos = { x = 0, y = 0 },
  soul_pos = { x = 0, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },

  jr_calculate = function(self, context,vars)
    if context.hand_drawn and G.GAME.jr.curr_hand then
      --print("new_horizon calc")
      G.GAME.jr.curr_hand = nil
      SMODS.draw_cards(G.GAME.jr.satellite_hands[vars.hand_type].level)
      return nil, true
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return  {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        _level <= 1 and '' or 's',
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  jr_loc_vars = function(self)
    return {}
  end
}
