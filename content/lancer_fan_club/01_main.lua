local function dark_flip(card)
    local pos = card.children.center.sprite_pos
    card.children.center:set_sprite_pos({x=pos.x,y=1-pos.y})
    local pos2 = card.children.ppu_floating_sprite.sprite_pos
    card.children.ppu_floating_sprite:set_sprite_pos({x=pos2.x,y=1-pos2.y})
end

-- Team
Wormhole.LancerFanClub = PotatoPatchUtils.Team {
    name = "Lancer Fan Club",
    loc = "PotatoPatchTeam_lancer_fan_club",
    colour = HEX("5585bd"), -- this was colorpicked directly from lancer's sprite
    calculate = function(self, context)
        local effects = {}

        if context.after or context.setting_blind and not context.blueprint then
            Wormhole.LancerFanClub.get_piss()
        end

        if context.remove_playing_cards and #context.removed > 0 then
            G.GAME.lfc_can_blacephalon_appear = true
        end

        if #effects > 0 then return SMODS.merge_effects(effects) end
    end,
    short_credit = true,
    click = function(self) dark_flip(self) end
}

local was_on_lancer = false
local elle_click_count = 5
local alexi_click_count = 5
local proot_click_count = 5
local j8_click_count = 5

local ctcp = PotatoPatchUtils.CREDITS.create_team_credit_page
function PotatoPatchUtils.CREDITS.create_team_credit_page(team, ...)
    if team == Wormhole.LancerFanClub then
        play_sound("worm_lfc_splat")
        elle_click_count = 5
        was_on_lancer = true
    elseif was_on_lancer then
        was_on_lancer = false
        play_sound("worm_lfc_reverse_splat")
    end
    return ctcp(team, ...)
end

-- Atlases
SMODS.Atlas {
    key = "lfc_devs",
    px = 71,
    py = 95,
    path = "lancer_fan_club/devs.png"
}

SMODS.Atlas {
    key = "lfc_tags",
    px = 32,
    py = 32,
    path = "lancer_fan_club/tags.png"
}

SMODS.Atlas {
    key = "lfc_jokers",
    px = 71,
    py = 95,
    path = "lancer_fan_club/jokers.png"
}

SMODS.Atlas {
    key = "lfc_spectrals",
    px = 65,
    py = 95,
    path = "lancer_fan_club/spectrals.png"
}

SMODS.Atlas {
    key = "lfc_seals",
    px = 65,
    py = 95,
    path = "lancer_fan_club/seals.png"
}

SMODS.Atlas {
    key = "lfc_blinds",
    px = 34,
    py = 34,
    path = "lancer_fan_club/blinds.png",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21
}

SMODS.Atlas {
    key = "lfc_spacebar",
    px = 95,
    py = 23,
    path = "lancer_fan_club/spacebar.png"
}

SMODS.Atlas {
    key = "lfc_proot_Ears",
    px = 18,
    py = 24,
    path = "lancer_fan_club/Ears.png"
}

SMODS.Atlas {
    atlas_table = "ASSET_ATLAS",
    key = "lfc_lemniscate_atlas",
    px = 77,
    py = 95,
    path = "lancer_fan_club/lemniscate_spectral.png"
}

SMODS.Atlas {
    atlas_table = "ASSET_ATLAS",
    key = "lfc_lemniscate_atlas",
    px = 77,
    py = 95,
    path = "lancer_fan_club/lemniscate_spectral.png"
}

-- Sounds
SMODS.Sound {
    key = "lfc_explosion",
    path = "lfc_explosion.ogg"
}

SMODS.Sound {
    key = "lfc_splat",
    path = "lfc_splat.wav"
}

SMODS.Sound {
    key = "lfc_reverse_splat",
    path = "lfc_reverse_splat.wav"
}

SMODS.Sound {
    key = "lfc_elle_squeak",
    path = "lfc_elle_squeak.ogg"
}

SMODS.Sound{
    key = "lfc_tada",
    path = "lfc_tada.ogg"
}

