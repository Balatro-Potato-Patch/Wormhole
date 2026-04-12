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
  end
}
