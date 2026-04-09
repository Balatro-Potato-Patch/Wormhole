local atlas = SMODS.Atlas {
    key = "dum_pentapod",
    path = "Dummies/pentapod.png",
    px = 71,
    py = 95
}

local legs_atlas = SMODS.Atlas {
    key = "dum_pentapod_legs",
    path = "Dummies/pentapod.png",
    px = 36,
    py = 60
}

local function default_anim()
    local ret = {}
    for i = 1, 5 do
        ret[#ret + 1] = { theta = math.rad(i * 72), l = 1, phi = math.rad(15), r = 1 }
    end
    return ret
end

SMODS.Joker {
    key = 'dum_pentapod',
    config = { extra = { anim = default_anim() } },
    rarity = 2,
    atlas = atlas.key,
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context) end,
    ppu_coder = { "bagels" },
    ppu_artist = { "bagels" },
    ppu_team = { "dummies" },
    attributes = {}
}

local leg_length_modifier = 40 * 2 / G.TILESCALE / G.TILESIZE
local inner_pivot_offset = { ((36 / 2) - 12) / G.TILESCALE / G.TILESIZE, ((60 / 2) - 8) / G.TILESCALE / G.TILESIZE }
local inner_pivot = { 12 / G.TILESCALE / G.TILESIZE, 8 / G.TILESCALE / G.TILESIZE }

local outer_leg_sprite
local inner_leg_sprite

SMODS.DrawStep {
    key = "dum_pentapod_leg",
    order = -5,
    func = function(self)
        if not self:should_draw_base_shader() then return nil end
        if not (self.config.center.discovered or self.bypass_discovery_center) then return nil end
        if self.config.center.key ~= "j_worm_dum_pentapod" then return nil end

        if not outer_leg_sprite then
            inner_leg_sprite = Sprite(0, 0, 35, 60, G.ASSET_ATLAS[legs_atlas.key], { x = 2, y = 0 })
            outer_leg_sprite = Sprite(0, 0, 35, 60, G.ASSET_ATLAS[legs_atlas.key], { x = 3, y = 0 })
        end

        outer_leg_sprite.role.draw_major = nil
        inner_leg_sprite.role.draw_major = nil

        if not self.ability or not self.ability.extra or not self.ability.extra.anim then
            return
        end


        local v = self.children.center.VT
        local vx = v.x + v.w / 2
        local vy = v.y + v.h / 2

        local root = {
            VT = { x = vx, y = vy, w = 1, h = 1, scale = leg_length_modifier, r = 0 },
            scale_mag = self.children.center
                .scale_mag
        }
        root.T = root.VT

        local leaf = {
            VT = { w = 1, h = 1, scale = leg_length_modifier, r = 0 },
            scale_mag = self.children.center
                .scale_mag
        }
        leaf.T = leaf.VT

        local ninety = math.rad(90)

        Wormhole.dum_pentapod_scale = { 1, 1 }
        Wormhole.dum_pentapod_offset = inner_pivot_offset

        for i, leg in ipairs(self.ability.extra.anim) do
            leaf.VT.x = root.VT.x + math.cos(leg.theta + ninety) * leg.l * leg_length_modifier
            leaf.VT.y = root.VT.y + math.sin(leg.theta + ninety) * leg.l * leg_length_modifier
            Wormhole.dum_pentapod_scale[2] = leg.r
            outer_leg_sprite:draw_shader('dissolve', nil, nil, nil, leaf, 0, leg.theta + leg.phi)
            Wormhole.dum_pentapod_scale[2] = leg.l
            inner_leg_sprite:draw_shader('dissolve', nil, nil, nil, root, 0, leg.theta)

            leg.theta = leg.theta + math.rad(.1 * i)
            leg.phi = leg.theta + math.rad(.1 * (7 - i))
        end

        Wormhole.dum_pentapod_scale = nil
        Wormhole.dum_pentapod_offset = nil
    end,
    conditions = { vortex = false, facing = "front" },
}
