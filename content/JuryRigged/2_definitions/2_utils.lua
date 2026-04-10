Wormhole.JR_UTILS = {}

Wormhole.JR_UTILS.ENABLED_SATELLITES = {
  ['High Card'] = 'new_horizon',
  ['Pair'] = 'messenger',
  ['Two Pair'] = 'tianwen_4',
  --['Three of a Kind'] = 'venera_9',
  ['Flush'] = 'galileo',
  --['Straight'] = 'cassini_huygens',
  ['Full House'] = 'sputnik_1',
  ['Four of a Kind'] = 'mariner_9',
  --['Straight Flush'] = 'voyager_2';
  --['Five of a Kind'] = '',
  --['Flush House'] = 'dawn',
  --['Flush Five'] = '',
}

Wormhole.JR_UTILS.reset_game_globals = function(run_start)
  if run_start then
    G.GAME.jr = { satellite_hands = {} }
    for hand, _ in pairs(Wormhole.JR_UTILS.ENABLED_SATELLITES) do
      G.GAME.jr.satellite_hands[hand] = {level = 0}
    end
  end
end

-- Satellite.inject populates this table
Wormhole.JR_UTILS.Satellites = {}


Wormhole.JR_UTILS.get_satellite = function(hand)
  return Wormhole.JR_UTILS.ENABLED_SATELLITES[hand]
end

Wormhole.JR_UTILS.get_hand = function(satellite)
  for hand, sat in pairs(Wormhole.JR_UTILS.ENABLED_SATELLITES) do
    if sat == satellite then
      return hand
    end
  end
end

Wormhole.JR_UTILS.localize_satellite = function(hand)
  return localize('worm_jr_satellites_' .. Wormhole.JR_UTILS.get_satellite(hand))
end

Wormhole.JR_UTILS.level_up_satellite = function(card, amount)
  amount = amount or 1
  local hand = card.ability.extra.hand_type
  update_hand_text(
    { sound = 'button', volume = 0.7, pitch = 0.8, delay = 1.3 },
    {
      handname = Wormhole.JR_UTILS.localize_satellite(hand),
      level = G.GAME.jr.satellite_hands[hand].level
    }
  )
  G.GAME.jr.satellite_hands[hand].level = G.GAME.jr.satellite_hands[hand].level + amount
  --delay(1.3)




  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.9,
    func = function()
      play_sound('tarot1')
      if card then card:juice_up(0.8, 0.5) end
      G.TAROT_INTERRUPT_PULSE = nil
      return true
    end
  }))
  update_hand_text({ sound = 'xchips', volume = 0.7, pitch = 0.9, delay = 0 }, { level = G.GAME.jr.satellite_hands[hand].level })
  delay(1.3)
  update_hand_text(
    { sound = 'xchips', volume = 0.7, pitch = 0.5, delay = 0 },
    { mult = 0, chips = 0, handname = '', level = '' }
  )
end

Wormhole.JR_UTILS.draw_satellite_soul = function(card, scale_mod, rotate_mod)
  local spr = card.children.floating_sprite
  local soul = card.config.center.soul_pos

  spr:set_sprite_pos(soul)

  spr:draw_shader(
    'dissolve', 0, nil, nil,
    card.children.center,
    scale_mod * .75, rotate_mod * math.sin(0.1 * G.TIMERS.REAL + 5) * 10,
    spr.role.offset.x,
    spr.role.offset.y + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
    nil, 0.3)

  spr:draw_shader('dissolve', nil, nil, nil,
    card.children.center, scale_mod * .75, rotate_mod * math.sin(0.1 * G.TIMERS.REAL + 5) * 10)
end
