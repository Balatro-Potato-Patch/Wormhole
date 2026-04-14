SMODS.Back {
	key = "jr_colonist",
  unlocked = true,
  discovered = true,
	config = { worm_jr_satellite_rate = 2, voucher = "v_worm_jr_launch_pad" },
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
	pos = { x = 0, y = 0 },
  atlas = 'worm_jr_Backs',
  apply = function(self)
    G.GAME.worm_jr_satellite_rate = self.config.worm_jr_satellite_rate
  end,
  ppu_coder = { 'Maelmc' },
  ppu_artist = { '' },
  ppu_team = { 'JuryRigged' },
}