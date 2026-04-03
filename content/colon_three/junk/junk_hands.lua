if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

local meta_calc_ref = PotatoPatchUtils.Developers.worm_meta.calculate
PotatoPatchUtils.Developers.worm_meta.calculate = function(self, context)
    if context.evaluate_poker_hand then
        local junks = false
        for i, v in ipairs(context.full_hand) do
            if SMODS.has_enhancement(v, "m_worm_junk_card") then
                junks = true
                break
            end
        end
        if junks then
            local txt = "Junk"
            return {
                replace_display_name = txt .. " " .. context.display_name
            }
        end
    end
    return meta_calc_ref(self, context)
end

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
            if v.config.center.key == "m_worm_junk_card" then junks = junks + 1 end
        end
        G.GAME.worm_c3_junk_stats.x_hand_stats = G.GAME.worm_c3_junk_stats.x_hand_stats or 1.5
        local junk_hands_mult = G.GAME.worm_c3_junk_stats.x_hand_stats ^ junks
        for name, parameter in pairs(SMODS.Scoring_Parameters) do
            parameter.current = parameter.current * junk_hands_mult
            update_hand_text({immediate = true, nopulse = nil, delay = 0}, {[name] = parameter.current})
        end
    end
    return ret
end
