SMODS.Atlas {
    key = "polarskull_boosters",
    path = "Polar Skull/boosters.png",
    px = 71,
    py = 95,
}

SMODS.Sound({
	key = "polarskull_rocketpack_music",
	path = "polarskull_rocketpack_music.ogg",
	pitch = 1,
	volume = 1,
	select_music_track = function(self)
		if G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER.config.center.kind == "polarskull_Rocket" then
			return 10
		end
	end
})

SMODS.Booster({
    key = 'rocket_normal_1',
    group_key = 'k_polarskull_rocket_pack',
    kind = 'polarskull_Rocket',
    cost = 4,
    atlas = 'polarskull_boosters',
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    select_card = 'consumeables',
	ppu_artist = {"comykel"},
	ppu_coder = {"cloudzxiii"},
	ppu_team = {"polar_skull"},

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    create_card = function(self, card)
        return {
            set = "polarskull_rocket",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        }
    end,

    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
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
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
})

SMODS.Booster({
    key = 'rocket_normal_2',
    group_key = 'k_polarskull_rocket_pack',
    kind = 'polarskull_Rocket',
    cost = 4,
    atlas = 'polarskull_boosters',
    pos = { x = 1, y = 0 },
    config = { extra = 3, choose = 1 },
    select_card = 'consumeables',
	ppu_artist = {"comykel"},
	ppu_coder = {"cloudzxiii"},
	ppu_team = {"polar_skull"},

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    create_card = function(self, card)
        return {
            set = "polarskull_rocket",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        }
    end,

    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
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
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
})

SMODS.Booster({
    key = 'rocket_jumbo',
    group_key = 'k_polarskull_rocket_pack',
    kind = 'polarskull_Rocket',
    cost = 6,
    atlas = 'polarskull_boosters',
    pos = { x = 2, y = 0 },
    config = { extra = 5, choose = 1 },
    select_card = 'consumeables',
	ppu_artist = {"comykel"},
	ppu_coder = {"cloudzxiii"},
	ppu_team = {"polar_skull"},

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    create_card = function(self, card)
        return {
            set = "polarskull_rocket",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        }
    end,

    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
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
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
})

SMODS.Booster({
    key = 'rocket_mega',
    group_key = 'k_polarskull_rocket_pack',
    kind = 'polarskull_Rocket',
    cost = 8,
    atlas = 'polarskull_boosters',
    pos = { x = 3, y = 0 },
    config = { extra = 5, choose = 2 },
    select_card = 'consumeables',
	ppu_artist = {"comykel"},
	ppu_coder = {"cloudzxiii"},
	ppu_team = {"polar_skull"},

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    create_card = function(self, card)
        return {
            set = "polarskull_rocket",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        }
    end,

    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
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
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
})
