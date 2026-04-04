SMODS.Atlas({
	key = "meow_booster",
    path = "TeamMeow/boosters.png",
    px = 71,
    py = 95
})

SMODS.Booster({
	key = "spacetart_booster_1",
	atlas = "meow_booster",
	pos = { x = 0, y = 0 },
	config = { extra = 2, choose = 1 },
	group_key = "k_worm_meow_spacetart_pack",
    kind = "worm_meow_Spacetart",
	select_card = "consumeables",
	cost = 4,
	weight = 0.6,
	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Spacetart",
            skip_materialize = true
		})
	end,
})

SMODS.Booster({
	key = "spacetart_booster_2",
	atlas = "meow_booster",
	pos = { x = 0, y = 0 },
	config = { extra = 2, choose = 1 },
	group_key = "k_worm_meow_spacetart_pack",
    kind = "worm_meow_Spacetart",
	select_card = "consumeables",
	cost = 4,
	weight = 0.6,
	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Spacetart",
            skip_materialize = true
		})
	end,
})

SMODS.Booster({
	key = "spacetart_booster_jumbo_1",
	atlas = "meow_booster",
	pos = { x = 1, y = 0 },
	config = { extra = 4,  choose = 1 },
	group_key = "k_worm_meow_spacetart_pack",
    kind = "worm_meow_Spacetart",
	select_card = "consumeables",
	cost = 6,
	weight = 0.6,
	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Spacetart",
            skip_materialize = true
		})
	end,
})

SMODS.Booster({
	key = "spacetart_booster_mega_1",
	atlas = "meow_booster",
	pos = { x = 2, y = 0 },
	config = { extra = 4,  choose = 2 },
	group_key = "k_worm_meow_spacetart_pack",
    kind = "Spacetart",
	select_card = "consumeables",
	cost = 8,
	weight = 0.09,
	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Spacetart",
            skip_materialize = true
		})
	end,
})


-- Zodicats


SMODS.Booster({
	key = "zodicat_booster_1",
	pos = { x = 0, y = 0 },
	config = { extra = 3, choose = 1 },
	group_key = "k_worm_meow_Zodicat_pack",
    kind = "worm_meow_Zodicat",
	draw_hand = true,
    cost = 4,
	weight = 0.9,
	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Zodicat",
            skip_materialize = true
		})
	end,
})

SMODS.Booster({
	key = "zodicat_booster_2",
	pos = { x = 1, y = 0 },
	config = { extra = 3, choose = 1 },
	group_key = "k_worm_meow_Zodicat_pack",
    kind = "worm_meow_Zodicat",
	draw_hand = true,
    cost = 4,
	weight = 0.9,
	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Zodicat",
            skip_materialize = true
		})
	end,
})

SMODS.Booster({
	key = "zodicat_booster_jumbo_1",
	pos = { x = 2, y = 0 },
	config = { extra = 5, choose = 1 },
	group_key = "k_worm_meow_Zodicat_pack",
    kind = "worm_meow_Zodicat",
	draw_hand = true,
    cost = 6,
	weight = 0.9,
	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Zodicat",
            skip_materialize = true
		})
	end,
})

SMODS.Booster({
	key = "zodicat_booster_mega_1",
	pos = { x = 3, y = 0 },
	config = { extra = 5, choose = 2 },
	group_key = "k_worm_meow_Zodicat_pack",
    kind = "worm_meow_Zodicat",
	draw_hand = true,
    cost = 8,
	weight = 0.24,
	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Zodicat",
            skip_materialize = true
		})
	end,
})