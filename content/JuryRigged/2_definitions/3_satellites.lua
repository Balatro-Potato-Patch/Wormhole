SMODS.ConsumableType({
  key = "worm_jr_satellite",
  class_prefix = "sat",
  primary_colour = HEX("CC56CC"),
  secondary_colour = HEX("A85D7C"),
  collection_rows = { 6, 6 },
  default = 'sat_worm_new_horizon'
})

SMODS.UndiscoveredSprite {
  key = 'worm_jr_satellite',
  atlas = 'jr_Undiscovered',
  pos = { x = 0, y = 0 },
}

Wormhole.JR_UTILS.Satellite = SMODS.Consumable:extend {
  set = "worm_jr_satellite",
  class_prefix = "sat",
  unlocked = true,
  discovered = false,
  cost = 4,
  ppu_coder = { 'DowFrin', 'Maelmc' },
  ppu_team = { 'JuryRigged' },
  atlas = 'worm_jr_Satellites',

  inject = function(self, i)
    SMODS.Consumable.inject(self)
    Wormhole.JR_UTILS.Satellites[self.key] = {
      name = self.name,
      vars = self.config.extra,
      calculate = self.jr_calculate,
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
  ppu_artist = { 'DoggFly', 'Inky' },
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
  ppu_artist = { 'DoggFly', 'Inky' },
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
  ppu_artist = { 'DoggFly', 'Inky' },
}

-- Venera 9
Wormhole.JR_UTILS.Satellite {
  key = 'venera_9',
  name = 'venera_9',
  config = { extra = { hand_type = 'Three of a Kind', num = 1, den = 2 }, },
  pos = { x = 3, y = 0 },
  soul_pos = { x = 3, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.before then
      -- get all ranks in played hand
      local ranks = {}
      for _, v in pairs(context.scoring_hand) do
        if not SMODS.has_no_rank(v) then
          ranks[v.base.value] = (ranks[v.base.value] or 0) + 1
        end
      end

      -- get the highest amount of common rank
      local _max = 0
      for _, v in pairs(ranks) do
        _max = math.max(_max,v)
      end

      -- get the target rank
      local targets = {}
      for k, v in pairs(ranks) do
        if v == _max then targets[#targets+1] = k end
      end

      local target_rank = #targets == 1 and targets[1] or pseudorandom_element(targets,"worm_jr_venera_9")
      if not target_rank then return end

      -- eligible cards
      targets = {}
      for _, v in pairs(G.playing_cards) do
        if (not SMODS.has_no_rank(v)) and v.base.value ~= target_rank then targets[#targets+1] = v end
      end

      -- change cards in deck
      for _ = 1, G.GAME.jr.satellite_hands[vars.hand_type].level do
        if #targets == 0 then return end
        if SMODS.pseudorandom_probability(nil, 'worm_jr_venera_9', vars.num, vars.den) then
          local _card, pos = pseudorandom_element(targets, "worm_jr_venera_9")
          SMODS.change_base(_card, nil, target_rank)
          _card:juice_up()
          table.remove(targets, pos)
        end
      end

    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    local num, den = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.den, "venera_9")
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        _level <= 1 and '' or 's',
        num,
        den,
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  ppu_artist = { 'DoggFly', 'Inky' },
}

-- Cassini-Huygens
Wormhole.JR_UTILS.Satellite {
  key = 'cassini_huygens',
  name = 'cassini_huygens',
  config = { extra = { hand_type = 'Straight' }, },
  pos = { x = 4, y = 0 },
  soul_pos = { x = 4, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.before then
      -- get all ranks in played hand
      local ranks = {}
      for _, v in pairs(context.scoring_hand) do
        if not SMODS.has_no_rank(v) then
          ranks[v:get_id()] = true
        end
      end

      -- change cards in deck
      local targets = {}
      for _, v in pairs(G.playing_cards) do
        if SMODS.has_no_rank(v) or (not ranks[v:get_id()]) then targets[#targets+1] = v end
      end

      print(#targets)

      local to_delete = {}
      for _ = 1, G.GAME.jr.satellite_hands[vars.hand_type].level do
        if #targets == 0 then break end
        local _card, pos = pseudorandom_element(targets,"worm_jr_cassini_huygens")
        to_delete[#to_delete+1] = _card
        table.remove(targets,pos)
      end
      --G.E_MANAGER:add_event(Event({
      --  func = function()
          SMODS.destroy_cards(to_delete)
      --    return true
      --  end
      --}))

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
  ppu_artist = { 'DoggFly', 'Inky'},
}

-- Galileo
Wormhole.JR_UTILS.Satellite {
  key = 'galileo',
  name = 'galileo',
  config = { extra = { hand_type = 'Flush' }, },
  pos = { x = 5, y = 0 },
  soul_pos = { x = 5, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.before then
      -- get all suits in played hand
      local suits = {}
      for _, v in pairs(context.scoring_hand) do
        if not SMODS.has_no_suit(v) then
          suits[v.base.suit] = (suits[v.base.suit] or 0) + 1
        end
      end

      -- get the highest amount of common suit
      local _max = 0
      for _, v in pairs(suits) do
        if v > _max then _max = v end
      end

      -- get the target suit
      local targets = {}
      for k, v in pairs(suits) do
        if v == _max then targets[#targets+1] = k end
      end

      local target = #targets == 1 and targets[1] or pseudorandom_element(targets,"worm_jr_galileo")
      if not target then return end

      -- change cards in deck
      local not_suit = {}
      for _, v in pairs(G.playing_cards) do
        if v.base.suit ~= target then not_suit[#not_suit+1] = v end
      end

      for _ = 1, G.GAME.jr.satellite_hands[vars.hand_type].level do
        if #not_suit == 0 then return end
        local _card, pos = pseudorandom_element(not_suit,"worm_jr_galileo")
        _card:change_suit(target)
        _card:juice_up()
        table.remove(not_suit,pos)
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
  ppu_artist = { 'AbelSketch', 'Inky' },
}

-- Sputnik 1
Wormhole.JR_UTILS.Satellite {
  key = 'sputnik_1',
  name = 'sputnik_1',
  config = { extra = { hand_type = 'Full House'}, },
  pos = { x = 6, y = 0 },
  soul_pos = { x = 6, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.before then
      -- eligible cards
      targets = {}
      for _, v in pairs(G.deck.cards) do
        targets[#targets+1] = v
      end

      -- change cards in deck
      for _ = 1, G.GAME.jr.satellite_hands[vars.hand_type].level do
        if #targets == 0 then return end
        local _card, pos = pseudorandom_element(targets, "worm_jr_sputnik_1")
        local _rand = pseudorandom("worm_jr_sputnik_1",1,3)
        if _rand == 1 then
          _card:set_seal(SMODS.poll_seal({ guaranteed = true, key = 'worm_jr_sputnik_1' }), true, true)
        elseif _rand == 2 then
          _card:set_edition(SMODS.poll_edition { key = "worm_jr_sputnik_1", guaranteed = true, no_negative = true, options = { 'e_polychrome', 'e_holo', 'e_foil' } })
        else
          _card:set_ability(SMODS.poll_enhancement({guaranteed = true, key = "worm_jr_sputnik_1"}),nil,true)
        end
        _card:juice_up()
        table.remove(targets, pos)
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
  ppu_artist = { 'DoggFly', 'Inky' },
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
  ppu_artist = { 'DoggFly', 'Inky' },
}

-- Voyager 2
Wormhole.JR_UTILS.Satellite {
  key = 'voyager_2',
  name = 'voyager_2',
  config = { extra = { hand_type = 'Straight Flush', xmult = 0.2 }, },
  pos = { x = 8, y = 0 },
  soul_pos = { x = 8, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.before then
      for _, v in pairs(context.scoring_hand) do
        v.ability.perma_x_mult = (v.ability.perma_x_mult or 1) +
            vars.xmult * G.GAME.jr.satellite_hands[vars.hand_type].level
        SMODS.calculate_effect({ message = localize('k_upgrade_ex') }, v)
      end
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        1 + card.ability.extra.xmult * _level,
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  ppu_artist = { 'DoggFly', 'Inky' },
}

-- Death Egg
Wormhole.JR_UTILS.Satellite {
  key = 'death_egg',
  name = 'death_egg',
  config = { extra = { hand_type = 'Five of a Kind', xmult = 0.2 }, },
  pos = { x = 9, y = 0 },
  soul_pos = { x = 9, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.other_joker then
      return {
        xmult = 1 + G.GAME.jr.satellite_hands[vars.hand_type].level * vars.xmult,
        message_card = context.other_joker
      }
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        1 + card.ability.extra.xmult * _level,
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  ppu_artist = { 'AbelSketch', 'DoggFly', 'Inky' },
}

-- Dawn
Wormhole.JR_UTILS.Satellite {
  key = 'dawn',
  name = 'dawn',
  config = { extra = { hand_type = 'Flush House', xmult = 0.2 }, },
  pos = { x = 10, y = 0 },
  soul_pos = { x = 10, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.individual and context.cardarea == G.play and
    (context.other_card == context.scoring_hand[#context.scoring_hand] or context.other_card == context.scoring_hand[#context.scoring_hand-1]) then
      return {
        xmult = 1 + G.GAME.jr.satellite_hands[vars.hand_type].level * vars.xmult
      }
    end
  end,
  loc_vars = function(self, info_queue, card)
    local _level = G.GAME.jr and G.GAME.jr.satellite_hands[card.ability.extra.hand_type].level or 0
    return {
      vars = {
        _level,
        localize(card.ability.extra.hand_type, 'poker_hands'),
        1 + card.ability.extra.xmult * _level,
        colours = { (_level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, _level)]) }
      }
    }
  end,
  ppu_artist = { 'DoggFly', 'Inky' },
}

-- Manhole Cover
Wormhole.JR_UTILS.Satellite {
  key = 'manhole_cover',
  name = 'manhole_cover',
  config = { extra = { hand_type = 'Flush Five' }, },
  pos = { x = 11, y = 0 },
  soul_pos = { x = 11, y = 1, draw = Wormhole.JR_UTILS.draw_satellite_soul },
  jr_calculate = function(self, context, vars)
    if context.before then
      G.GAME.jr.manhole_cover_targets = {}
      for _ = 1, G.GAME.jr.satellite_hands[vars.hand_type].level do
        local _target = tostring(pseudorandom("worm_jr_manhole_cover", 1, #context.scoring_hand))
        G.GAME.jr.manhole_cover_targets[_target] = (G.GAME.jr.manhole_cover_targets[_target] or 0) + 1
      end
    end

    if context.repetition and context.cardarea == G.play then
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i] == context.other_card then
          if G.GAME.jr.manhole_cover_targets[tostring(i)] then
            return {
              message = localize('k_again_ex'),
              repetitions = G.GAME.jr.manhole_cover_targets[tostring(i)] or 0,
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
  ppu_artist = { 'AbelSketch', 'DoggFly', 'Inky' },
}
