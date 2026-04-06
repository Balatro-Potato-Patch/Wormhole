local tbp_hook_info_tip_from_rows = info_tip_from_rows
function info_tip_from_rows(desc_nodes, name)
    if desc_nodes.tbp_module then
        local col = Wormhole.tbp.module_colours[desc_nodes.tbp_module]
        local durability_col = mix_colours(G.C.BLACK, col, 0.8)
        local t = {}
        for k, v in ipairs(desc_nodes) do
            t[#t+1] = {n=G.UIT.R, config={align = "cm"}, nodes=v}
        end
        return {n=G.UIT.C, nodes = {
            {n=G.UIT.R, config = {align = 'cm', colour = col}, nodes = {
                {n=G.UIT.C, config = {align = 'cm', colour = darken(col, 0.4), padding = 0.1}, nodes = {
                    {n=G.UIT.T, config={text = localize('tbp_module_'..desc_nodes.tbp_module), scale = 0.32, colour = G.C.UI.TEXT_LIGHT, vert = true}}
                }},
                {n=G.UIT.C, config = {align = 'cm', padding = 0.05, colour = lighten(col, 0.4)}, nodes = {
                    {n=G.UIT.R, config={align = "cm", minw = 1.5, minh = 0.4, r = 0.1, padding = 0.05, colour = lighten(col, 0.4)}, nodes={
                        {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=t}
                    }},
                    desc_nodes.module_info and {n=G.UIT.R, config = {align = 'cm', r = 0.1, minw = 0.5, minh = 0.2, colour = durability_col, outline = 1, outline_colour = darken(col, 0.15),
                        progress_bar = {
                            max = desc_nodes.module_info.total_durability, ref_table = desc_nodes.module_info, ref_value = 'durability', empty_col = durability_col, filled_col = adjust_alpha(col, 0.8)
                        }
                    }, nodes = {
                        {n=G.UIT.T, config = {text = desc_nodes.module_info.durability .. ' turns', colour = lighten(col, 0.3), scale = 0.2}}
                    }} or nil
                }}
            }},
            
        }}
    else
        return tbp_hook_info_tip_from_rows(desc_nodes, name)
    end
end

G.FUNCS.show_spaceship_tooltips = function(e)
    if e.config.ref_table then 
        e.children.info = UIBox{
            definition = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.02}, nodes=e.config.ref_table},
            config = {offset = {x=0.03,y=0}, align = 'cr', parent = e}}
        e.children.info:align_to_major()
        e.config.ref_table = nil
    end
