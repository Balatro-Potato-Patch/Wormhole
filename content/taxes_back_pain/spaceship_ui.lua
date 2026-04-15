SMODS.Atlas({
    key = 'tbp_module_no_bg',
    path = 'taxes_back_pain/module_no_bg.png',
    px = 59,
    py = 81
})

function Wormhole.tbp.module_tooltip(desc_nodes)
    local col = Wormhole.tbp.module_colours[desc_nodes.tbp_module] -- module colour
    local durability_col = mix_colours(G.C.BLACK, col, 0.8) -- durability bar background
    local discovered = desc_nodes.module_info and G.P_CENTERS[desc_nodes.module_info.key].discovered
    local module_pos = desc_nodes.module_info and copy_table(G.P_CENTERS[desc_nodes.module_info.key].module_pos) or { x = 2, y = 5}
    module_pos.y = module_pos.y - 4

    local t = {}
    if desc_nodes.module_info then
        t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.T, config={text= discovered and localize({type='name_text', set = 'tbp_module', key = desc_nodes.module_info.key}) or localize('tbp_undisc_module'), scale = 0.384, colour = darken(discovered and col or G.C.JOKER_GREY, 0.3)}}}
        }
    end
    for k, v in ipairs(desc_nodes) do
        t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes=v}
    end
    return {n=G.UIT.R, nodes = {
        {n=G.UIT.R, config = {align = 'cm', colour = col}, nodes = {
            {n=G.UIT.C, config = {align = 'cm', colour = darken(col, 0.4), padding = 0.1}, nodes = {
                {n=G.UIT.T, config={text = localize('tbp_module_'..desc_nodes.tbp_module), scale = 0.32, colour = G.C.UI.TEXT_LIGHT, vert = true}}
            }},
            {n=G.UIT.C, config = {align = 'cm', padding = 0.05, colour = lighten(discovered and col or G.C.JOKER_GREY, 0.8)}, nodes = {
                {n=G.UIT.R, config={align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = lighten(discovered and col or G.C.JOKER_GREY, 0.8)}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}
                }},
                desc_nodes.module_info and discovered and {n=G.UIT.R, config = {align = 'cm', r = 0.08, minw = 0.5, minh = 0.15, colour = durability_col, outline = 0.5, outline_colour = darken(col, 0.3),
                    progress_bar = {
                        max = desc_nodes.module_info.total_durability, ref_table = desc_nodes.module_info, ref_value = 'durability', empty_col = durability_col, filled_col = adjust_alpha(col, 0.5)
                    }
                }, nodes = {
                    {n=G.UIT.T, config = {text = desc_nodes.module_info.durability .. '/' .. desc_nodes.module_info.total_durability, colour = lighten(col, 0.6), scale = 0.28}}
                }} or nil
            }},
            desc_nodes.module_info and not desc_nodes.block_image and {n=G.UIT.C, config = {align = 'cm', padding = 0.05, colour = lighten(col, 0.8)}, nodes = {
                {n=G.UIT.R, config = {align = 'cm', colour = durability_col}, nodes = {
                    {n=G.UIT.O, config = {outline = 1, outline_colour = darken(col,0.4), object = SMODS.create_sprite(0,0, 0.65*G.CARD_W, 0.65*G.CARD_H, 'worm_tbp_module_no_bg', module_pos), align = 'cm'}}
                }}
            }} or nil
        }},
    }}
end

Wormhole.tbp.shader_draw_stuff = {}

G.FUNCS.show_spaceship_tooltips = function(e)
    if e.config.ref_table then 
        e.children.info = UIBox{
            definition = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.02}, nodes=e.config.ref_table},
            config = {offset = {x=0.03,y=0}, align = 'cr', parent = e}}
        e.children.info:align_to_major()
        e.config.ref_table = nil
    end
end

local function spaceship_ease(mod)
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        ref_table = G.GAME,
        ref_value = 'tbp_module_replace_active',
        ease_to = G.GAME.tbp_module_replace_active + mod,
        delay =  2,
        func = (function(t) return t end)
    }))
end

