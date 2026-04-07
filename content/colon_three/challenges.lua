if not Wormhole.COLON_THREE or not Wormhole.COLON_THREE.loaded then return end

Wormhole.optional_features = (Wormhole.optional_features or {})
Wormhole.optional_features.object_weights = true

SMODS.Challenge {
    key = "junk_it_up",
    rules = {
        custom = {
            { id = 'clear_out_junk' },
            { id = 'clear_out_junk_2' },
            { id = 'increase_derelict_rate' },
        }
    },
    deck = {
        type = 'Challenge Deck',
        enhancement = 'm_worm_junk_card'
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
    end
}