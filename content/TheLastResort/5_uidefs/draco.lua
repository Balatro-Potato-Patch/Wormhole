function G.UIDEF.Wormhole_TLR_draco(args)
    args = args or {}
    if args.config and args.config.ref_table then args = args.config.ref_table end
    args.page = args.page or 1
    args.selected_page = args.selected_page or 1
    args.selected_cards = args.selected_cards or {}

    args.max_choices = args.max_choices or 3
    args.choices = args.choices or {}
    local pool = {}

    for _, v in ipairs(G.P_CENTER_POOLS["Tag"]) do
        pool[#pool+1] = v.key
    end

    for i=1, args.max_choices do
        local index = pseudorandom("wormhole", 1, #pool)
        table.insert(args.choices, pool[index])
        table.remove(pool, index)
    end

    local cards_per_page = 5
    local selected_per_page = 3

    local card_containers = {}
    local selected_containers = {}

    local function reload (sub_args)
        sub_args = sub_args or {}
        sub_args.page = sub_args.page or args.page
        sub_args.selected_page = sub_args.selected_page or args.selected_page
        sub_args.selected_cards = sub_args.selected_cards or args.selected_cards

        return {
            page = sub_args.page,
            selected_page = sub_args.selected_page,
            selected_cards = sub_args.selected_cards,
            instant = true,
            add = sub_args.add,
            remove = sub_args.remove,
            max_selected = args.max_selected,
            negative = args.negative,
            max_choices = 0,
            choices = args.choices
        }
    end

    for i, v in ipairs(args.choices) do
        if i > (args.page-1)*cards_per_page and i <= args.page*cards_per_page then
            if not v then break end
            --local area = CardArea(G.CARD_W/2, G.CARD_H/2, G.CARD_W, G.CARD_H, {type = "title"})

            local temp_tag = Tag(v, true)
            local temp_tag_ui = temp_tag:generate_UI(1.4)

            local entry = {n = G.UIT.C, config = {align = 'cm', padding = 0.2}, nodes = {
                {n = G.UIT.R, config = {align = "cm", minw = G.CARD_W, minh = G.CARD_H, colour = G.C.CLEAR}, nodes = {
                    {n = G.UIT.R, config = {align = 'cm'}, nodes = {temp_tag_ui}}
                }},
                UIBox_button{
                    label = {localize("k_worm_tlr_add")},
                    minw = G.CARD_W*0.8,
                    minh = 0.6,
                    ref_table = reload{add = v},
                    button = #args.selected_cards < args.max_selected and "Wormhole_TLR_draco" or "nil",
                    colour = not (#args.selected_cards < args.max_selected) and G.C.GREY or nil
                }
            }}
            table.insert(card_containers, entry)
        end
    end

    for i, v in ipairs(args.selected_cards) do
        if i > (args.selected_page-1)*selected_per_page and i <= args.selected_page*selected_per_page then
            if not v then break end
            local temp_tag = Tag(v, true)
            local temp_tag_ui = temp_tag:generate_UI(1.4)

            local entry = {n = G.UIT.C, config = {align = 'cm', padding = 0.2}, nodes = {
                {n = G.UIT.R, config = {align = "cm", minw = G.CARD_W, minh = G.CARD_H, colour = G.C.CLEAR}, nodes = {
                    {n = G.UIT.R, config = {align = 'cm'}, nodes = {temp_tag_ui}}
                }},
                UIBox_button{
                    label = {localize("k_worm_tlr_remove")},
                    minw = G.CARD_W*0.8,
                    minh = 0.6,
                    ref_table = reload{remove = i},
                    button = "Wormhole_TLR_draco",
                }
            }}
            table.insert(selected_containers, entry)
        end
    end

    for i = #card_containers, cards_per_page - 1 do
        local entry = {n = G.UIT.C, config = {align = 'cm', padding = 0.2}, nodes = {
            {n = G.UIT.R, config = {minw = G.CARD_W, minh = G.CARD_H, colour = G.C.CLEAR}, nodes = {
            }},
            UIBox_button{
                label = {""},
                minw = G.CARD_W*0.8,
                minh = 0.6,
                button = 'nil',
                colour = G.C.CLEAR
            }
        }}
        table.insert(card_containers, entry)
    end
    for i = #selected_containers, selected_per_page - 1 do
        local entry = {n = G.UIT.C, config = {align = 'cm', padding = 0.2}, nodes = {
            {n = G.UIT.R, config = {minw = G.CARD_W, minh = G.CARD_H, colour = G.C.CLEAR}, nodes = {
            }},
            UIBox_button{
                label = {""},
                minw = G.CARD_W*0.8,
                minh = 0.6,
                button = 'nil',
                colour = G.C.CLEAR
            }
        }}
        table.insert(selected_containers, entry)
    end

    local t = create_UIBox_generic_options{
        no_back = true,
        contents = {
            {n=G.UIT.R, config={align = "cm", minw = 8, minh = 1, colour = G.C.BLACK, r = 0.1}, nodes={
                {n = G.UIT.R, config = {align = 'cm', padding = 0.1, minh = 3}, nodes = {
                    {n = G.UIT.C, nodes = {UIBox_button{
                        label = {"<"},
                        minw = 0.6,
                        minh = G.CARD_H,
                        ref_table = reload{page = args.page - 1},
                        button = args.page > 1 and "Wormhole_TLR_draco" or 'nil',
                        colour = args.page <= 1 and G.C.GREY or nil
                    }}},
                    {n = G.UIT.C, nodes = card_containers},
                    {n = G.UIT.C, nodes = {UIBox_button{
                        label = {">"},
                        minw = 0.6,
                        minh = G.CARD_H,
                        ref_table = reload{page = args.page + 1},
                        button = args.page < #args.choices/cards_per_page and "Wormhole_TLR_draco" or 'nil',
                        colour = args.page >= #args.choices/cards_per_page and G.C.GREY or nil
                    }}}
                }},
                {n = G.UIT.R, config = {align = 'cl', padding = 0}, nodes = {
                    {n = G.UIT.C, config = {padding = 0}, nodes = {
                        {n = G.UIT.C, nodes = {UIBox_button{
                            label = {"<"},
                            minw = 0.6,
                            minh = G.CARD_H,
                            ref_table = reload{selected_page = args.selected_page - 1},
                            button = args.selected_page > 1 and "Wormhole_TLR_draco" or 'nil',
                            colour = not (args.selected_page > 1) and G.C.GREY or nil
                        }}},
                        {n = G.UIT.C, config = {minw = 7}, nodes = selected_containers},
                        {n = G.UIT.C, nodes = {UIBox_button{
                            label = {">"},
                            minw = 0.6,
                            minh = G.CARD_H,
                            ref_table = reload{selected_page = args.selected_page + 1},
                            button = args.selected_page < #args.selected_cards/selected_per_page and "Wormhole_TLR_draco" or 'nil',
                            colour = not (args.selected_page < #args.selected_cards/selected_per_page) and G.C.GREY or nil
                        }}}
                    }},
                    {n = G.UIT.C, config = {minw = 0.25}},
                    {n = G.UIT.C, config = {minw = 2, align = 'cr', padding = 0.1}, nodes = {
                        {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {scale = 0.8, text = ("%d/%d"):format(#args.selected_cards,args.max_selected), colour = G.C.WHITE}}}},
                        {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {scale = 0.8, text = localize("k_worm_tlr_selected"), colour = G.C.WHITE}}}},
                        {n = G.UIT.R, config = {minh = 0.5}},
                        {n = G.UIT.R, config = {align = 'cm'}, nodes = {UIBox_button{
                            label = {localize("k_worm_tlr_confirm")},
                            minw = 4,
                            minh = 0.7,
                            ref_table = {selected_keys = args.selected_cards, negative = args.negative},
                            button = "Wormhole_TLR_draco_confirm",
                        }}}
                    }},
                }},
                {n = G.UIT.R, config = {minh = 0.2}}
            }},
        }
    }
    return t
end