SMODS.Consumable{
    key = "tlr_const_canis_minor",
    set = 'worm_tlr_constellation',
    atlas = "tlr_const",
    ppu_coder = {"Breuhh"},
    ppu_artist = {"Aura2247"},
    pos = {x=0, y=3},
    config = {
        tiers = {2, 3, 3, 4},
    },
    loc_vars = function (self, info_queue, card)

        local fool_c = G.GAME.worm_tlr_last_const_used and ("%s_t%d"):format(G.GAME.worm_tlr_last_const_used, math.min(G.GAME.worm_tlr_last_const_used_tier or 1, card.ability.tiers[card.ability.tier])) or nil
        local last_constellation = fool_c and localize { type = 'name_text', key = fool_c, set = "worm_tlr_constellation" } or
            localize('k_none')
        local colour = (not fool_c) and G.C.RED or G.C.GREEN

        -- info_queue[#info_queue+1] = G.GAME.worm_tlr_last_const_used and G.P_CENTERS[G.GAME.worm_tlr_last_const_used] or nil

       if G.GAME.worm_tlr_last_const_used and G.GAME.worm_tlr_last_const_used ~= "c_worm_tlr_const_canis_minor" then
        local max_tier = math.min(G.GAME.worm_tlr_last_const_used_tier, card.ability.tiers[card.ability.tier])
        local obj = G.P_CENTERS[G.GAME.worm_tlr_last_const_used]
        local config = copy_table(obj.config)
        config.tier = max_tier
        local loc_vars = obj:loc_vars({}, setmetatable({ability = config}, {
            __index = function(t, k)
                return obj[k]
            end
        })).vars
        info_queue[#info_queue+1] = {set = "worm_tlr_constellation", key = G.GAME.worm_tlr_last_const_used .. "_t" .. max_tier, vars = loc_vars}
       end

        return {
            main_end = {
                {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_constellation .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
            }
        }
    end,
    can_use = function(self,card)
        return G.GAME.worm_tlr_last_const_used ~= self.key and G.GAME.worm_tlr_last_const_used ~= nil
    end,
    use = function(self,card,area,copier)
        local newcard = SMODS.add_card({key = G.GAME.worm_tlr_last_const_used})
        if card.ability.tier >= 3 then newcard:set_edition("e_Negative") end
        newcard.ability.tier = G.GAME.worm_tlr_last_const_used_tier
        WORM_TLR.update_const_sprite(newcard.config.center, newcard)
    end
}