G.FUNCS.module_replace_yes = function(e)
    local module_def = e.config.ref_table.module_info
    spaceship_ease(-1)
    local slot = e.config.ref_table.module_slot
    local spaceship = e.config.ref_table.spaceship
    local current_module = spaceship.ability.extra.modules[slot]
    if current_module.key == module_def.key then
        current_module.durability = math.min(current_module.durability + module_def.durability, current_module.total_durability)
        if G.GAME.module_replace_overlay then
            G.GAME.module_replace_overlay:remove()
            G.GAME.module_replace_overlay = nil
        end
        SMODS.calculate_effect({
            message = localize('tbp_durability_restored'),
            colour = Wormhole.tbp.module_colours[slot],
            delay = 2
        }, spaceship)
        return
    end
    spaceship.ability.extra.modules[slot] = {
        key = module_def.key,
        durability = module_def.durability,
        total_durability = module_def.durability,
    }
    for k, v in pairs(G.P_CENTERS[module_def.key].config.extra) do
        spaceship.ability.extra.modules[slot][k] = v
    end
    SMODS.calculate_context({wormhole_tbp_module_install = true, card = spaceship, module = slot, type = 'Default'})
    if G.GAME.module_replace_overlay then
        G.GAME.module_replace_overlay:remove()
        G.GAME.module_replace_overlay = nil
    end
    
    SMODS.calculate_effect({
        message = localize({type='name_text', set='tbp_module', key=module_def.key}) .. localize('tbp_equipped'),
        colour = Wormhole.tbp.module_colours[slot],
        delay = 2
    }, spaceship)
end
G.FUNCS.module_replace_no = function(e)
    local module_key = e.config.ref_table.key
    spaceship_ease(-1)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
                local new_card = create_card('tbp_module', G.consumeables, nil, nil, nil, nil, module_key)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
                new_card:juice_up(0.3, 0.5)
                play_sound('card1')
            end
            return true
        end
    }))
    if G.GAME.module_replace_overlay then
        G.GAME.module_replace_overlay:remove()
        G.GAME.module_replace_overlay = nil
    end
end

