if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

SMODS.Atlas {
    path = "colon_three/deck.png",
    key = "ct_deck",
    px = 71, py = 95
}

SMODS.Back {
    key = "ct_decrepit_deck",
    atlas = "ct_deck",
    pos = { x = 0, y = 0 },
    unlocked = true,
    config = { },
    ppu_artist = { "notmario" },
    ppu_coder = { "notmario" },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v:is_face() then
                        v:set_ability("m_worm_ct_junk_card")
                    end
                end
                return true
            end
        }))
    end,
}