SMODS.Sound{
    key = "lfc_not_tada",
    path = "lfc_not_tada.ogg"
}

SMODS.Sound{
    key = "lfc_j8_click",
    path = "lfc_j8_click.wav"
}

-- Colors
loc_colour('red')
G.ARGS.LOC_COLOURS.lfc_pkmn_us = HEX('E95B2B')
G.ARGS.LOC_COLOURS.lfc_pkmn_um = HEX('226DB5')
G.ARGS.LOC_COLOURS.lfc_meteor  = HEX('a97a51')
G.ARGS.LOC_COLOURS.lfc_discord = HEX('5662f6')
G.ARGS.LOC_COLOURS.lfc_dark    = G.C.BLACK
G.ARGS.LOC_COLOURS.lfc_elle    = HEX('ff53a9')
G.ARGS.LOC_COLOURS.lfc_ash     = SMODS.Gradient {
    key = "lfc_ash",
    colours = {
        HEX('fd5f55'),
        HEX('ffe07b'),
        HEX('81ff70'),
        HEX('81cefd'),
        HEX('4b69cf'),
        HEX('f75eff')
    },
    cycle = 4
}
G.ARGS.LOC_COLOURS.lfc_trans_blue = HEX("75cdf3")
G.ARGS.LOC_COLOURS.lfc_trans_pink = HEX("edbac7")
G.ARGS.LOC_COLOURS.lfc_fox = HEX("d66b1c")

local proot_first_click = true

-- Developers
PotatoPatchUtils.Developer {
    name = "ProdByProto",
    colour = HEX("d66b1c"),
    loc = "PotatoPatchDev_ProdByProto",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 6, y = 0 },
    soul_pos = { x = 7, y = 0 },
    click = function(self)
        dark_flip(self)

        play_sound((math.random(2) == 1 and not proot_first_click) and "worm_lfc_tada" or "worm_lfc_not_tada",1.5-proot_click_count*0.1)
        
        -- Shitpost thing
        if proot_first_click then
            proot_first_click = false
            love.system.openURL("https://youtu.be/FbOy5CsWxXA")
        end

        self:juice_up()
        if proot_click_count == 1 then
            love.system.openURL("https://www.youtube.com/@Prod_by_proto")
            proot_click_count = 5
        else
            proot_click_count = proot_click_count - 1
        end
    end,
    calculate = function(self, context)
        if context.card_added then
            if context.card.ability.set == "Joker" then
                local cck = context.card.config.center.key
                if not G.GAME.worm_log then G.GAME.worm_log = {} end
                if not G.GAME.worm_log[cck] then
                    G.GAME.worm_log[cck] = true
                    G.GAME.worm_log_count = (G.GAME.worm_log_count or 0) + 1
                    Wormhole.LFC_Util.debug_print(G.GAME.worm_log)
                end
            end
        end
    end
}

SMODS.DynaTextEffect {
    key = "elle_text",
    func = function(dynatext, index, letter)
        local t = G.TIMERS.REAL * 3 + index

        letter.offset = {
            x = math.sin(t) * 9,
            y = math.cos(t) * 9
        }

        letter.colour = mix_colours(HEX('f25fa8'), HEX('a83c8d'), (math.sin(t * 0.437) + 1) / 2)
        letter.scale = 1 + math.cos(t * 0.81) * .1
    end,
}

-- Elle
PotatoPatchUtils.Developer({
    name = "ellestuff.",
    text_effect = "worm_elle_text",
    loc = "PotatoPatchDev_ellestuff",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 },
    click = function(self)
        dark_flip(self)

        play_sound('worm_lfc_elle_squeak',1.5-elle_click_count*0.1)
        self:juice_up()
        if elle_click_count == 1 then
            love.system.openURL("https://ellestuff.dev")
            elle_click_count = 5
        else
            elle_click_count = elle_click_count - 1
        end
    end
})

