SMODS.Booster {
    key = "acme_gadget_normal_1",
    atlas = "ACME_boosters",
    kind = 'Gadget',
    group_key = 'k_worm_gadget_pack',
    select_card = "consumeables",
    weight = 0.40,
    cost = 3,
    pos = { x = 0, y = 0 },
    config = { extra = 2, choose = 1 },
    draw_hand = false,
    unlocked = true,
    discovered = true,
    ppu_artist = { 'RadiationV2' },
    ppu_coder = { 'RadiationV2' },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3),
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = math.random() * 0.1 + 0.1,
            initialize = true,
            lifespan = 0.1 + math.random() * 0.5,
            speed = 0.0,
            padding = 0.1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.GOLD, lighten(G.C.WHITE, 0.5) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "ACME_Gadget",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = false,
        }
    end,
}

SMODS.Booster {
    key = "acme_gadget_normal_2",
    atlas = "ACME_boosters",
    kind = 'Gadget',
    group_key = 'k_worm_gadget_pack',
    select_card = "consumeables",
    weight = 0.40,
    cost = 3,
    pos = { x = 1, y = 0 },
    config = { extra = 2, choose = 1 },
    draw_hand = false,
    unlocked = true,
    discovered = true,
    ppu_artist = { 'RadiationV2' },
    ppu_coder = { 'RadiationV2' },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3),
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = math.random() * 0.1 + 0.1,
            initialize = true,
            lifespan = 0.1 + math.random() * 0.5,
            speed = 0.0,
            padding = 0.1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.GOLD, lighten(G.C.WHITE, 0.5) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "ACME_Gadget",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = false,
        }
    end,
}

SMODS.Booster {
    key = "acme_gadget_jumbo",
    atlas = "ACME_boosters",
    kind = 'Gadget',
    group_key = 'k_worm_gadget_pack',
    select_card = "consumeables",
    weight = 0.15,
    cost = 6,
    pos = { x = 2, y = 0 },
    config = { extra = 4, choose = 1 },
    draw_hand = false,
    unlocked = true,
    ppu_artist = { 'RadiationV2' },
    ppu_coder = { 'RadiationV2' },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key,
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = math.random() * 0.1 + 0.1,
            initialize = true,
            lifespan = 0.1 + math.random() * 0.5,
            speed = 0.0,
            padding = 0.1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.GOLD, lighten(G.C.WHITE, 0.5) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "ACME_Gadget",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = false,
        }
    end,
}

SMODS.Booster {
    key = "acme_gadget_mega",
    atlas = "ACME_boosters",
    kind = 'Gadget',
    group_key = 'k_worm_gadget_pack',
    select_card = "consumeables",
    weight = 0.08,
    cost = 8,
    pos = { x = 3, y = 0 },
    config = { extra = 5, choose = 2 },
    draw_hand = false,
    unlocked = true,
    ppu_artist = { 'RadiationV2' },
    ppu_coder = { 'RadiationV2' },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key,
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = math.random() * 0.1 + 0.1,
            initialize = true,
            lifespan = 0.1 + math.random() * 0.5,
            speed = 0.0,
            padding = 0.1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.GOLD, lighten(G.C.WHITE, 0.5) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "ACME_Gadget",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = false,
        }
    end,
}
