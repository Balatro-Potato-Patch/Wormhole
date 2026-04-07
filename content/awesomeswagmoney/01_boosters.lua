--contains boosters and SMODS.ConsumableType

SMODS.Atlas({key = "asm_ultrawormhole_sm", path = "ultrawormholesmall.png", px = 83, py = 99, fps = 7, frames = 3, atlas_table = "ANIMATION_ATLAS"}):register()
SMODS.Atlas({key = "asm_ultrawormhole_bg", path = "ultrawormholebig.png", px = 99, py = 99, fps = 7, frames = 3, atlas_table = "ANIMATION_ATLAS"}):register()
SMODS.Atlas({key = "asm_ultrawormhole_bgr", path = "ultrawormholebigger.png", px = 102, py = 99, fps = 7, frames = 3, atlas_table = "ANIMATION_ATLAS"}):register()

SMODS.ConsumableType{
    key = "worm_ultrabeast",
    primary_colour = HEX("345678"),
    secondary_colour = HEX("3e36c9"),
    default = "c_fool" --CHANGE LATER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}

local wormhole_create_card = function (self, card, i)
    return {
        set = "worm_ultrabeast",
        soulable = true,
        skip_materialize = true,
        area = G.pack_cards,
        key_append = "worm_wormholepack",
    }
end

local wormhole_particles = function (self)
    G.booster_pack_sparkles = Particles(1, 1, 0, 0, { --someone who knows more about particles can mess with this
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.BLUE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.RED, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
end

local wormhole_colour = function (self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.worm_ultrabeast)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.worm_ultrabeast, special_colour = G.C.BLACK, contrast = 2 })
end

local wormholes = { --im so fucking smart
    { type = "normal_1", atlas = "worm_asm_ultrawormhole_sm", display_size = { w = 83, h = 99 },  extra = 2, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 4 },
    -- { type = "normal_2", extra = 2, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 4 },
    { type = "jumbo_1", atlas = "worm_asm_ultrawormhole_bg", display_size = { w = 99, h = 99 }, extra = 4, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 6 },
    { type = "mega_1", atlas = "worm_asm_ultrawormhole_bgr", display_size = { w = 102, h = 99 }, extra = 4, choose = 2, pos = { x = 0, y = 0 }, weight = 0.2, cost = 8 },
}

for _, t in ipairs(wormholes) do
    SMODS.Booster {
        key = "wormhole_"..t.type,
        weight = t.weight,
        kind = "worm_Ultrawormhole",
        cost = t.cost,
        atlas = t.atlas,
        display_size = t.display_size,
        select_card = 'consumeables',
        disable_shine = true,
        config = { extra = t.extra, choose = t.choose },
        group_key = "k_worm_ultrawormhole",
        --draw_hand = true,
        loc_vars = function (self, info_queue, card)
            local cfg = (card and card.ability) or self.config or {}
            return {
                vars = { cfg.choose, cfg.extra },
                key = self.key:sub(1, -3),
            }
        end,
        ease_background_colour = wormhole_colour,
        particles = wormhole_particles,
        create_card = wormhole_create_card,
    }
end