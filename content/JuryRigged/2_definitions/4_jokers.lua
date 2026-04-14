-- Transponder
SMODS.Joker {
  key = "jr_transponder",
  config = {
    extra = {
      a_xmult = 0.3
    }
  },
  rarity = 2,
  pos = { x = 0, y = 0 },
  atlas = "worm_jr_jokers",
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  in_pool = function(self, args)
    return G.GAME.jr.transponder_ct > 0
  end,

  loc_vars = function(self, info_queue, card)
    Wormhole.JR_UTILS.update_transponder()
    local xmult = 1 + ((G.GAME.jr and G.GAME.jr.transponder_ct or 0) * card.ability.extra.a_xmult)

    return {
      vars = {
        card.ability.extra.a_xmult,
        xmult
      }
    }
  end,

  calculate = function(self, card, context)
    -- Cosmetic upgrade message to make keeping track of scaling easier
    if context.using_consumeable and context.consumeable.ability.set == 'worm_jr_satellite' then
      if G.GAME.jr.satellite_hands[context.consumeable.ability.extra.hand_type].level == 1 then
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end
    end

    if context.joker_main then
      Wormhole.JR_UTILS.update_transponder()
      local xmult = 1 + (G.GAME.jr.transponder_ct * card.ability.extra.a_xmult)

      return {
        xmult = xmult
      }
    end
  end
}

SMODS.Joker {
  key = "jr_nasa",
  config = {},
  rarity = 2,
  pos = { x = 1, y = 0 },
  atlas = "worm_jr_jokers",
  cost = 6,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.blueprint then return end

    if context.end_of_round and context.main_eval and G.GAME.blind.boss then
      SMODS.add_card { key = "sat_worm_" .. Wormhole.JR_UTILS.get_satellite(G.GAME.jr.curr_hand), area = G.consumeables }

      return {
        message = localize('worm_jr_plus_satellite'),
        -- For some reason our pink looks extremely bright when used as the background for a message so we use legendary here since it looks similar enough
        colour = G.C.RARITY.Legendary
      }
    end
  end
}
