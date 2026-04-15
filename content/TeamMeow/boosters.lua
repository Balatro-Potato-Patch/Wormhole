SMODS.Atlas({
	key = "meow_booster",
    path = "TeamMeow/boosters.png",
    px = 71,
    py = 95
})
SMODS.Atlas({
	key = "meow_booster_zodicat",
	path = "TeamMeow/zodicat_boosters.png",
	px = 71,
	py = 95
})
SMODS.Sound({
    key = "spacetart_booster_pack_music",
    path = "TeamMeow/spacetartMus.ogg",
	sync = {
        ['music1'] = true,
        ['music2'] = true,
        ['music3'] = true,
        ['music4'] = true,
        ['music5'] = true,
	},
    select_music_track = function(self) 
        return G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'worm_meow_Spacetart' and 100 or nil
    end,
	pitch = 1
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

	ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = HEX("5b4bf0") })
    end,

	particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { 
				lighten(HEX("fb2943"), 0.15), -- Strawberry
				lighten(HEX("d47e30"), 0.15), -- Cinnamon
				lighten(HEX("fff700"), 0.15), -- Lemon
				lighten(HEX("98fbcb"), 0.15), -- Mint
				lighten(HEX("4f86f7"), 0.15), -- Blueberry
				lighten(HEX("4d0135"), 0.15) -- Blackberry
			},
            fill = true
        })
    end,

	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Spacetart",
            skip_materialize = true
		})
	end,
	ppu_team = { "meow" },
	ppu_coder = { "revo" },
	ppu_artist = { "incognito" },
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

	ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = HEX("5b4bf0") })
    end,

	particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { 
				lighten(HEX("fb2943"), 0.15), -- Strawberry
				lighten(HEX("d47e30"), 0.15), -- Cinnamon
				lighten(HEX("fff700"), 0.15), -- Lemon
				lighten(HEX("98fbcb"), 0.15), -- Mint
				lighten(HEX("4f86f7"), 0.15), -- Blueberry
				lighten(HEX("4d0135"), 0.15) -- Blackberry
			},
            fill = true
        })
    end,

	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Spacetart",
            skip_materialize = true
		})
	end,
	ppu_team = { "meow" },
	ppu_coder = { "revo" },
	ppu_artist = { "incognito" },
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

	ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = HEX("5b4bf0") })
    end,

	particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { 
				lighten(HEX("fb2943"), 0.15), -- Strawberry
				lighten(HEX("d47e30"), 0.15), -- Cinnamon
				lighten(HEX("fff700"), 0.15), -- Lemon
				lighten(HEX("98fbcb"), 0.15), -- Mint
				lighten(HEX("4f86f7"), 0.15), -- Blueberry
				lighten(HEX("4d0135"), 0.15) -- Blackberry
			},
            fill = true
        })
    end,

	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Spacetart",
            skip_materialize = true
		})
	end,
	ppu_team = { "meow" },
	ppu_coder = { "revo" },
	ppu_artist = { "incognito" },
})

SMODS.Booster({
	key = "spacetart_booster_mega_1",
	atlas = "meow_booster",
	pos = { x = 2, y = 0 },
	config = { extra = 4,  choose = 2 },
	group_key = "k_worm_meow_spacetart_pack",
    kind = "worm_meow_Spacetart",
	select_card = "consumeables",
	cost = 8,
	weight = 0.09,

	ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = HEX("5b4bf0") })
    end,

	particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { 
				lighten(HEX("fb2943"), 0.15), -- Strawberry
				lighten(HEX("d47e30"), 0.15), -- Cinnamon
				lighten(HEX("fff700"), 0.15), -- Lemon
				lighten(HEX("98fbcb"), 0.15), -- Mint
				lighten(HEX("4f86f7"), 0.15), -- Blueberry
				lighten(HEX("4d0135"), 0.15) -- Blackberry
			},
            fill = true
        })
    end,

	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Spacetart",
            skip_materialize = true
		})
	end,
	ppu_team = { "meow" },
	ppu_coder = { "revo" },
	ppu_artist = { "incognito" },
})


-- Zodicats

SMODS.Sound({
    key = "zodicat_booster_pack_music",
    path = "TeamMeow/zodiacMus.ogg",
	sync = {
        ['music1'] = true,
        ['music2'] = true,
        ['music3'] = true,
        ['music4'] = true,
        ['music5'] = true,
	},
    select_music_track = function(self) 
        return G.booster_pack and not G.booster_pack.REMOVED and SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.kind == 'worm_meow_Zodicat' and 100 or nil
    end,
	pitch = 1
})

SMODS.Booster({
	key = "zodicat_booster_1",
	atlas = "meow_booster_zodicat",
	pos = { x = 0, y = 0 },
	config = { extra = 3, choose = 1 },
	group_key = "k_worm_meow_Zodicat_pack",
    kind = "worm_meow_Zodicat",
	draw_hand = true,
    cost = 4,
	weight = 0.9,

	ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = HEX("A7D6E0") })
    end,

	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Zodicat",
            skip_materialize = true
		})
	end,
	ppu_team = { "meow" },
	ppu_coder = { "revo" },
	ppu_artist = { "gappie" },
})

SMODS.Booster({
	key = "zodicat_booster_2",
	atlas = "meow_booster_zodicat",
	pos = { x = 1, y = 0 },
	config = { extra = 3, choose = 1 },
	group_key = "k_worm_meow_Zodicat_pack",
    kind = "worm_meow_Zodicat",
	draw_hand = true,
    cost = 4,
	weight = 0.9,

	ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = HEX("A7D6E0") })
    end,

	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Zodicat",
            skip_materialize = true
		})
	end,
	ppu_team = { "meow" },
	ppu_coder = { "revo" },
	ppu_artist = { "gappie" },
})

SMODS.Booster({
	key = "zodicat_booster_jumbo_1",
	atlas = "meow_booster_zodicat",
	pos = { x = 2, y = 0 },
	config = { extra = 5, choose = 1 },
	group_key = "k_worm_meow_Zodicat_pack",
    kind = "worm_meow_Zodicat",
	draw_hand = true,
    cost = 6,
	weight = 0.9,

	ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = HEX("A7D6E0") })
    end,

	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Zodicat",
            skip_materialize = true
		})
	end,
	ppu_team = { "meow" },
	ppu_coder = { "revo" },
	ppu_artist = { "gappie" },
})

SMODS.Booster({
	key = "zodicat_booster_mega_1",
	atlas = "meow_booster_zodicat",
	pos = { x = 3, y = 0 },
	config = { extra = 5, choose = 2 },
	group_key = "k_worm_meow_Zodicat_pack",
    kind = "worm_meow_Zodicat",
	draw_hand = true,
    cost = 8,
	weight = 0.24,

	ease_background_colour = function(self)
        ease_background_colour({ new_colour = G.C.CLEAR, special_colour = HEX("A7D6E0") })
    end,

	create_card = function(self, card, i)
		return SMODS.create_card({
			set = "worm_meow_Zodicat",
            skip_materialize = true
		})
	end,
	ppu_team = { "meow" },
	ppu_coder = { "revo" },
	ppu_artist = { "gappie" },
})