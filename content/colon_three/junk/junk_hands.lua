if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

local meta_calc_ref = PotatoPatchUtils.Developers.worm_meta.calculate
PotatoPatchUtils.Developers.worm_meta.calculate = function(self, context)
    if context.evaluate_poker_hand then
        local junks = false
        local non_junks = false
        for i, v in ipairs(context.full_hand) do
            if SMODS.has_enhancement(v, "m_worm_ct_junk_card") then
                junks = true
                if non_junks then break end
            else
                non_junks = true
                if junks then break end
            end
        end
        if junks then
            local txt = "Junk"
            local replacement = txt .. " " .. context.display_name
            if replacement == "Junk High Card" and not non_junks then
                replacement = "Junk"
            end
            return {
                replace_display_name = replacement
            }
        end
    end
    if context.before then
        local junks = false
        for i, v in ipairs(context.full_hand) do
            if SMODS.has_enhancement(v, "m_worm_ct_junk_card") then
                junks = true
                break
            end
        end
        if junks then
            G.GAME.worm_times_played_junk = (G.GAME.worm_times_played_junk or 0) + 1
        end
    end
    return meta_calc_ref(self, context)
end

if Spectrallib and Spectrallib.ascend then
    local sasc = Spectrallib.ascend
    function Spectrallib.ascend(...)
        local cards = G.STATE == G.STATES.SELECTING_HAND and G.hand.highlighted or G.play.cards
        local junks = 0
        for i, v in pairs(cards) do
            if v.config.center.key == "m_worm_ct_junk_card" then junks = junks + 1 end
        end
        G.GAME.worm_c3_junk_stats.x_hand_stats = G.GAME.worm_c3_junk_stats.x_hand_stats or 1.5
        local junk_hands_mult = G.GAME.worm_c3_junk_stats.x_hand_stats ^ junks

        return sasc(...) * junk_hands_mult
    end
else
    local parse_highlighted = CardArea.parse_highlighted
    function CardArea:parse_highlighted(...)
        local text,disp_text,poker_hands,scoring = G.FUNCS.get_poker_hand_info(self.highlighted)
        local ret = parse_highlighted(self, ...)
        local backwards = nil
        for k, v in pairs(self.highlighted) do
            if v.facing == 'back' then
                backwards = true
            end
        end
        if backwards then return end
        if text and G.GAME.hands[text] then
            local junks = 0
            for i, v in pairs(self.highlighted) do
                if v.config.center.key == "m_worm_ct_junk_card" then junks = junks + 1 end
            end
            G.GAME.worm_c3_junk_stats.x_hand_stats = G.GAME.worm_c3_junk_stats.x_hand_stats or 1.5
            local junk_hands_mult = G.GAME.worm_c3_junk_stats.x_hand_stats ^ junks
            for name, parameter in pairs(SMODS.Scoring_Parameters) do
                if name == "chips" or name == "mult" then
                    parameter.current = parameter.current * junk_hands_mult
                    update_hand_text({immediate = true, nopulse = nil, delay = 0}, {[name] = parameter.current})
                end
            end
        end
        return ret
    end
end

-- display level in run info
-- patched in
function create_UIBox_junk_hand_row()
    local times_leveled = (G.GAME.worm_c3_junk_stats.x_hand_stats - 1.25) * 4
    local multiplier = G.GAME.worm_c3_junk_stats.x_hand_stats or 1.5
    return {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(Wormhole.COLON_THREE.C.JunkSet, 0.2), emboss = 0.05, hover = true, force_focus = true, 
        on_demand_tooltip = {text = localize("Junk Hands", 'poker_hand_descriptions'), filler = {func = create_UIBox_junk_hands_tip, args = "Junk Hands"}}
        }, 
        nodes={
            {n=G.UIT.C, config={align = "cl", padding = 0, minw = 4.5}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = G.C.HAND_LEVELS[math.min(7, times_leveled)], minw = 1.5, outline = 0.8, outline_colour = G.C.WHITE}, nodes={
                    {n=G.UIT.T, config={text = localize('k_level_prefix')..times_leveled, scale = 0.5, colour = G.C.UI.TEXT_DARK}}
                }},
                {n=G.UIT.C, config={align = "cm", minw = 4.5, maxw = 4.5}, nodes={
                    {n=G.UIT.T, config={text = ' '..localize("k_junk_hands"), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
                }}
            }},
            {n=G.UIT.C, config={align = "cr", padding = 0.05, colour = G.C.BLACK,r = 0.1}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = Wormhole.COLON_THREE.C.JunkSet , minw = 2.5}, nodes={
                    {n=G.UIT.T, config={text = "X"..number_format(multiplier, 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}},
                    {n=G.UIT.B, config={w = 0.08, h = 0.01}}
                }},
                -- {n=G.UIT.T, config={text = "X", scale = 0.45, colour = Wormhole.COLON_THREE.C.JunkSet}},
                -- {n=G.UIT.C, config={align = "cl", padding = 0.01, r = 0.1, colour = G.C.MULT , minw = 1.1}, nodes={
                --     {n=G.UIT.B, config={w = 0.08,h = 0.01}},
                --     {n=G.UIT.T, config={text = "X"..number_format(multiplier, 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}}
                -- }}
            }},
            {n=G.UIT.C, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = '  #', scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }},
            {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.L_BLACK,r = 0.1, minw = 0.9}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {tostring(G.GAME.worm_times_played_junk or 0)}, maxw = 0.9, scale = 0.45, colours = {G.C.FILTER}, shadow = true})}},
            }}
        }
    }
end

function create_UIBox_junk_hands_tip(handname)
    -- if not G.GAME.hands[handname].example then return {n=G.UIT.R, config={align = "cm"},nodes = {}} end 
    local cardarea = CardArea(
        2,2,
        3.5*G.CARD_W,
        0.75*G.CARD_H, 
        {card_limit = 5, type = 'title', highlight_limit = 0})
        
    for k, v in ipairs({
            {'S_A', true},
            {'D_A', true},
            {'D_Q', false},
            {'S_A', true, true, enhancement = "m_worm_ct_junk_card"},
            {'S_A', true, true, enhancement = "m_worm_ct_junk_card"},
        }) do
        local card = Card(0,0, 0.5*G.CARD_W, 0.5*G.CARD_H, G.P_CARDS[v[1]], G.P_CENTERS[v.enhancement or 'c_base'])
        if v[3] then card:juice_up(0.6, 0.4) elseif v[2] then card:juice_up(0.3, 0.2) end
        if k == 1 then play_sound('paper1',0.95 + math.random()*0.1, 0.3) end
        ease_value(card.T, 'scale',v[2] and 0.25 or -0.15,nil,'REAL',true,0.2)
        cardarea:emplace(card)
    end

    return {n=G.UIT.R, config={align = "cm", colour = G.C.WHITE, r = 0.1}, nodes={
        {n=G.UIT.C, config={align = "cm"}, nodes={
        {n=G.UIT.O, config={object = cardarea}}
        }}
    }}
end