function G.FUNCS.Wormhole_TLR_emperor(e)
    local args = e or {}
    if args.config and args.config.ref_table then args = args.config.ref_table end
    args.instant = args.instant or false

    G.FUNCS.overlay_menu{
        definition = G.UIDEF.Wormhole_TLR_emperor() or {n = G.UIT.ROOT, config = {minw = 6, minh = 2, colour = G.C.GREEN}}
    }
end