SMODS.Voucher {
  key = 'jr_launch_pad',
  atlas = 'worm_jr_vouchers',
  pos = { x = 0, y = 0 },
  config = { extra = { cards_added = 1, kind = { Celestial = true } } },
  unlocked = true,
  discovered = false,
  --TODO: add credits

  calculate = function(self, card, context)
    if context.open_booster and card.ability.extra.kind[context.card.config.center.kind] then
      G.E_MANAGER:add_event(Event {
        func = function()
          for _ = 1, card.ability.extra.cards_added do
            local c = SMODS.create_card {
              set = "worm_jr_satellite",
              area = G.pack_cards
            }
            G.pack_cards:emplace(c)
            G.pack_cards:sort()
          end

          return true
        end
      })

      delay(1)
      G.E_MANAGER:add_event(Event {
        delay = 0.5,
        func = function()
          save_run()
          return true
        end
      })

      return nil, true
    end
  end,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.cards_added
      }
    }
  end,
  ppu_coder = { 'DowFrin' },
  ppu_artist = { 'Blanthos' },
  ppu_team = { 'JuryRigged' },
}

SMODS.Voucher {
  key = 'jr_flyby',
  atlas = 'worm_jr_vouchers',
  pos = { x = 1, y = 0 },
  config = {},
  unlocked = true,
  discovered = false,
  --TODO: add credits
  requires = { 'v_worm_jr_launch_pad' },

  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.ability.set == 'worm_jr_satellite' then
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,

        func = function()
          local _planets = {}
          local _planet

          for k, v in pairs(G.P_CENTER_POOLS.Planet) do
            if Wormhole.JR_UTILS.get_satellite(v.config.hand_type) and (context.consumeable.ability.extra.hand_type == v.config.hand_type) then
              table.insert(_planets, v.key)
            end
          end

          if next(_planets) then
            _planet = pseudorandom_element(_planets, "worm_jr_flyby_planet")
            SMODS.add_card({ key = _planet, edition = 'e_negative' })
          end

          return true
        end
      }))
    end
  end,
  ppu_coder = { 'DowFrin' },
  ppu_artist = { 'Blanthos' },
  ppu_team = { 'JuryRigged' },
}
