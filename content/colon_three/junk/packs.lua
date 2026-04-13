if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Atlas {
    path = "colon_three/junk_packs.png",
    key = "worm_junk_packs",
    px = 71, py = 95
}

-- type, cost, count, x pos, y pos, choose, size, weight
-- weights are higher as they should appear more often by the nature of them
for _, booster_type in ipairs({
	{ "normal", 4, 2, 0, 0, 2, 3, 1.48 },
	{ "jumbo", 6, 1, 2, 0, 2, 4, 1.48 },
	{ "mega", 8, 1, 3, 0, 3, 5, 1.48/4 },
}) do
	for i = 1, booster_type[3] do
		SMODS.Booster({
			key = "ct_junkset_" .. booster_type[1] .. "_" .. i,
			kind = "JunkSet",
			atlas = "worm_junk_packs",
			pos = { x = booster_type[4] + (i - 1), y = booster_type[5] },
			config = { choose = booster_type[6], extra = booster_type[7], junk_pack = true },
			cost = booster_type[2],
			weight = booster_type[8],
			unlocked = true,
            draw_hand = true,
            ppu_coder = { "notmario" },
            ppu_artist = { "notmario" },
			ppu_team = {":3"},
			create_card = function(self, card)
                return SMODS.create_card {
                    set = "JunkSet",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "junk_pack"
                }
			end,
			loc_vars = function(self, info_queue, card)
				local cfg = (card and card.ability) or self.config
				return { vars = { cfg.choose, cfg.extra }, key = self.key:sub(1, -3) }
			end,
			group_key = "k_junkset_pack",
			ease_background_colour = function(self)
				ease_colour(G.C.DYN_UI.MAIN, HEX("233854"))
				ease_background_colour({ new_colour = HEX("233854"), special_colour = HEX("0a0d28"), contrast = 2 })
			end,
		})
	end
end