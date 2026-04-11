SMODS.Atlas({
    key = 'tbp_module_no_bg',
    path = 'taxes_back_pain/module_no_bg.png',
    px = 59,
    py = 81
})

function Wormhole.tbp.module_tooltip(desc_nodes, name)
    local col = Wormhole.tbp.module_colours[desc_nodes.tbp_module] -- module colour
    local durability_col = mix_colours(G.C.BLACK, col, 0.8) -- durability bar background
    local t = {}
    for k, v in ipairs(desc_nodes) do
        t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes=v}
    end
    return {n=G.UIT.C, nodes = {
        {n=G.UIT.R, config = {align = 'cm', colour = col}, nodes = {
            {n=G.UIT.C, config = {align = 'cm', colour = darken(col, 0.4), padding = 0.1}, nodes = {
                {n=G.UIT.T, config={text = localize('tbp_module_'..desc_nodes.tbp_module), scale = 0.32, colour = G.C.UI.TEXT_LIGHT, vert = true}}
            }},
            {n=G.UIT.C, config = {align = 'cm', padding = 0.05, colour = lighten(col, 0.8)}, nodes = {
                {n=G.UIT.R, config={align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = lighten(col, 0.8)}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}
                }},
                desc_nodes.module_info and {n=G.UIT.R, config = {align = 'cm', r = 0.08, minw = 0.5, minh = 0.15, colour = durability_col, outline = 0.5, outline_colour = darken(col, 0.3),
                    progress_bar = {
                        max = desc_nodes.module_info.total_durability, ref_table = desc_nodes.module_info, ref_value = 'durability', empty_col = durability_col, filled_col = adjust_alpha(col, 0.5)
                    }
                }, nodes = {
                    {n=G.UIT.T, config = {text = desc_nodes.module_info.durability .. '/' .. desc_nodes.module_info.total_durability, colour = lighten(col, 0.6), scale = 0.28}}
                }} or nil
            }},
            desc_nodes.module_info and {n=G.UIT.C, config = {align = 'cm', padding = 0.05, colour = lighten(col, 0.8)}, nodes = {
                {n=G.UIT.R, config = {align = 'cm', colour = durability_col}, nodes = {
                    {n=G.UIT.O, config = {outline = 1, outline_colour = darken(col,0.4), object = SMODS.create_sprite(0,0, 0.65*G.CARD_W, 0.65*G.CARD_H, 'worm_tbp_module_no_bg', {x=math.random(1,4)-1,y=math.random(1,2)-1}), align = 'cm'}} -- TODO: fix position to match the actual sprite
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
    local card = e.config.ref_table.card
    local module_def = e.config.ref_table.module_def
    spaceship_ease(-1)
    local slot = e.config.ref_table.slot
    local spaceship = e.config.ref_table.spaceship
    spaceship.ability.extra.modules[slot] = {
        key = module_def.key,
        durability = module_def.durability,
        total_durability = module_def.durability,
        durability_loss_odds = module_def.config.extra.durability_loss_odds
    }
    for k, v in pairs(module_def.config.extra) do
        spaceship.ability.extra.modules[slot][k] = v
    end
    SMODS.calculate_effect({
        message = localize({type='name_text', set='tbp_module', key=module_def.key}) .. ' equipped!',
        colour = G.C.GREEN
    }, spaceship)
    card:start_dissolve()
    if G.GAME.module_replace_overlay then
        G.GAME.module_replace_overlay:remove()
        G.GAME.module_replace_overlay = nil
    end
end
G.FUNCS.module_replace_no = function(e)
    local module_def = e.config.ref_table.module_def
    spaceship_ease(-1)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
                local new_card = create_card('tbp_module', G.consumeables, nil, nil, nil, nil, module_def.key)
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

G.FUNCS.show_module_replace_confirm = function(old_module_key, new_module_key, card, module_def, slot, spaceship)
    local new_name = localize({type='name_text', set='tbp_module', key=new_module_key})
    local is_empty = not old_module_key
    local slot_colour = Wormhole.tbp.module_colours[slot] or G.C.UI.TEXT_INACTIVE
    local desc_base_colour = darken(slot_colour, 0.3)
    local old_name, old_desc_nodes, old_module_info
    if is_empty then
        old_name = "Empty Slot"
        old_desc_nodes = {{n=G.UIT.R, config={align = "cl", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = "No module equipped", scale = 0.35, colour = mix_colours(G.ARGS.LOC_COLOURS.inactive, desc_base_colour, 0.5)}}
        }}}
    else
        old_name = localize({type='name_text', set='tbp_module', key=old_module_key})
        old_module_info = spaceship.ability.extra.modules[slot]
        local old_loc_vars = G.P_CENTERS[old_module_key]:loc_vars({}, {ability = {extra = old_module_info}})
        old_loc_vars.text_colour = desc_base_colour
        local old_desc_table = G.localization.descriptions.tbp_module[old_module_key]
        old_desc_nodes = {}
        if old_desc_table and old_desc_table.text then
            for _, line in ipairs(old_desc_table.text) do
                old_desc_nodes[#old_desc_nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes=SMODS.localize_box(loc_parse_string(line), old_loc_vars)}
            end
        end
    end
    local new_module_info = {
        durability = module_def.durability,
        total_durability = module_def.durability,
    }
    local new_loc_vars = G.P_CENTERS[new_module_key]:loc_vars({}, {ability = {extra = module_def.config.extra}})
    new_loc_vars.text_colour = desc_base_colour
    local new_desc_table = G.localization.descriptions.tbp_module[new_module_key]
    local new_desc_nodes = {}
    if new_desc_table and new_desc_table.text then
        for _, line in ipairs(new_desc_table.text) do
            new_desc_nodes[#new_desc_nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes=SMODS.localize_box(loc_parse_string(line), new_loc_vars)}
        end
    end
    local dialog_data = {
        card = card,
        module_def = module_def,
        slot = slot,
        spaceship = spaceship
    }
    local dialog_title = is_empty and "Equip Module?" or "Replace Module?"
    local old_label = is_empty and "Empty Slot:" or "Current:"
    local slot_strip_label = ((slot and (slot:sub(1,1):upper() .. slot:sub(2))) or "Module") .. ":"
    local panel_strip_colour = darken(slot_colour, 0.4)
    local panel_shell_colour = panel_strip_colour
    local panel_face_colour = lighten(slot_colour, 0.4)
    local panel_text_colour = desc_base_colour
    local inactive_slot_text_colour = mix_colours(G.ARGS.LOC_COLOURS.inactive, desc_base_colour, 0.5)
    local durability_bar_bg = mix_colours(G.C.BLACK, slot_colour, 0.8)
    local function make_durability_row(module_info)
        return {n=G.UIT.R, config={align = 'cm', r = 0.06, w = 2.96, h = 0.3, colour = durability_bar_bg, outline = 0.5, outline_colour = darken(panel_strip_colour, 0.3),
            progress_bar = {
                max = module_info.total_durability,
                ref_table = module_info,
                ref_value = 'durability',
                empty_col = durability_bar_bg,
                filled_col = adjust_alpha(slot_colour, 0.5)
            }
        }, nodes = {
            {n=G.UIT.T, config = {text = module_info.durability .. ' turns', colour = mix_colours(lighten(slot_colour, 0.3), desc_base_colour, 0.3), scale = 0.28}}
        }}
    end
    local old_name_colour = is_empty and inactive_slot_text_colour or panel_text_colour
    local old_label_colour = is_empty and inactive_slot_text_colour or panel_text_colour
    local old_panel_nodes = {
        {n=G.UIT.R, config={align = "cl", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = old_label .. " ", scale = 0.3, colour = old_label_colour}},
            {n=G.UIT.T, config={text = old_name, scale = 0.45, colour = old_name_colour}}
        }}
    }
    for _, desc_row in ipairs(old_desc_nodes) do
        old_panel_nodes[#old_panel_nodes+1] = desc_row
    end
    if old_module_info then
        old_panel_nodes[#old_panel_nodes+1] = make_durability_row(old_module_info)
    else
        old_panel_nodes[#old_panel_nodes+1] = {n=G.UIT.R, config={align = 'cm', r = 0.06, w = 2.96, h = 0.3, colour = mix_colours(G.C.BLACK, G.C.UI.TEXT_INACTIVE, 0.8), outline = 0.5, outline_colour = mix_colours(panel_strip_colour, G.C.UI.TEXT_INACTIVE, 0.5)}, nodes = {
            {n=G.UIT.T, config = {text = '0 turns', colour = inactive_slot_text_colour, scale = 0.25}}
        }}
    end
    local new_panel_nodes = {
        {n=G.UIT.R, config={align = "cl", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = "New: ", scale = 0.3, colour = panel_text_colour}},
            {n=G.UIT.T, config={text = new_name, scale = 0.45, colour = panel_text_colour}}
        }}
    }
    for _, desc_row in ipairs(new_desc_nodes) do
        new_panel_nodes[#new_panel_nodes+1] = desc_row
    end
    new_panel_nodes[#new_panel_nodes+1] = make_durability_row(new_module_info)
    
    local t = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR, padding = 0, minh = G.ROOM.T.h, minw = G.ROOM.T.w}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.1, colour = G.C.BLACK, emboss = 0.05}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
            {n=G.UIT.T, config={text = dialog_title, scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.06}, nodes={
            {n=G.UIT.C, config={align = "cm", w = 3.6, h = 3.75}, nodes={
                {n=G.UIT.R, config={align = "cm", r=0.1, padding = 0.06, colour = panel_shell_colour, outline = 2, outline_colour = panel_strip_colour}, nodes={
                    {n=G.UIT.C, config={align = "cm", colour = panel_strip_colour, padding = 0.14}, nodes={
                        {n=G.UIT.T, config={text = slot_strip_label, scale = 0.24, colour = G.C.UI.TEXT_LIGHT, vert = true}}
                    }},
                    {n=G.UIT.C, config={align = "cl", padding = 0.02, colour = panel_face_colour}, nodes={
                        {n=G.UIT.C, config={align = "cl", r=0.08, padding = 0.02, w = 5.625, colour = panel_face_colour}, nodes=old_panel_nodes}
                    }}
                }}
            }},
            {n=G.UIT.C, config={align = "cm", w = 3.6, h = 3.75, padding = 0.27}, nodes={
                {n=G.UIT.R, config={align = "cm", r=0.1, padding = 0.06, colour = panel_shell_colour, outline = 2, outline_colour = panel_strip_colour}, nodes={
                    {n=G.UIT.C, config={align = "cm", colour = panel_strip_colour, padding = 0.14}, nodes={
                        {n=G.UIT.T, config={text = slot_strip_label, scale = 0.24, colour = G.C.UI.TEXT_LIGHT, vert = true}}
                    }},
                    {n=G.UIT.C, config={align = "cl", padding = 0.02, colour = panel_face_colour}, nodes={
                        {n=G.UIT.C, config={align = "cl", r=0.08, padding = 0.02, w = 5.625, colour = panel_face_colour}, nodes=new_panel_nodes}
                    }}
                }}
            }}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes=(function()
            local yes_button = {n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
                UIBox_button({
                    label = {"Yes"},
                    button = "module_replace_yes",
                    ref_table = dialog_data,
                    w = 1.3,
                    h = 0.5,
                    colour = G.C.GREEN,
                    scale = 0.35
                })
            }}
            local no_button = {n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
                UIBox_button({
                    label = {"No"},
                    button = "module_replace_no",
                    ref_table = dialog_data,
                    w = 1.3,
                    h = 0.5,
                    colour = G.C.RED,
                    scale = 0.35
                })
            }}
            if Wormhole.tbp.config.swap_buttons then
                return {yes_button, no_button}
            else
                return {no_button, yes_button}
            end
        end)()}
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
            table.insert(Wormhole.tbp.shader_draw_stuff, G.GAME.module_replace_overlay)
            return true
        end
    }), "module_replace_dialog")
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