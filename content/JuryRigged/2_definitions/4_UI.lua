Wormhole.JR_UTILS.create_UIBox_current_hand_row = function(handname, simple)
  local key = 'sat_worm_' .. Wormhole.JR_UTILS.get_satellite(handname)

  return (not in_collection or SMODS.is_poker_hand_visible(handname)) and
      (not simple and
        { n = G.UIT.R, config = { align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), emboss = 0.05, hover = true, force_focus = true, detailed_tooltip = G.P_CENTERS[key] }, nodes = {
          { n = G.UIT.C, config = { align = "cl", padding = 0, minw = 5 }, nodes = {
            { n = G.UIT.C, config = { align = "cm", padding = 0.01, r = 0.1, colour = G.C.HAND_LEVELS[math.min(7, G.GAME.jr.satellite_hands[handname].level)], minw = 1.5, outline = 0.8, outline_colour = G.C.WHITE }, nodes = {
              { n = G.UIT.T, config = { text = localize('k_level_prefix') .. G.GAME.jr.satellite_hands[handname].level, scale = 0.5, colour = G.C.UI.TEXT_DARK } }
            } },
            { n = G.UIT.C, config = { align = "cm", minw = 4.5, maxw = 4.5 }, nodes = {
              { n = G.UIT.T, config = { text = ' ' .. localize(handname, 'poker_hands'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } }
            } }
          } },
          { n = G.UIT.C, config = { align = "cm", padding = 0.05, colour = G.C.BLACK, r = 0.1, minw = 4.5, maxw = 4.5 }, nodes = {
            { n = G.UIT.T, config = { text = ' ' .. Wormhole.JR_UTILS.localize_satellite(handname) .. ' ', scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } } } },
          { n = G.UIT.C, config = { align = "cm" } },
        } })
      or nil
end

Wormhole.JR_UTILS.create_UIBox_current_satellites = function(simple)
  local names = {
    "Flush Five",
    "Five of a Kind",
    "Straight Flush",
    "Four of a Kind",
    "Full House",
    "Flush",
    "Straight",
    "Three of a Kind",
    "Two Pair",
    "Pair",
    "High Card"
  }
  local hands = {}

  for i, hand in ipairs(names) do
    if Wormhole.JR_UTILS.get_satellite(hand) then
      table.insert(hands, Wormhole.JR_UTILS.create_UIBox_current_hand_row(hand, simple))
    end
  end

  local t = {
    n = G.UIT.ROOT,
    config = { align = "cm", minw = 3, padding = 0.1, r = 0.1, colour = G.C.CLEAR },
    nodes = {
      {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.04 },
        nodes =
            hands
      },
    }
  }

  return t
end
