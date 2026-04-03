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
