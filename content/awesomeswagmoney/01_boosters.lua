--contains boosters and SMODS.ConsumableType

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

local wormholes = {
    { type = "normal_1", extra = 2, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 4 },
    { type = "normal_2", extra = 2, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 4 },
    { type = "jumbo_1", extra = 4, choose = 1, pos = { x = 0, y = 0 }, weight = 0.8, cost = 6 },
    { type = "mega_1", extra = 4, choose = 2, pos = { x = 0, y = 0 }, weight = 0.2, cost = 8 },
}

for _, t in ipairs(wormholes) do
    SMODS.Booster {
        key = "wormhole_"..t.type,
        weight = t.weight,
        kind = "worm_Ultrawormhole",
        cost = t.cost,
        pos = t.pos,
        config = { extra = t.extra, choose = t.choose },
        group_key = "k_worm_ultrawormhole"
    }
end