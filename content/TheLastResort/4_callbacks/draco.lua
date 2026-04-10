function G.FUNCS.Wormhole_TLR_draco(e)

    local args = e or {}
    if args.config and args.config.ref_table then args = args.config.ref_table end
    args.instant = args.instant or false
    args.max_selected = args.max_selected or 2
    if args.add and #args.selected_cards < args.max_selected then
        table.insert(args.selected_cards, args.add)
    end
    if args.remove then
        table.remove(args.selected_cards, args.remove)
    end

    --G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = G.UIDEF.Wormhole_TLR_draco(e),
        config = {
            offset = args.instant and {x = 0, y = 0} or nil,
            no_esc = true
        }
    }
end

function G.FUNCS.Wormhole_TLR_draco_confirm(e)
    G.FUNCS.exit_overlay_menu()
    --G.SETTINGS.paused = false
    local args = e or {}
    
    if args.config and args.config.ref_table then args = args.config.ref_table end
    for i,v in ipairs(args.selected_keys) do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = (function()
                add_tag(Tag(v))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                return true
            end)
        }))
    end
end