end
local function parse_colored_text(text, scale)
    local nodes = {}
    local current_color = G.C.UI.TEXT_LIGHT
    local pos = 1
    while pos <= #text do
        -- Look for color code {C:name}
        local color_start, color_end, color_name = text:find("{C:([^}]+)}", pos)
        if color_start then
            if color_start > pos then
                local before_text = text:sub(pos, color_start - 1)
                if before_text ~= "" then
                    nodes[#nodes+1] = {n=G.UIT.T, config={text = before_text, scale = scale, colour = current_color}}
                end
            end
            current_color = (G.ARGS.LOC_COLOURS and G.ARGS.LOC_COLOURS[color_name]) or G.C[color_name] or G.C.UI.TEXT_LIGHT
            pos = color_end + 1
        else
            local reset_start, reset_end = text:find("{}", pos)
            if reset_start then
                if reset_start > pos then
                    local before_text = text:sub(pos, reset_start - 1)
                    if before_text ~= "" then
                        nodes[#nodes+1] = {n=G.UIT.T, config={text = before_text, scale = scale, colour = current_color}}
                    end
                end
                current_color = G.C.UI.TEXT_LIGHT
                pos = reset_end + 1
            else
                local remaining = text:sub(pos)
                if remaining ~= "" then
                    nodes[#nodes+1] = {n=G.UIT.T, config={text = remaining, scale = scale, colour = current_color}}
                end
                break
            end
        end
    end
    
    return nodes
end
G.FUNCS.module_replace_yes = function(e)
    local card = e.config.ref_table.card
    local module_def = e.config.ref_table.module_def
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
    local old_name, old_durability, old_desc_nodes
    if is_empty then
        old_name = "Empty Slot"
        old_durability = "0/0"
        old_desc_nodes = {{n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = "No module equipped", scale = 0.25, colour = G.C.UI.TEXT_INACTIVE}}
        }}}
    else
        old_name = localize({type='name_text', set='tbp_module', key=old_module_key})
        local old_module_data = spaceship.ability.extra.modules[slot]
        old_durability = old_module_data.durability .. "/" .. old_module_data.total_durability
        local old_loc_vars = G.P_CENTERS[old_module_key]:loc_vars({}, {ability = {extra = old_module_data}})
        local old_vars = (old_loc_vars and old_loc_vars.vars) or {}
        local old_desc_table = G.localization.descriptions.tbp_module[old_module_key]
        old_desc_nodes = {}
        if old_desc_table and old_desc_table.text then
            for _, line in ipairs(old_desc_table.text) do
                -- Replace variables
                local text = line
                for j, var in ipairs(old_vars) do
                    text = text:gsub("#" .. j .. "#", tostring(var))
                end
                local colored_nodes = parse_colored_text(text, 0.25)
                old_desc_nodes[#old_desc_nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes=colored_nodes}
            end
        end
    end
    local new_durability = module_def.durability .. "/" .. module_def.durability
    local new_loc_vars = G.P_CENTERS[new_module_key]:loc_vars({}, {ability = {extra = module_def.config.extra}})
    local new_vars = (new_loc_vars and new_loc_vars.vars) or {}
    local new_desc_table = G.localization.descriptions.tbp_module[new_module_key]
    local new_desc_nodes = {}
    if new_desc_table and new_desc_table.text then
        for _, line in ipairs(new_desc_table.text) do
            local text = line
            for j, var in ipairs(new_vars) do
                text = text:gsub("#" .. j .. "#", tostring(var))
            end
            local colored_nodes = parse_colored_text(text, 0.25)
            new_desc_nodes[#new_desc_nodes+1] = {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes=colored_nodes}
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
    local old_panel_colour = is_empty and G.C.UI.TEXT_INACTIVE or G.C.RED
    local old_name_colour = is_empty and G.C.UI.TEXT_INACTIVE or G.C.RED
    local old_panel_nodes = {
        {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = old_label .. " ", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE}},
            {n=G.UIT.T, config={text = old_name, scale = 0.45, colour = old_name_colour}}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = "Info:", scale = 0.28, colour = G.C.UI.TEXT_INACTIVE}}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = "Durability: " .. old_durability, scale = 0.28, colour = G.C.UI.TEXT_LIGHT}}
        }}
    }
    for _, desc_row in ipairs(old_desc_nodes) do
        old_panel_nodes[#old_panel_nodes+1] = desc_row
    end
    local new_panel_nodes = {
        {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = "New: ", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE}},
            {n=G.UIT.T, config={text = new_name, scale = 0.45, colour = G.C.GREEN}}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = "Info:", scale = 0.28, colour = G.C.UI.TEXT_INACTIVE}}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.02}, nodes={
            {n=G.UIT.T, config={text = "Durability: " .. new_durability, scale = 0.28, colour = G.C.UI.TEXT_LIGHT}}
        }}
    }
    for _, desc_row in ipairs(new_desc_nodes) do
        new_panel_nodes[#new_panel_nodes+1] = desc_row
    end
    
    local t = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR, padding = 0, minh = G.ROOM.T.h, minw = G.ROOM.T.w}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.1, colour = G.C.BLACK, emboss = 0.05}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
            {n=G.UIT.T, config={text = dialog_title, scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0.1, r=0.1, colour = mix_colours(old_panel_colour, G.C.BLACK, 0.8)}, nodes=old_panel_nodes},
            {n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
                {n=G.UIT.T, config={text = "→", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
            }},
            {n=G.UIT.C, config={align = "cm", padding = 0.1, r=0.1, colour = mix_colours(G.C.GREEN, G.C.BLACK, 0.8)}, nodes=new_panel_nodes}
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
                UIBox_button({
                    label = {"Yes"},
                    button = "module_replace_yes",
                    ref_table = dialog_data,
                    w = 1.3,
                    h = 0.5,
                    colour = G.C.GREEN,
                    scale = 0.35
                })
            }},
            {n=G.UIT.C, config={align = "cm", padding = 0.05}, nodes={
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
        }}
        }}
    }}
    G.E_MANAGER.queues.module_replace_dialog = G.E_MANAGER.queues.module_replace_dialog or {}
    
    G.E_MANAGER:add_event(Event({
        func = function()
            G.GAME.module_replace_overlay = UIBox{
                definition = t,
                config = {align="cm", offset = {x=0,y=0}, instance_type = 'CARD', major = G.ROOM_ATTACH, bond = 'Weak', draggable = true, collideable = true, can_collide = true}
            }
            G.GAME.module_replace_overlay:align_to_major()
            G.GAME.module_replace_overlay.config.major = nil
            G.GAME.module_replace_overlay:set_role{role_type = 'Major'}
            return true
        end
    }), "module_replace_dialog")
end  