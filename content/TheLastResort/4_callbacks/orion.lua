function G.FUNCS.Wormhole_TLR_orion(e)
    local args = e or {}
    if args.config and args.config.ref_table then args = args.config.ref_table end
    args.instant = args.instant or false

    local off = args.instant and {x = 0, y = 0} or nil
    G.FUNCS.overlay_menu{
        definition = G.UIDEF.Wormhole_TLR_orion(args),
        config = {
            offset = off,
            no_esc = true
        }
    }
end

function G.FUNCS.Wormhole_TLR_orion_confirm(e)
    local args = e or {}
    if args.config and args.config.ref_table then args = args.config.ref_table end

    stop_use()
    G.GAME.round_resets.boss_rerolled = true
    G.CONTROLLER.locks.boss_reroll = true
    G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
            play_sound('other1')
            G.blind_select_opts.boss:set_role({xy_bond = 'Weak'})
            G.blind_select_opts.boss.alignment.offset.y = 20
            return true
            end
        }))
    G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0.3,
    func = (function()
        local par = G.blind_select_opts.boss.parent
        G.GAME.round_resets.blind_choices.Boss = args.key

        G.blind_select_opts.boss:remove()
        G.blind_select_opts.boss = UIBox{
        T = {par.T.x, 0, 0, 0, },
        definition =
            {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
            UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
            }},
        config = {align="bmi",
                    offset = {x=0,y=G.ROOM.T.y + 9},
                    major = par,
                    xy_bond = 'Weak'
                }
        }
        par.config.object = G.blind_select_opts.boss
        par.config.object:recalculate()
        G.blind_select_opts.boss.parent = par
        G.blind_select_opts.boss.alignment.offset.y = 0
        
        G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
            G.CONTROLLER.locks.boss_reroll = nil
            return true
        end
        }))

        save_run()
        for i = 1, #G.GAME.tags do
        if G.GAME.tags[i]:apply_to_run({type = 'new_blind_choice'}) then break end
        end
        return true
    end)
    }))

    G.FUNCS.exit_overlay_menu()
end