G.FUNCS.show_module_replace_confirm = function(card, spaceship)
    Wormhole.tbp.shader_draw_stuff = {spaceship}
    local target_slot = card.config.center.slot
    local current_module = spaceship.ability.extra.modules[target_slot]
    
    local slot_colour = Wormhole.tbp.module_colours[target_slot]
    local title_colour = darken(slot_colour, 0.3)
    
    local AUT = card.ability_UIBox_table
    AUT.main.block_image = nil

    local vars = {colours = {mix_colours(G.ARGS.LOC_COLOURS.inactive, Wormhole.tbp.module_colours[target_slot], 0.5)}}
    if current_module.key and (G.P_CENTERS[current_module.key] or {}).loc_vars then
        vars = G.P_CENTERS[current_module.key]:loc_vars({}, {ability = { extra = current_module } }, card).vars
        vars.colours = vars.colours or {}
        table.insert(vars.colours, 1, title_colour)
    end
    generate_card_ui({set = 'tbp_module', key = current_module.key or 'c_worm_tbp_module_missing', vars = vars, module_type = target_slot, module_info = next(current_module) and current_module}, AUT)
    

    local t = {n=G.UIT.R, config={align = "cm", colour = title_colour, padding = 0.05, emboss = 0.1}, nodes={
        {n=G.UIT.C, config={align = "cm", colour = mix_colours(lighten(slot_colour, 0.8), G.C.BLACK, 0.6)}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0.15, colour = darken(slot_colour, 0.4)}, nodes={
                {n=G.UIT.T, config={text = localize('tbp_module_equip')..' '..localize('tbp_new_module'), scale = 0.45, colour = G.C.WHITE}}
            }},
            {n=G.UIT.R, config={align = "cm", padding = 0.06}, nodes={
                {n=G.UIT.C, config = {align = 'tr', padding = 0.05, minw = 3.5}, nodes = {
                    {n=G.UIT.R, config = {align = 'cm', padding = 0.05}, nodes ={
                        {n=G.UIT.T, config = {text = localize('tbp_old_module'), scale = 0.3, colour = title_colour, underline = title_colour}}
                    }},
                    {n=G.UIT.R, config = {align = 'cm', padding = 0.05, emboss = 0.1, colour = darken(Wormhole.tbp.module_colours[card.config.center.slot], 0.5)}, nodes = {
                        Wormhole.tbp.module_tooltip(AUT.info[1]),
                    }}
                }},
                {n=G.UIT.C, config = {minw = 1}},
                {n=G.UIT.C, config = {align = 'tm', padding = 0.05, minw = 3.5}, nodes = {
                    {n=G.UIT.R, config = {align = 'cm', padding = 0.05}, nodes ={
                        {n=G.UIT.T, config = {text = localize('tbp_new_module'), scale = 0.3, colour = title_colour, underline = title_colour}}
                    }},
                    {n=G.UIT.R, config = {align = 'cm', padding = 0.05, emboss = 0.1, colour = darken(Wormhole.tbp.module_colours[card.config.center.slot], 0.5)}, nodes = {
                        Wormhole.tbp.module_tooltip(AUT.main),
                    }}
                }}
            }},
            {n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
                    UIBox_button({
                        label = {localize('tbp_module_equip')},
                        button = "module_replace_yes",
                        ref_table = {
                            module_info = AUT.main.module_info,
                            module_slot = target_slot,
                            spaceship = spaceship
                        },
                        w = 1.3,
                        h = 0.5,
                        colour = G.C.RED,
                        scale = 0.45
                    })
                }},
                {n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
                    UIBox_button({
                        label = {localize('tbp_module_store')},
                        button = "module_replace_no",
                        func = 'module_can_store',
                        ref_table = {key = card.config.center_key},
                        w = 1.3,
                        h = 0.5,
                        colour = G.C.RED,
                        scale = 0.45
                    })
                }}
            }}
        }}
    }}
    G.E_MANAGER.queues.module_replace_dialog = G.E_MANAGER.queues.module_replace_dialog or {}
    
    G.GAME.tbp_module_replace_active = 0
    spaceship_ease(1)
    G.E_MANAGER:add_event(Event({
        trigger = 'after', delay = 1.5,
        func = function()
            G.GAME.module_replace_overlay = UIBox{
                definition = t,
                config = {align="cm", offset = {x=0,y=0}, instance_type = 'CARD', major = G.ROOM_ATTACH, bond = 'Weak', draggable = true, collideable = true, can_collide = true}
            }
            G.GAME.module_replace_overlay:align_to_major()
            G.GAME.module_replace_overlay.config.major = nil
            G.GAME.module_replace_overlay:set_role{role_type = 'Major'}
            G.GAME.module_replace_overlay.states.drag.can = true
            return true
        end
    }), "module_replace_dialog")
end

G.FUNCS.module_can_store = function(e)
    if #G.consumeables.cards < G.consumeables.config.card_limit then
        e.config.button = 'module_replace_no'
        e.config.colour = G.C.RED
        e.config.hover = true
    else
        e.config.button = nil
        e.config.colour = G.C.L_BLACK
        e.config.hover = false
    end
end

--Can be enabled later at any time by setting G.GAME.tbp_module_replace_active = true

SMODS.ScreenShader{
    key = 'tbp_space_warp',
    path = 'tbp_space_warp.fs',
    order = -1,
    should_apply = function(self)
        return G.GAME and G.GAME.tbp_module_replace_active and G.GAME.tbp_module_replace_active > 0
    end,
    send_vars = function(self)
        return {
            time = G.TIMERS and G.TIMERS.REAL or 0,
            transparency = G.GAME.tbp_module_replace_active
        }
    end
}

-- Module Card tooltips

