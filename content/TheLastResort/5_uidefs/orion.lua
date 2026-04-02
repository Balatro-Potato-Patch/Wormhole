function G.UIDEF.Wormhole_TLR_orion(args)
    args = args or {}
    args.rerolls_left = args.rerolls_left or 0
    args.allow = args.allow or {non_boss = false, standard = true, showdown = false}
    args.instant = true
    local function reload(s_args)
        s_args = {config = {ref_table = s_args or {}}}
        local ret = {}
        for k,v in pairs(args) do
            ret[k] = s_args.config.ref_table[k] or v
        end
        return ret
    end

    local reroll_section = {
        {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {ref_table = args, ref_value = 'rerolls_left', scale = 1, colour = G.C.WHITE}}}},
        {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {text = localize("k_worm_tlr_orion_rerolls_left_1"), scale = 0.8, colour = G.C.WHITE}}}},
        {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {text = localize("k_worm_tlr_orion_rerolls_left_2"), scale = 0.8, colour = G.C.WHITE}}}},
        {n = G.UIT.R, config = {minh = 2}},
        UIBox_button{
            label = {localize("k_reroll")},
            minw = 3.5,
            mihh = 3.2,
            ref_table = reload{rerolls_left = args.rerolls_left - 1},
            button = args.rerolls_left > 0 and 'Wormhole_TLR_orion' or 'nil',
            colour = not (args.rerolls_left > 0) and G.C.GREY
        }
    }
    local blinds = {}

    local blind_choices = {}
    for _, v in pairs(G.P_BLINDS) do

        -- for the love of god I can't figure out how to separate blinds into non_boss, boss and showdown
        local is_boss = v.boss ~= nil and v.boss.showdown == nil
        local is_showdown = v.boss and v.boss.showdown ~= nil
        --print(("blind: %s, boss: %s, showdown: %s"):format(v.key, is_boss, is_showdown))
        if (args.allow.non_boss and not is_boss)
        or (args.allow.standard and is_boss )
        or (args.allow.showdown and is_showdown) then
            --print("Added!")
            table.insert(blind_choices,v.key)
        end
    end

    if #blind_choices < 2 then
        for i=1, 2 do
            table.insert(blind_choices,'bl_small')
        end
    end

    for i=1, 2 do
        local choice_i = pseudorandom('orion',1,#blind_choices)
        local choice = blind_choices[choice_i]
        if not choice then error("No blind found!") end
        local blind_col = get_blind_main_colour(choice)
        --local blind_amt = get_blind_amount(G.GAME.round_resets.blind_ante)*G.P_BLINDS[choice].config.mult*G.GAME.starting_params.ante_scaling

        local blind_sprite = AnimatedSprite(0,0, 2, 2, G.ANIMATION_ATLAS['blind_chips'],  G.P_BLINDS[choice].pos)

        local desc_nodes = {
            --{n = G.UIT.R, config = {align = "cm"}, nodes = {{n = G.UIT.T, config = {align = "cm", text = "Line 1", scale = 0.55, colour = G.C.WHITE}}}},
            --{n = G.UIT.R, config = {align = "cm"}, nodes = {{n = G.UIT.T, config = {align = "cm", text = "Line 2", scale = 0.55, colour = G.C.WHITE}}}},
        }

        for i,v in ipairs(localize{type = "raw_descriptions", set = "Blind", key = choice, vars = {localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}}) do
            table.insert(desc_nodes,
                {n = G.UIT.R, config = {align = "cm"}, nodes = {{n = G.UIT.T, config = {align = "cm", text = v, scale = 0.35, colour = G.C.WHITE}}}}
            )
        end

        local n = {n = G.UIT.C, config = {align = "cm", minw = 5, minh = 8, colour = G.C.BLACK, r = 0.2, outline_colour = blind_col, outline = 1.5, id = ("blind_choice_%d"):format(i), padding = 0}, nodes = {
            {n = G.UIT.R, config = {align = 'cm', minw = 1, minh = 1, colour = G.C.CLEAR}, nodes = {{n = G.UIT.O, config = {object = blind_sprite}}}},
            {n = G.UIT.R, config = {minh = 0.4}},
            {n = G.UIT.R, config = {align = 'cm', minh = 1}, nodes = {{n = G.UIT.T, config = {text = localize{type = "name_text", set = "Blind", key = choice}, scale = 0.55, colour = G.C.WHITE}}}},
            {n = G.UIT.R, config = {align = 'cm', minh = 2}, nodes = desc_nodes},
            {n = G.UIT.R, config = {minh = 0.4}},
            UIBox_button{
                label = {localize("k_choose")},
                minw = 4,
                minh = 1,
                ref_table = {key = choice},
                button = 'Wormhole_TLR_orion_confirm'
            }
        }}

        table.insert(blinds, n)
        table.remove(blind_choices, choice_i)
    end

    local t = create_UIBox_generic_options{
        no_back = true,
        contents = {
            {n = G.UIT.R, config = {minw = 12, minh = 8, colour = G.C.CLEAR, align = "cm", padding = 0}, nodes = {
                {n = G.UIT.C, config = {minw = 5, align = 'cm', padding = 0, colour = G.C.BLACK, r = 0.2}, nodes = reroll_section},
                {n = G.UIT.C, config = {minw = 12, align = 'cm', padding = 0.2}, nodes = blinds},
            }}
        }
    }
    return t
end