-- J8-Bit
local j8_text_colors = {
    HEX("F1641F"),
    HEX("F1641F"),
    HEX("8306C1"),
    HEX("8306C1"),
}

SMODS.DynaTextEffect {
    key = "j8_text",
    func = function(dynatext, index, letter)
        local s = #j8_text_colors
        local o = index * 0.1
        local t = G.TIMERS.REAL + o
        --print(tostring(index) .. ": " .. tostring(idx + 1) .. " " .. tostring(next_idx + 1) .. " " .. tostring(t) .. " " .. tostring(t / s))
        letter.colour = mix_colours(j8_text_colors[(math.floor(t) % s) + 1],
            j8_text_colors[((math.floor(t) + 1) % s) + 1], t % 1.0)
        letter.offset.y = math.abs(math.cos(G.TIMERS.REAL * 4.0 + index * 0.1)) * 16
    end,
}

PotatoPatchUtils.Developer({
    name = "J8-Bit",
    colour = HEX('F1641F'),
    text_effect = "worm_j8_text",
    loc = "PotatoPatchDev_j8bit",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    click = function(self)
        dark_flip(self)

        play_sound('worm_lfc_j8_click',1.5-j8_click_count*0.1,2)
        self:juice_up()
        if j8_click_count == 1 then
            love.system.openURL("https://store.steampowered.com/app/4551740/CalvinChess/")
            j8_click_count = 5
        else
            j8_click_count = j8_click_count - 1
        end
    end
})

-- Alexi
local alexi_text_colors = {
    HEX("45FFDA"),
    HEX("2AC2FF"),
    HEX("307FFF"),
    HEX("C180FF"),
    HEX("FFC7FF"),
}

SMODS.DynaTextEffect {
    key = "alexi_text",
    func = function(dynatext, index, letter)
        local idx = math.min(index, 5)
        letter.colour = alexi_text_colors[idx]
        letter.offset.y = math.cos(G.TIMERS.REAL * 2.95 + index) * 9
    end,
}

--[[
--  Note: i did code for all the forcetrigger compat stuff,
--        but it's fairly simple to do and doesn't affect
--        wormhole on its own, so it's not included in the
--        code credits
--      - alexi
--]]
Wormhole.LancerFanClub.Alexi = PotatoPatchUtils.Developer {
    name = "InvalidOS",
    text_effect = "worm_alexi_text",
    loc = "PotatoPatchDev_alexi",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 4, y = 0 },
    soul_pos = { x = 5, y = 0 },
    click = function(self)
        dark_flip(self)

        play_sound("worm_lfc_splat",1.5-alexi_click_count*0.1)
        self:juice_up()
        if alexi_click_count == 1 then
            love.system.openURL("https://en.pronouns.page/@invalidOS")
            alexi_click_count = 5
        else
            alexi_click_count = alexi_click_count - 1
        end
    end
}

local function floating_sprite(offset)
    local offset = offset or 0
    local time = G.TIMERS.REAL + offset

    local scale_mod = 0.07 + 0.02 * math.sin(1.8 * time) +
    0.00 * math.sin((time - math.floor(time)) * math.pi * 14) * (1 - (time - math.floor(time))) ^ 3
    local rotate_mod = 0.05 * math.sin(1.219 * time) + 0.00 * math.sin((time) * math.pi * 5) *
    (1 - (time - math.floor(time))) ^ 2

    return scale_mod, rotate_mod
end

