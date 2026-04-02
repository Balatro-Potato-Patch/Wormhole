SMODS.Booster{
	key = "tlr_const_normal_1",
	weight = 1,
	kind = "worm_tlr_constellation",
	cost = 4,
	pos = {x=0, y=0},
	atlas = "tlr_const",
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
	ppu_coder = {"Foo54"},
	ppu_artists = {"None yet"}
}

SMODS.Booster{
	key = "tlr_const_normal_2",
	weight = 1,
	kind = "worm_tlr_constellation",
	cost = 4,
	pos = {x=1, y=0},
	atlas = "tlr_const",
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
	ppu_coder = {"Foo54"},
	ppu_artists = {"None yet"}
}

SMODS.Booster{
	key = "tlr_const_jumbo_1",
	weight = 1,
	kind = "worm_tlr_constellation",
	cost = 6,
	pos = {x=2, y=0},
	atlas = "tlr_const",
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
	ppu_coder = {"Foo54"},
	ppu_artists = {"None yet"}
}

SMODS.Booster{
	key = "tlr_const_mega_1",
	weight = 0.25,
	kind = "worm_tlr_constellation",
	cost = 8,
	pos = {x=3, y=0},
	atlas = "tlr_const",
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
	ppu_coder = {"Foo54"},
	ppu_artists = {"None yet"}
}
