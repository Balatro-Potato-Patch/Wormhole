PotatoPatchUtils.Team({
  name = "JuryRigged",
  colour = HEX('B1B2AE'),
  loc = true,
  --
  calculate = function(self, context)
    if context.before then
      G.GAME.jr.curr_hand = context.scoring_name
    end

    if G.GAME.jr and G.GAME.jr.curr_hand then
      for _, v in pairs(Wormhole.JR_UTILS.Satellites) do
        local _hand = Wormhole.JR_UTILS.get_hand(v.name)
        if G.GAME.jr.curr_hand == _hand and (G.GAME.jr.satellite_hands[_hand].level > 0) then
          --print("TRIGERRED " .. v.name)
          return v.calculate(self, context, v.vars)
        end
      end
    end

    if context.end_of_round then G.GAME.jr.curr_hand = nil end
  end,
  credit_rows = {4,4},
})
