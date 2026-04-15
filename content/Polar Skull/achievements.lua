SMODS.Atlas({
	key = "polarskull_achievements",
	path = "Polar Skull/achievements.png",
	px = 63,
	py = 63,
})

SMODS.Achievement{
	key = "polarskull_dandori",
	atlas = "polarskull_achievements",
	pos = {x = 0, y = 0},
	hidden_pos = {x = 1, y = 0},
	hidden_text = true,
	unlock_condition = function(self, args)
		return args.type == "j_worm_polarskull_olimar"
	end
}

SMODS.Achievement{
	key = "polarskull_sschamp",
	atlas = "polarskull_achievements",
	pos = {x = 0, y = 0},
	hidden_pos = {x = 1, y = 0},
    bypass_all_unlocked = true,
	unlock_condition = function(self, args)
		return args.type == "win_stake" and get_deck_win_stake("b_worm_polarskull_space_station") >= 8
	end
}

SMODS.Achievement{
	key = "polarskull_completion",
	atlas = "polarskull_achievements",
	pos = {x = 0, y = 0},
	hidden_pos = {x = 1, y = 0},
	unlock_condition = function(self, args)
		if args.type == "discover_amount" then
			for _, tbl in pairs(G.P_CENTERS) do
				if tbl.original_mod and tbl.original_mod.id == "Wormhole" and tbl.ppu_team and tbl.ppu_team[1] == "polar_skull" and not tbl.discovered then
					return false
				end
			end
			return true
		end
	end
}
