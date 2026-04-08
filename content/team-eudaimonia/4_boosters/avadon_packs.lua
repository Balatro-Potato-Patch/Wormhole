SMODS.Booster {
    key = "euda_avadon_normal_1",
    weight = 0.2,
    kind = "euda_Avadon",
    cost = 4,
    config = { extra = 1, choose = 1 },
    group_key = "k_euda_avadon_pack",
    draw_hand = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3)
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.euda_Fate)
        ease_background_colour({ new_colour = G.C.SET.euda_Fate, special_colour = G.C.SECONDARY_SET.euda_Fate, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1.3,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.SET.euda_Fate, lighten(G.C.SECONDARY_SET.euda_Fate, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "euda_Fate",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "ava"
        }
    end,
}

SMODS.Booster {
    key = "euda_avadon_normal_2",
    weight = 0.2,
    kind = "euda_Avadon",
    cost = 4,
    config = { extra = 1, choose = 1 },
    group_key = "k_euda_avadon_pack",
    draw_hand = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3)
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.euda_Fate)
        ease_background_colour({ new_colour = G.C.SET.euda_Fate, special_colour = G.C.SECONDARY_SET.euda_Fate, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1.3,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.SET.euda_Fate, lighten(G.C.SECONDARY_SET.euda_Fate, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "euda_Fate",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "ava"
        }
    end,
}

SMODS.Booster {
    key = "euda_avadon_jumbo",
    weight = 0.2,
    kind = "euda_Avadon",
    cost = 6,
    config = { extra = 2, choose = 1 },
    group_key = "k_euda_avadon_pack",
    draw_hand = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.euda_Fate)
        ease_background_colour({ new_colour = G.C.SET.euda_Fate, special_colour = G.C.SECONDARY_SET.euda_Fate, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1.3,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.SET.euda_Fate, lighten(G.C.SECONDARY_SET.euda_Fate, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "euda_Fate",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "ava"
        }
    end,
}

SMODS.Booster {
    key = "euda_avadon_mega",
    weight = 0.04,
    kind = "euda_Avadon",
    cost = 8,
    config = { extra = 2, choose = 2 },
    group_key = "k_euda_avadon_pack",
    draw_hand = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.euda_Fate)
        ease_background_colour({ new_colour = G.C.SET.euda_Fate, special_colour = G.C.SECONDARY_SET.euda_Fate, contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1.3,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.SET.euda_Fate, lighten(G.C.SECONDARY_SET.euda_Fate, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "euda_Fate",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "ava"
        }
    end,
}