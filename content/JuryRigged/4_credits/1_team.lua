PotatoPatchUtils.Team({
  name = "JuryRigged",
  colour = HEX('888A85'),
  loc = true,
  --
  calculate = function(self, context)
    for k, v in ipairs(Wormhole.JR_UTILS.Satellites) do
      if context.scoring_name == Wormhole.JR_UTILS.get_hand(v) and (G.GAME.jr.satellite_hands[Wormhole.JR_UTILS.get_hand(v)].level > 0) then
        print("TRIGERRED " .. v)
      end
    end
  end
})
