function G.UIDEF.Wormhole_TLR_emperor(args)
    args = args or {}

    local t = create_UIBox_generic_options{
        contents = {
            {n=G.UIT.R, config={align = "cm", minw = 2.5, minh = 1, colour = G.C.BLACK, r = 0.1}, nodes={}},
        }
    }
    return t or {n = G.UIT.ROOT, config = {minw = 6, minh = 2, colour = G.C.BLUE}}
end