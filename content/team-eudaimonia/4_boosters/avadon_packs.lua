SMODS.Atlas {
    key = "euda_avadonpacks",
    px = 71,
    py = 95,
    path = 'team-eudaimonia/boosters_ava.png',
}

SMODS.Sound{
    key = "euda_music_avadon",
    path = "team-eudaimonia/music_avadon.ogg",
    volume = 2.3,
    select_music_track = function(self)
        local booster = G.pack_cards and G.pack_cards.cards and SMODS.OPENED_BOOSTER
        if booster and booster.config.center_key:find('p_worm_euda_avadon') then
            return true
        end
    end
}

Wormhole.EUDA_Avadon = SMODS.Booster:extend{
    ppu_artist = {"cosmeggo","LasagnaFelidae","iamarta"},
    ppu_team = {"TeamEudaimonia"},
    kind = "euda_Avadon",
    atlas = "worm_euda_avadonpacks",
    group_key = "k_euda_avadon_pack",
    draw_hand = false,
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


Wormhole.EUDA_Avadon {
    key = "euda_avadon_normal_1",
    weight = 0.2,
    pos = {x=0, y=0},
    cost = 8,
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3)
        }
    end,
    
}

Wormhole.EUDA_Avadon {
    key = "euda_avadon_normal_2",
    weight = 0.2,
    pos = {x=1, y=0},
    cost = 8,
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3)
        }
    end,
}

Wormhole.EUDA_Avadon {
    key = "euda_avadon_jumbo",
    weight = 0.1,
    pos = {x=2, y=0},
    cost = 10,
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,

}

Wormhole.EUDA_Avadon {
    key = "euda_avadon_mega",
    weight = 0.04,
    pos = {x=3, y=0},
    cost = 12,
    config = { extra = 3, choose = 2 },
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
}
