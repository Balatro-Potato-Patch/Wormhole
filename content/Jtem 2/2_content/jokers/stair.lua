SMODS.Atlas({
	key = "jtem2_stair",
	path = "Jtem 2/jokers/stair.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "jtem2_stair_soul",
	path = "Jtem 2/jokers/stair_soul.png",
	px = 71,
	py = 95,
	frames = 4,
	atlas_table = "ANIMATION_ATLAS",
	fps = 7,
})

SMODS.Joker({
	key = "jtem2_stair",

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
	ppu_artist = { "missingnumber" },

	atlas = "jtem2_stair",
	soul_atlas = "jtem2_stair_soul",

	cost = 5,
	rarity = 1,

	blueprint_compat = true,
	eternal_compat = true,
	rental_compat = true,

	config = {
		extra = {},
	},

	set_ability = function(self, card)
		if card.ability.extra.use_chips == nil then
			card.ability.extra.use_chips = pseudorandom("worm_jtem2_stair") < 0.5
		end
	end,

	loc_vars = function(self, info_queue, card)
		local _handname, _played = "High Card", -1
		for hand_key, hand in pairs(G.GAME.hands) do
			if hand.played > _played then
				_played = hand.played
				_handname = hand_key
			end
		end
		local most_played = G.GAME.hands[_handname]
		return {
			vars = {
				SMODS.signed(card.ability.extra.use_chips and most_played.chips or most_played.mult),
				localize(_handname, "poker_hands"),
			},
			key = card.ability.extra.use_chips and (self.key .. "_chips") or nil,
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local _handname, _played = "High Card", -1
			for hand_key, hand in pairs(G.GAME.hands) do
				if hand.played > _played then
					_played = hand.played
					_handname = hand_key
				end
			end
			local most_played = G.GAME.hands[_handname]
			local key = card.ability.extra.use_chips and "chips" or "mult"
			return {
				[key] = most_played[key],
			}
		end
		if context.end_of_round and context.main_eval and context.game_over == false and not context.blueprint then
			card.ability.extra.use_chips = not card.ability.extra.use_chips
			return {
				message = card.ability.extra.use_chips and localize("k_worm_chips_ex") or localize("k_worm_mult_ex"),
				colour = card.ability.extra.use_chips and G.C.CHIPS or G.C.MULT,
			}
		end
	end,
})