SMODS.draw_ignore_keys.worm_lfc_extra_sprite = true
SMODS.DrawStep {
    key = "worm_lfc_extra_sprite",
    order = 61,
    func = function(self)
        if self.children.worm_lfc_extra_sprite then
            local scale_mod, rotate_mod = floating_sprite(-45)

            self.children.worm_lfc_extra_sprite:draw_shader('dissolve', 0, nil, nil, self.children.center, scale_mod,
                rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            self.children.worm_lfc_extra_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod,
                rotate_mod)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

function Wormhole.LancerFanClub.Alexi.create_lemniscate()
    local card = Card(G.ROOM.T.x, G.ROOM.T.y, G.CARD_W / 1.25, G.CARD_H / 1.25, nil, G.P_CENTERS.c_base)
    card.T.w = card.T.w * (77 / 71)
    card.VT.w = card.T.w
    card.children.center:remove()
    card.children.center = SMODS.create_sprite(card.T.x, card.T.y, card.T.w, card.T.h, "worm_lfc_lemniscate_atlas",
        { x = 0, y = 0 })
    card.children.center.states.hover = card.states.hover
    card.children.center.states.click = card.states.click
    card.children.center.states.drag = card.states.drag
    card.children.center.states.collide.can = true
    card.children.center:set_role({ major = card, role_type = 'Glued', draw_major = card })

    card.children.ppu_floating_sprite = SMODS.create_sprite(card.T.x, card.T.y, card.T.w, card.T.h,
        "worm_lfc_lemniscate_atlas", { x = 1, y = 0 })
    card.children.ppu_floating_sprite.role.draw_major = card
    card.children.ppu_floating_sprite.states.hover.can = false
    card.children.ppu_floating_sprite.states.click.can = false

    card.children.worm_lfc_extra_sprite = SMODS.create_sprite(card.T.x, card.T.y, card.T.w, card.T.h,
        "worm_lfc_lemniscate_atlas", { x = 2, y = 0 })
    card.children.worm_lfc_extra_sprite.role.draw_major = card
    card.children.worm_lfc_extra_sprite.states.hover.can = false
    card.children.worm_lfc_extra_sprite.states.click.can = false

    return card
end

-- Credits shader stuff :3
SMODS.Shader {
    key = 'lfc_devshader',
    path = 'lfc_devshader.fs',

    send_vars = function(self, sprite, card)
        local w, h = love.graphics.getDimensions()
        local mx, my = love.mouse.getPosition()
        return {
            mouse_pos = { mx, my },
            t = G.TIMERS.REAL
        }
    end
}

local ppu_front_hook = SMODS.DrawSteps.center.func
SMODS.DrawSteps.center.func = function(card, layer)
    if card.ppu_team and card.ppu_team.name == "Lancer Fan Club" then
        card.children.center:draw_shader('worm_lfc_devshader', nil, card.ARGS.send_to_shader)
    else
        ppu_front_hook(card, layer)
    end
end

local ppu_floating_sprite_hook = SMODS.DrawSteps.ppu_floating_sprite.func
SMODS.DrawSteps.ppu_floating_sprite.func = function(card, layer)
    if card.ppu_team and card.ppu_team.name == "Lancer Fan Club" then
        local scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) +
            0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
            (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
        local rotate_mod = 0.05 * math.sin(1.219 * G.TIMERS.REAL) +
            0.00 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

        card.children.ppu_floating_sprite:draw_shader('worm_lfc_devshader', nil, nil, nil, card.children.center,
            scale_mod, rotate_mod)
    else
        ppu_floating_sprite_hook(card, layer)
    end
end

local localize_ref = localize
function localize(args, misc_cat)
    local ret = localize_ref(args, misc_cat)
    if type(args) == "table" and args.type == "name" and args.set == "PotatoPatch"
        and args.key == "PotatoPatchDev_ProdByProto" and (args.nodes or {})[1] and args.nodes[1][1] then
        args.nodes[1][1] = {
            n = G.UIT.R,
            nodes = {
                {
                    n = G.UIT.C,
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                object = SMODS.create_sprite(0, 0, 0.25, 0.25, "worm_lfc_proot_Ears", { x = 0, y = 0 })
                            }
                        }
                    }
                },
                args.nodes[1][1],
                {
                    n = G.UIT.C,
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                object = SMODS.create_sprite(0, 0, 0.25, 0.25, "worm_lfc_proot_Ears", { x = 1, y = 0 })
                            }
                        }
                    }
                },
            }
        }
    end
    return ret
end