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


-- New Horizon
Wormhole.JR_UTILS.Satellite {
  key = 'new_horizon',
  name = 'new_horizon',
  config = { extra = { hand_type = 'High Card' }, },
  pos = { x = 0, y = 0 },
  soul_pos = { x = 0, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },

  jr_calculate = function(self, context, vars)
    if context.drawing_cards and G.GAME.jr.curr_hand then
      return {
        modify = G.GAME.jr.satellite_hands[vars.hand_type].level + (math.max(context.amount, 0))
      }
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        _level == 1 and '' or 's',
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  jr_loc_vars = function(self)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        _level <= 1 and '' or 's',
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end
}

-- MESSENGER
Wormhole.JR_UTILS.Satellite {
  key = 'messenger',
  name = 'messenger',
  config = { extra = { hand_type = 'Pair', num = 1, den = 2 }, },
  pos = { x = 1, y = 0 },
  soul_pos = { x = 1, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },

  jr_calculate = function(self, context, vars)
    if context.cardarea == "unscored" and context.individual then
      if SMODS.pseudorandom_probability(nil, 'worm_jr_messenger', vars.num, vars.den) then
        if context.other_card.debuff then
          return {
            message = localize('k_debuffed'),
            colour = G.C.RED,
            card = context.other_card
          }
        else
          G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + G.GAME.jr.satellite_hands[vars.hand_type].level
          return {
            dollars = G.GAME.jr.satellite_hands[vars.hand_type].level,
            func = function()
              G.E_MANAGER:add_event(Event({
                func = function()
                  G.GAME.dollar_buffer = 0
                  return true
                end
              }))
            end,
            card = context.other_card
          }
        end
      end
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, "worm_jr_messenger")
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        num,
        den,
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  jr_loc_vars = function(self)
    return {}
  end
}

-- Tianwen 4
Wormhole.JR_UTILS.Satellite {
  key = 'tianwen_4',
  name = 'tianwen_4',
  config = { extra = { hand_type = 'Two Pair' }, },
  pos = { x = 2, y = 0 },
  soul_pos = { x = 2, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },

  jr_calculate = function(self, context, vars)
    if context.before then
      for _ = 1, G.GAME.jr.satellite_hands[vars.hand_type].level do
        local _target = pseudorandom_element(context.scoring_hand, "worm_jr_tianwen_4")
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        local card_copied = copy_card(_target, nil, nil, G.playing_card)
        card_copied:add_to_deck()
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, card_copied)
        G.hand:emplace(card_copied)
        card_copied.states.visible = nil

        G.E_MANAGER:add_event(Event({
          func = function()
            card_copied:start_materialize()
            return true
          end
        }))
        SMODS.calculate_effect({
          message = localize('k_copied_ex'),
          colour = G.C.CHIPS,
          func = function() -- This is for timing purposes, it runs after the message
            G.E_MANAGER:add_event(Event({
              func = function()
                SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                return true
              end
            }))
          end
        }, _target)
      end
      return nil, true
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        _level <= 1 and 'y' or 'ies',
        _level <= 1 and 'a ' or '',
        _level <= 1 and '' or 's',
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  jr_loc_vars = function(self)
    return {}
  end
}

-- Venera 9

-- Galileo
Wormhole.JR_UTILS.Satellite {
  key = 'galileo',
  name = 'galileo',
  config = { extra = { hand_type = 'Flush' }, },
  pos = { x = 4, y = 0 },
  soul_pos = { x = 4, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.before then
      G.GAME.jr.galileo_targets = {}
      for _ = 1, G.GAME.jr.satellite_hands[vars.hand_type].level do
        local _target = tostring(pseudorandom("worm_jr_galileo", 1, #context.scoring_hand))
        G.GAME.jr.galileo_targets[_target] = (G.GAME.jr.galileo_targets[_target] or 0) + 1
      end
    end

    if context.repetition and context.cardarea == G.play then
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i] == context.other_card then
          if G.GAME.jr.galileo_targets[tostring(i)] then
            return {
              message = localize('k_again_ex'),
              repetitions = G.GAME.jr.galileo_targets[tostring(i)] or 0,
              card = context.other_card
            }
          else
            break
          end
        end
      end
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
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

-- Cassini-Huygens

-- Sputnik 1
Wormhole.JR_UTILS.Satellite {
  key = 'sputnik_1',
  name = 'sputnik_1',
  config = { extra = { hand_type = 'Full House' }, },
  pos = { x = 6, y = 0 },
  soul_pos = { x = 6, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[#context.scoring_hand] then
      return {
        xmult = 1 + G.GAME.jr.satellite_hands[vars.hand_type].level * 0.25
      }
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        1 + 0.25 * _level,
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  jr_loc_vars = function(self)
    return {}
  end
}

-- Mariner 9
Wormhole.JR_UTILS.Satellite {
  key = 'mariner_9',
  name = 'mariner_9',
  config = { extra = { hand_type = 'Four of a Kind' }, },
  pos = { x = 7, y = 0 },
  soul_pos = { x = 7, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.before then
      local ranks = {}
      local rank
      for _, v in pairs(context.scoring_hand) do
        local vrank = v:get_id()
        ranks[vrank] = (ranks[vrank] or 0) + 1
        if ranks[vrank] > 1 then
          rank = vrank
          break
        end
      end

      if not rank then return end -- failsafe

      local rank_count = 0
      for _, v in pairs(G.playing_cards) do
        if v:get_id() == rank then rank_count = rank_count + 1 end
      end

      G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + rank_count * G.GAME.jr.satellite_hands[vars.hand_type].level
      return {
        dollars = rank_count * G.GAME.jr.satellite_hands[vars.hand_type].level,
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              G.GAME.dollar_buffer = 0
              return true
            end
          }))
        end,
        card = context.other_card
      }
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  jr_loc_vars = function(self)
    return {}
  end
}