local override_tooltip = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    if card.config.center and card.config.center.set == 'tbp_module' then 
        local AUT = card.ability_UIBox_table
        AUT.main.tbp_module = card.config.center.slot
        AUT.main.block_image = true
        AUT.main.module_info = {
            key = card.config.center.key,
            durability = card.config.center.durability,
            total_durability = card.config.center.durability,
        }

        local info_boxes = {}
        if AUT.info then
            for k, v in ipairs(AUT.info) do
                info_boxes[#info_boxes+1] =
                    {n=G.UIT.R, config={align = "cm"}, nodes={
                        {n=G.UIT.R, config={align = "cm", colour = lighten(G.C.JOKER_GREY, 0.5), r = 0.1, padding = 0.05, emboss = 0.05}, nodes={
                            info_tip_from_rows(v, v.name),
                        }}
                    }}
            end
            local cols
            if #info_boxes <= 3 then
                cols = 1
            elseif #info_boxes <= 10 then
                cols = 2
            elseif #info_boxes <= 24 then
                cols = 3
            else
                cols = 4
            end
            local nodes_per_col = math.ceil(#info_boxes/cols)
            local info_cols = {}
            for i = 0, cols-1 do
                local col = {}
                for j = 1, nodes_per_col do
                    local info_box = info_boxes[i*nodes_per_col+j]
                    if info_box then
                        table.insert(col, info_box)
                    else break end
                end
                table.insert(info_cols, {n=G.UIT.C, config = {align="cm"}, nodes = col})
            end
            info_boxes = {{n=G.UIT.R, config = {align="cm", padding = 0.05, card_pos = card.T.x }, nodes = info_cols}}
        end

        local badges = {}
        if AUT.badges then
            for k, v in ipairs(AUT.badges) do
                if v:sub(v:len()-14) == '_SMODS_INTERNAL' then
                    if v:sub(1, 9) == 'negative_' then v = 'negative' else v = v:sub(1, v:find('_', v:find('_')+1)-1) end
                end
                badges[#badges + 1] = create_badge(localize(v, "labels"), get_badge_colour(v), SMODS.get_badge_text_colour(v))
            end
        end
        SMODS.create_mod_badges(card.config.center, badges)
        badges.mod_set = nil
        if card.config.center and card.config.center.ppu_team then
            local str = PotatoPatchUtils.CREDITS.generate_string(card.config.center.ppu_team, 'ppu_team_credit', card.config.center.mod.prefix)
            if str then
                table.insert(badges, str)
            end
        end
        if card.config.center and card.config.center.ppu_artist then
            local str = PotatoPatchUtils.CREDITS.generate_string(card.config.center.ppu_artist, 'ppu_art_credit', card.config.center.mod.prefix)
            if str then
                table.insert(badges, str)
            end
        end

        return {n=G.UIT.C, config = {align='cm', colour = G.C.CLEAR, padding = 0.05}, nodes = {
            {n=G.UIT.R, config = {align = 'cm', func = 'show_infotip',object = Moveable(),ref_table = next(info_boxes) and info_boxes or nil}, nodes = {
                {n=G.UIT.C, config = {align = 'cm', padding = 0.05, emboss = 0.1, colour = darken(Wormhole.tbp.module_colours[card.config.center.slot], 0.5)}, nodes = {
                    Wormhole.tbp.module_tooltip(AUT.main),
                }}
            }},
            badges[1] and {n=G.UIT.R, config = {align = 'cm'}, nodes = {
                {n=G.UIT.R, config = {align = 'cm', padding = 0.05, emboss = 0.1, colour = darken(Wormhole.tbp.module_colours[card.config.center.slot], 0.5)}, nodes = {
                    {n=G.UIT.C, config = {align = 'cm', padding = 0.1, colour = G.C.L_BLACK}, nodes = badges}}
                }
            }} or nil
        }}
    end
    return override_tooltip(card)
end

local localize_hook = localize
function localize(args, misc_cat)
    if args.type == 'name' and (args.set == 'tbp_module' or args.key == 'undiscovered_tbp_module') then return end
    return localize_hook(args, misc_cat)
end

local show_infotip_hook = G.FUNCS.show_infotip
G.FUNCS.show_infotip = function(e)
    if e.config.ref_table and e.config.ref_table[1].config.tbp_spaceship then
        e.children.info = UIBox{
            definition = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.02}, nodes=e.config.ref_table},
            config = {offset = {x=-0.03,y=0}, align = 'cl', parent = e}
        }
        e.children.info:align_to_major()
        e.config.ref_table = nil
    else
        show_infotip_hook(e)
    end
end