SMODS.Booster{
	key = "tlr_const_normal_1",
	weight = 1,
	kind = "worm_tlr_constellation",
	cost = 4,
	pos = {x=0, y=0},
	atlas = "tlr_booster",
	group_key = "k_tlr_const_pack",
	config = {extra = 3, choose = 1},
	loc_vars = function(self, info_queue, card)
		local cfg = (card and card.ability) or self.config
		return {
			vars = { cfg.choose, cfg.extra, colours = {SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour}},
			key = self.key:sub(1, -3)
		}
	end,
	ease_background_colour = WORM_TLR.ease_background_colour_pack,
	particles = WORM_TLR.particles,
	create_card = function(self, card, i)
		return {
			set = "worm_tlr_constellation",
			area = G.pack_cards,
			skip_materialize = true,
			soulable = true,
		}
	end,
	ppu_team = {"TheLastResort"},
	ppu_artist = {"Aura2247"},
	ppu_coder = {"Foo54"}
}

SMODS.Booster{
	key = "tlr_const_normal_2",
	weight = 1,
	kind = "worm_tlr_constellation",
	cost = 4,
	pos = {x=1, y=0},
	atlas = "tlr_booster",
	group_key = "k_tlr_const_pack",
	config = {extra = 3, choose = 1},
	loc_vars = function(self, info_queue, card)
		local cfg = (card and card.ability) or self.config
		return {
			vars = { cfg.choose, cfg.extra, colours = {SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour}},
			key = self.key:sub(1, -3)
		}
	end,
	ease_background_colour = WORM_TLR.ease_background_colour_pack,
	particles = WORM_TLR.particles,
	create_card = function(self, card, i)
		return {
			set = "worm_tlr_constellation",
			area = G.pack_cards,
			skip_materialize = true,
			soulable = true,
		}
	end,
	ppu_team = {"TheLastResort"},
	ppu_artist = {"Aura2247"},
	ppu_coder = {"Foo54"}
}

SMODS.Booster{
	key = "tlr_const_jumbo_1",
	weight = 1,
	kind = "worm_tlr_constellation",
	cost = 6,
	pos = {x=2, y=0},
	atlas = "tlr_booster",
	group_key = "k_tlr_const_pack",
	config = {extra = 5, choose = 1},
	loc_vars = function(self, info_queue, card)
		local cfg = (card and card.ability) or self.config
		return {
			vars = { cfg.choose, cfg.extra, colours = {SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour}},
			key = self.key:sub(1, -3)
		}
	end,
	ease_background_colour = WORM_TLR.ease_background_colour_pack,
	particles = WORM_TLR.particles,
	create_card = function(self, card, i)
		return {
			set = "worm_tlr_constellation",
			area = G.pack_cards,
			skip_materialize = true,
			soulable = true,
		}
	end,
	ppu_team = {"TheLastResort"},
	ppu_artist = {"Aura2247"},
	ppu_coder = {"Foo54"}
}

SMODS.Booster{
	key = "tlr_const_mega_1",
	weight = 0.25,
	kind = "worm_tlr_constellation",
	cost = 8,
	pos = {x=3, y=0},
	atlas = "tlr_booster",
	group_key = "k_tlr_const_pack",
	config = {extra = 5, choose = 2},
	loc_vars = function(self, info_queue, card)
		local cfg = (card and card.ability) or self.config
		return {
			vars = { cfg.choose, cfg.extra, colours = {SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour}},
			key = self.key:sub(1, -3)
		}
	end,
	ease_background_colour = WORM_TLR.ease_background_colour_pack,
	particles = WORM_TLR.particles,
	create_card = function(self, card, i)
		return {
			set = "worm_tlr_constellation",
			area = G.pack_cards,
			skip_materialize = true,
			soulable = true,
		}
	end,
	ppu_team = {"TheLastResort"},
	ppu_artist = {"Aura2247"},
	ppu_coder = {"Foo54"}
}

SMODS.Sound{
	key = "tlr_const_pack_music",
	path = "TheLastResort/booster.ogg",
	sync = {
		['music1'] = true,
		['music2'] = true,
		['music3'] = true,
		['music4'] = true,
		['music5'] = true,
	},
	select_music_track = function()
    return G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'worm_tlr_constellation' and 100 or nil
	end
}