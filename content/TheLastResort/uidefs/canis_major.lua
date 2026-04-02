function G.UIDEF.Wormhole_TLR_canis_major(args)
    args = args or {}
    args.page = args.page or 1

    --local t = SMODS.ConsumableTypes['worm_tlr_constellation']:create_UIBox_your_collection()
    --[[
    table.remove(t.nodes[1].nodes[1].nodes,2)
    temp = t
    ]]
    local card_containers = {}
    local selected_containers = args.selected or {}


    for i, v in ipairs({"", "", "", "", "", ""} or G.P_CENTER_POOLS['worm_tlr_constellation']) do
        if i > (args.page-1)*5 and i <= args.page*5 then
            local entry = {n = G.UIT.C, config = {align = 'cm', padding = 0.2}, nodes = {
                {n = G.UIT.R, config = {minw = G.CARD_W, minh = G.CARD_H, colour = G.C.WHITE}},
                UIBox_button{
                    label = {"Add"},
                    minw = G.CARD_W*0.8,
                    minh = 0.6
                }
            }}
            table.insert(card_containers, entry)
        end
    end

    for i, v in ipairs({"", "", ""} or G.P_CENTER_POOLS['worm_tlr_constellation']) do
        if i > (args.page-1)*2 and i <= args.page*2 then
            local entry = {n = G.UIT.C, config = {align = 'cm', padding = 0.2}, nodes = {
                {n = G.UIT.R, config = {minw = G.CARD_W, minh = G.CARD_H, colour = G.C.WHITE}},
                UIBox_button{
                    label = {"Remove"},
                    minw = G.CARD_W*0.8,
                    minh = 0.6
                }
            }}
            table.insert(selected_containers, entry)
        end
    end

    local t = create_UIBox_generic_options{
        no_back = true,
        contents = {
            {n=G.UIT.R, config={align = "cm", minw = 8, minh = 1, colour = G.C.BLACK, r = 0.1}, nodes={
                {n = G.UIT.R, config = {align = 'cm', padding = 0.1}, nodes = {
                    {n = G.UIT.C, nodes = {UIBox_button{
                        label = {"<"},
                        minw = 0.6,
                        minh = G.CARD_H
                    }}},
                    {n = G.UIT.C, nodes = card_containers},
                    {n = G.UIT.C, nodes = {UIBox_button{
                        label = {">"},
                        minw = 0.6,
                        minh = G.CARD_H
                    }}}
                }},
                {n = G.UIT.R, config = {align = 'cl', padding = 0}, nodes = {
                    {n = G.UIT.C, config = {padding = 0}, nodes = {
                        {n = G.UIT.C, nodes = {UIBox_button{
                            label = {"<"},
                            minw = 0.6,
                            minh = G.CARD_H
                        }}},
                        {n = G.UIT.C, nodes = selected_containers},
                        {n = G.UIT.C, nodes = {UIBox_button{
                            label = {">"},
                            minw = 0.6,
                            minh = G.CARD_H
                        }}}
                    }},
                    {n = G.UIT.C, config = {minw = 0.25}},
                    {n = G.UIT.C, config = {minw = 2, align = 'cr', padding = 0.1}, nodes = {
                        {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {scale = 0.8, text = "2/2", colour = G.C.WHITE}}}},
                        {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {scale = 0.8, text = "Selected", colour = G.C.WHITE}}}},
                        {n = G.UIT.R, config = {align = 'cm'}, nodes = {UIBox_button{
                            label = {"Confirm"},
                            minw = 3,
                            minh = 1
                        }}}
                    }},
                }},
            }},
        }
    }
    return t or {n = G.UIT.ROOT, config = {minw = 6, minh = 2, colour = G.C.BLUE}}
end