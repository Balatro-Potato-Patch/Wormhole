if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

for i = 1, 6 do
    SMODS.JimboQuip {
        key = 'c3_mf_junk_'..i,
        extra = {
            ppu_dev = "worm_notmario",
            particle_colours = {
                HEX "ff6868",
                darken(HEX "ff6868", 0.5),
                lighten(HEX "ff6868", 0.5)
            }
        },
        filter = function(self, type)
            if type == 'loss' then
                for k, v in pairs(G.playing_cards) do
                    if SMODS.has_enhancement(v, "m_worm_ct_junk_card") then
                        return true, { weight = 25 }
                    end
                end
            end
        end
    }
end