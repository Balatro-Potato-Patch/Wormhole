SMODS.Atlas {
  key = "DummiesPlanets",
  path = "Dummies/WormholePlanets.png",
  px = 71,
  py = 95
}

SMODS.Consumable {
  set = "Planet",
  key = "moony",
  pos = { x = 0, y = 0 },
  config = {
    extra = { levels = 1 },
  },
  atlas = "DummiesPlanets",
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.levels } }
  end,

  can_use = function(self, card)
    return true
  end,

  use = function(self, card, area, copier)

  end
}