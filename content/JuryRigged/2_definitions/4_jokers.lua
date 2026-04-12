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
  cost = 7,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  in_pool = function(self, args)
    return G.GAME.jr.transponder_ct > 0
  end,

  loc_vars = function(self, info_queue, card)
    Wormhole.JR_UTILS.update_transponder()
    local xmult = 1 + (G.GAME.jr.transponder_ct * card.ability.extra.a_xmult)

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


Wormhole.JR_UTILS.update_transponder = function()
  local count = 0
  for k, v in pairs(G.GAME.jr.satellite_hands) do
    if v.level > 0 then
      count = count + 1
    end
  end

  G.GAME.jr.transponder_ct = count
end
