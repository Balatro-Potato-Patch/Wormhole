SMODS.Atlas({
	key = "jtem2_black_hole_deck",
	path = "Jtem 2/decks/black_hole_deck.png",
	px = 71,
	py = 95,
})

SMODS.Back({
	key = "jtem2_black_hole_deck",
	atlas = "jtem2_black_hole_deck",
	ppu_team = { "jtem2" },
	ppu_artist = { "aikoyori" },
	ppu_coder = { "aikoyori" },
	config = { tarot_rate = 0, spectral_rate = 4, consumables = { "c_worm_jtem2_kilonovae", "c_worm_jtem2_kilonovae" } },
	unlocked = false,
	apply = function(self, back)
		G.GAME.tarot_rate = self.config.tarot_rate
	end,
	loc_vars = function(self, info_queue, back)
		return {
			vars = {
				self.config.tarot_rate,
				self.config.spectral_rate,
				self.config.consumables[1],
				self.config.consumables[2],
			},
		}
	end,
})
