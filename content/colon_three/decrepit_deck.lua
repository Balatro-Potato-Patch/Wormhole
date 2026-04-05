if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Back {
    key = "decrepit_deck",
    pos = { x = 0, y = 1 },
    unlocked = true,
    config = { },
    ppu_coder = { "notmario" },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v:is_face() then
                        v:set_ability("m_worm_junk_card")
                    end
                end
                return true
            end
        }))
    end,
}