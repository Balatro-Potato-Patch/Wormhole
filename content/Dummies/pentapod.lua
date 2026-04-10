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

local function solve_legs(anim, ox, oy)
    local legs = {}
    for _, foot in ipairs(anim.feet_interpolated) do
        local tip_x = foot.y - oy + 0.5
        local tip_y = -foot.x + ox - 0.5

        local mid_x = tip_x / 2
        local mid_y = tip_y / 2

        tip_x = tip_x + 0.1
        mid_x = mid_x - 0.2

        tip_x = tip_x - mid_x
        tip_y = tip_y - mid_y

        local leg = {
            theta = math.atan2(mid_y, mid_x),
            l = math.sqrt(mid_x * mid_x + mid_y * mid_y),
            r = math.sqrt(tip_x * tip_x + tip_y * tip_y)
        }

        leg.phi = math.atan2(mid_x * tip_y - mid_y * tip_x, tip_x * mid_x + tip_y * mid_y)

        legs[#legs + 1] = leg
    end
    return legs
end

function ease_in_out_qaud(x)
    return x < 0.5 and 2 * x * x or 1 - math.pow(-2 * x + 2, 2) / 2;
end

local step_time = 0.24
local spin_speed = math.rad(5)

function ease(table, key, finish)
    local start = table[key]
    table[key] = 0

    local ev = Event {
        trigger = 'ease',
        blocking = false,
        blockable = false,
        ref_table = table,
        ref_value = key,
        ease_to = 1,
        delay = step_time,
        timer = 'REAL',
        func = function(t)
            t = ease_in_out_qaud(t)
            return finish * t + start * (1 - t)
        end
    }
    G.E_MANAGER:add_event(ev)
    ev:handle {}
end

function no_moving(card, recurse)
    if card and
        card.ability and
        card.ability.extra and
        card.ability.extra.anim and
        card.ability.extra.anim.feet_interpolated then
        for _, v in ipairs(card.ability.extra.anim.feet_interpolated) do
            v.moving = false
        end
    end

    if not recurse then
        G.E_MANAGER:add_event(Event {
            func = function()
                no_moving(card, true)
                return true
            end
        })
    end
end

SMODS.Joker {
    key = 'dum_pentapod',
    config = { extra = { x_mult = 5, cards = 5 } },
    rarity = 3,
    atlas = atlas.key,
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    ppu_coder = { "bagels" },
    ppu_artist = { "bagels" },
    ppu_team = { "dummies" },
    attributes = {"alien"},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.cards } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.scoring_hand == card.ability.extra.cards then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    update = function(self, card, dt)
        if not card.ability.extra.anim then
            card.ability.extra.anim = { feet_targets = {}, next_update = 1 }
            for i = 1, 5 do
                card.ability.extra.anim.feet_targets[#card.ability.extra.anim.feet_targets + 1] = {
                    x = card.VT.x + 2 * math.cos(math.rad(144 * i)),
                    y = card.VT.y + 2 * math.sin(math.rad(144 * i)),
                    theta = math.rad(144 * i),
                    last_updated = 0
                }
            end
            card.ability.extra.anim.feet_interpolated = copy_table(card.ability.extra.anim.feet_targets)
            card.ability.extra.anim.last_time = G.TIMERS.REAL
        else
            local dt = G.TIMERS.REAL - card.ability.extra.anim.last_time
            card.ability.extra.anim.last_time = G.TIMERS.REAL
            for _, v in ipairs(card.ability.extra.anim.feet_targets) do
                v.theta = v.theta + spin_speed * dt
            end

            local amount = 1
            for _, v in ipairs(card.ability.extra.anim.feet_interpolated) do
                if v.moving then
                    amount = amount - 1
                end
            end

            if amount < 1 then
                return
            end

            local to_update = {}
            for i, foot in ipairs(card.ability.extra.anim.feet_targets) do
                if not card.ability.extra.anim.feet_interpolated[i].moving then
                    local ideal_x = card.VT.x + 2 * math.cos(foot.theta)
                    local ideal_y = card.VT.y + 2 * math.sin(foot.theta)

                    local dx = ideal_x - foot.x
                    local dy = ideal_y - foot.y

                    local strain = dx * dx + dy * dy
                    if strain > 2 then
                        to_update[#to_update + 1] = { i = i, x = ideal_x, y = ideal_y }
                    end
                end
            end

            table.sort(to_update, function(a, b)
                return card.ability.extra.anim.feet_interpolated[a.i].last_updated <
                    card.ability.extra.anim.feet_interpolated[b.i].last_updated
            end)

            for i = 1, math.min(amount, #to_update) do
                card.ability.extra.anim.feet_interpolated[to_update[i].i].moving = true
                card.ability.extra.anim.feet_interpolated[to_update[i].i].last_updated = card.ability.extra.anim
                    .next_update
                card.ability.extra.anim.next_update = card.ability.extra.anim.next_update + 1
                ease(card.ability.extra.anim.feet_interpolated[to_update[i].i], 'x', to_update[i].x)
                ease(card.ability.extra.anim.feet_interpolated[to_update[i].i], 'y', to_update[i].y)
                card.ability.extra.anim.feet_targets[to_update[i].i].x = to_update[i].x
                card.ability.extra.anim.feet_targets[to_update[i].i].y = to_update[i].y
                G.E_MANAGER:add_event(Event {
                    trigger = 'after',
                    blocking = false,
                    blockable = false,
                    delay = step_time / 2,
                    timer = 'REAL',
                    func = function()
                        card.ability.extra.anim.feet_interpolated[to_update[i].i].moving = false
                        return true
                    end
                })
            end
        end
    end,
    load = function(self, card, card_table, other_card)
        no_moving(card_table)
    end,
    set_sprites = function(self, card, front)
        no_moving(card)
    end,
    set_ability = function(self, card, initial, delay_sprites)
        no_moving(card)
    end
}

local leg_length_modifier = 36 * 2 / G.TILESCALE / G.TILESIZE
local inner_pivot_offset = { ((36 / 2) - 12) / G.TILESCALE / G.TILESIZE, ((60 / 2) - 8) / G.TILESCALE / G.TILESIZE }

local outer_leg_sprite
local inner_leg_sprite

SMODS.DrawStep {
    key = "dum_pentapod_leg",
    order = -15,
    func = function(self, layer)
        if not self:should_draw_base_shader() then return nil end
        if not (self.config.center.discovered or self.bypass_discovery_center) then return nil end
        if self.config.center.key ~= "j_worm_dum_pentapod" then return nil end

        if not outer_leg_sprite then
            inner_leg_sprite = Sprite(0, 0, 35, 60, G.ASSET_ATLAS[legs_atlas.key], { x = 2, y = 0 })
            outer_leg_sprite = Sprite(0, 0, 35, 60, G.ASSET_ATLAS[legs_atlas.key], { x = 3, y = 0 })
        end

        outer_leg_sprite.role.draw_major = nil
        inner_leg_sprite.role.draw_major = nil

        if not self.ability or not self.ability.extra or not self.ability.extra.anim or not self.ability.extra.anim.feet_interpolated then
            return
        end

        local v = self.children.center.VT
        local vx = v.x + v.w / 2 - 0.5
        local vy = v.y + v.h / 2 - 0.5

        local legs = solve_legs(self.ability.extra.anim, vx, vy)

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

        for _, leg in ipairs(legs) do
            leaf.VT.x = root.VT.x + math.cos(leg.theta + ninety) * leg.l * leg_length_modifier
            leaf.VT.y = root.VT.y + math.sin(leg.theta + ninety) * leg.l * leg_length_modifier
            Wormhole.dum_pentapod_scale[2] = leg.r
            outer_leg_sprite:draw_shader('dissolve', nil, nil, nil, leaf, 0, leg.theta + leg.phi)
            Wormhole.dum_pentapod_scale[2] = leg.l
            inner_leg_sprite:draw_shader('dissolve', nil, nil, nil, root, 0, leg.theta)
        end

        Wormhole.dum_pentapod_scale = nil
        Wormhole.dum_pentapod_offset = nil
    end,
    conditions = { vortex = false, facing = "front" },
}
