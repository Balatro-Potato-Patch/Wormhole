if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

Wormhole.optional_features = (Wormhole.optional_features or {})
Wormhole.optional_features.object_weights = true

SMODS.Challenge {
    key = "ct_junk_it_up",
    rules = {
        custom = {
            { id = 'clear_out_junk' },
            { id = 'clear_out_junk_2' },
            { id = 'increase_derelict_rate' },
        }
    },
    deck = {
        cards = {
            { s = "C", r = "K", e = "m_worm_junk_card" },
            { s = "C", r = "Q", e = "m_worm_junk_card" },
            { s = "C", r = "J", e = "m_worm_junk_card" },
            { s = "C", r = "T", e = "m_worm_junk_card" },
            { s = "C", r = "9", e = "m_worm_junk_card" },
            { s = "C", r = "8", e = "m_worm_junk_card" },
            { s = "C", r = "7", e = "m_worm_junk_card" },
            { s = "C", r = "6", e = "m_worm_junk_card" },
            { s = "C", r = "5", e = "m_worm_junk_card" },
            { s = "C", r = "4", e = "m_worm_junk_card" },
            { s = "C", r = "3", e = "m_worm_junk_card" },
            { s = "C", r = "2", e = "m_worm_junk_card" },
            { s = "C", r = "A", e = "m_worm_junk_card" },
            { s = "S", r = "K", e = "m_worm_junk_card" },
            { s = "S", r = "Q", e = "m_worm_junk_card" },
            { s = "S", r = "J", e = "m_worm_junk_card" },
            { s = "S", r = "T", e = "m_worm_junk_card" },
            { s = "S", r = "9", e = "m_worm_junk_card" },
            { s = "S", r = "8", e = "m_worm_junk_card" },
            { s = "S", r = "7", e = "m_worm_junk_card" },
            { s = "S", r = "6", e = "m_worm_junk_card" },
            { s = "S", r = "5", e = "m_worm_junk_card" },
            { s = "S", r = "4", e = "m_worm_junk_card" },
            { s = "S", r = "3", e = "m_worm_junk_card" },
            { s = "S", r = "2", e = "m_worm_junk_card" },
            { s = "S", r = "A", e = "m_worm_junk_card" },
            { s = "H", r = "K", e = "m_worm_junk_card" },
            { s = "H", r = "Q", e = "m_worm_junk_card" },
            { s = "H", r = "J", e = "m_worm_junk_card" },
            { s = "H", r = "T", e = "m_worm_junk_card" },
            { s = "H", r = "9", e = "m_worm_junk_card" },
            { s = "H", r = "8", e = "m_worm_junk_card" },
            { s = "H", r = "7", e = "m_worm_junk_card" },
            { s = "H", r = "6", e = "m_worm_junk_card" },
            { s = "H", r = "5", e = "m_worm_junk_card" },
            { s = "H", r = "4", e = "m_worm_junk_card" },
            { s = "H", r = "3", e = "m_worm_junk_card" },
            { s = "H", r = "2", e = "m_worm_junk_card" },
            { s = "H", r = "A", e = "m_worm_junk_card" },
            { s = "D", r = "K", e = "m_worm_junk_card" },
            { s = "D", r = "Q", e = "m_worm_junk_card" },
            { s = "D", r = "J", e = "m_worm_junk_card" },
            { s = "D", r = "T", e = "m_worm_junk_card" },
            { s = "D", r = "9", e = "m_worm_junk_card" },
            { s = "D", r = "8", e = "m_worm_junk_card" },
            { s = "D", r = "7", e = "m_worm_junk_card" },
            { s = "D", r = "6", e = "m_worm_junk_card" },
            { s = "D", r = "5", e = "m_worm_junk_card" },
            { s = "D", r = "4", e = "m_worm_junk_card" },
            { s = "D", r = "3", e = "m_worm_junk_card" },
            { s = "D", r = "2", e = "m_worm_junk_card" },
            { s = "D", r = "A", e = "m_worm_junk_card" },
            { s = "C", r = "K", e = "m_worm_junk_card" },
            { s = "C", r = "Q", e = "m_worm_junk_card" },
            { s = "C", r = "J", e = "m_worm_junk_card" },
            { s = "C", r = "A", e = "m_worm_junk_card" },
            { s = "S", r = "K", e = "m_worm_junk_card" },
            { s = "S", r = "Q", e = "m_worm_junk_card" },
            { s = "S", r = "J", e = "m_worm_junk_card" },
            -- { s = "S", r = "A", e = "m_worm_junk_card" }, -- 67 !! 67 !!
            { s = "H", r = "K", e = "m_worm_junk_card" },
            { s = "H", r = "Q", e = "m_worm_junk_card" },
            { s = "H", r = "J", e = "m_worm_junk_card" },
            { s = "H", r = "A", e = "m_worm_junk_card" },
            { s = "D", r = "K", e = "m_worm_junk_card" },
            { s = "D", r = "Q", e = "m_worm_junk_card" },
            { s = "D", r = "J", e = "m_worm_junk_card" },
            { s = "D", r = "A", e = "m_worm_junk_card" },
        }
    },
    button_colour = Wormhole.COLON_THREE.C.JunkSet,
    calculate = function(self, context)
		if context.modify_weights and context.pool_types.Booster then
			for _, pack in pairs(context.pool) do
				if pack.key == "p_worm_junkset_normal_1" or
                    pack.key == "p_worm_junkset_normal_2" or
                    pack.key == "p_worm_junkset_jumbo_1" or
                    pack.key == "p_worm_junkset_mega_1" then
					pack.weight = pack.weight * 3
                end
			end
		end
		if context.setting_blind and context.blind.boss and G.GAME.blind.config.blind.boss.showdown then
            local has_junk = false
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_worm_junk_card") then
                    has_junk = true
                    break
                end
            end
            if has_junk then
                G.TAROT_INTERRUPT = nil
                G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false 
            end
		end
    end
}