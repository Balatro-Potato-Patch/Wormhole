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
    end
}

local ctcp = PotatoPatchUtils.CREDITS.create_team_credit_page
function PotatoPatchUtils.CREDITS.create_team_credit_page(team, ...)
    if team == Wormhole.LancerFanClub then
        play_sound("worm_lfc_splat")
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

-- Sounds
SMODS.Sound {
    key = "lfc_explosion",
    path = "lfc_explosion.ogg"
}

SMODS.Sound {
    key = "lfc_spacebar",
    path = "lfc_spacebar.ogg"
}

SMODS.Sound {
    key = "lfc_splat",
    path = "lfc_splat.wav"
}

-- Colors
loc_colour('red')
G.ARGS.LOC_COLOURS.lfc_pkmn_us = HEX('E95B2B')
G.ARGS.LOC_COLOURS.lfc_pkmn_um = HEX('226DB5')
G.ARGS.LOC_COLOURS.lfc_meteor  = HEX('a97a51')

-- Developers
PotatoPatchUtils.Developer {
    name = "ProdByProto",
    colour = HEX("d66b1c"),
    loc = "PotatoPatchDev_ProdByProto",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 6, y = 0 },
    soul_pos = { x = 7, y = 0 },
    --[[
    loc_vars = function(self,  info_queue, card)
        return{vars = {1,2}}
    end,
    ]]
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


-- Elle
PotatoPatchUtils.Developer({
    name = "ellestuff.",
    colour = HEX('ff53a9'),
    loc = "PotatoPatchDev_ellestuff",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 2, y = 0 },
    soul_pos = { x = 3, y = 0 }
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
    --colour = HEX('F1641F'),
    text_effect = "worm_j8_text",
    loc = "PotatoPatchDev_j8bit",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 }

})

-- Alexi
local alexi_text_colors = {
    HEX("45FFDA"),
    HEX("2AC2FF"),
    HEX("307FFF"),
    HEX("C180FF"),
    HEX("FFC7FF"),
}

-- very likely to be changed to fit "InvalidOS"
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
PotatoPatchUtils.Developer {
    name = "InvalidOS",
    text_effect = "worm_alexi_text",
    loc = "PotatoPatchDev_alexi",
    team = "Lancer Fan Club",
    atlas = "worm_lfc_devs",
    pos = { x = 4, y = 0 },
    soul_pos = { x = 5, y = 0 }
}

-- Credits shader stuff :3
SMODS.Shader {
    key = 'lfc_devshader',
    path = 'lfc_devshader.fs',

    send_vars = function(self, sprite, card)
        local w,h = love.graphics.getDimensions()
        local mx,my = love.mouse.getPosition()
        return {
            mouse_pos = {mx,my}
        }
    end
}

local ppu_front_hook = SMODS.DrawSteps.center.func
SMODS.DrawSteps.center.func = function(card,layer)
    if card.ppu_team and card.ppu_team.name == "Lancer Fan Club" then
        card.children.center:draw_shader('worm_lfc_devshader', nil, card.ARGS.send_to_shader)
    else
        ppu_front_hook(card,layer)
    end
end

local ppu_floating_sprite_hook = SMODS.DrawSteps.ppu_floating_sprite.func
SMODS.DrawSteps.ppu_floating_sprite.func = function(card,layer)
    if card.ppu_team and card.ppu_team.name == "Lancer Fan Club" then
        local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
        local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
        
        card.children.ppu_floating_sprite:draw_shader('worm_lfc_devshader', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    else
        ppu_floating_sprite_hook(card,layer)
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
                                object = SMODS.create_sprite(0, 0, 0.5, 0.5, "worm_lfc_proot_Ears", { x = 0, y = 0 })
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
                                object = SMODS.create_sprite(0, 0, 0.5, 0.5, "worm_lfc_proot_Ears", { x = 1, y = 0 })
                            }
                        }
                    }
                },
            }
        }
    end
    return ret
end