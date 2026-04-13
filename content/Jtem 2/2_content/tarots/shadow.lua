SMODS.Atlas {
	key = "jtem2_shadow",
	path = "Jtem 2/tarots/shadow.png",
	px = 71,
	py = 95,
}

local function eligible_check(count_most_played)
	local most_played = ""
	local current_played = 0
	for k, v in pairs(G.GAME.hands) do
		if v.played > current_played then
			current_played = v.played
			most_played = k
		end
	end

	local eligible_hands = {}
	for k, v in pairs(G.GAME.hands) do
		if not v.visible then goto continue end
		if v.level <= 1 then goto continue end
		if k == most_played and not count_most_played then goto continue end
		eligible_hands[#eligible_hands + 1] = v
		v.jtem2_name = k
		::continue::
	end

	return eligible_hands, most_played
end

SMODS.Consumable {
	key = "jtem2_shadow",

	set = 'Tarot',
	ppu_team = { "jtem2" },
	ppu_coder = { "haya" },
	ppu_artist = { "aikoyori" },

	atlas = "jtem2_shadow",
	pos = { x = 0, y = 0 },

	attributes = {
		'tarot'
	},

	use = function(self, card, area, copier)
		local eligible_hands, most_played = eligible_check()

		-- Somehow no hands eligible...
		if #eligible_hands == 0 then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					attention_text({
						text = localize('k_nope_ex'),
						scale = 1.3,
						hold = 1.4,
						major = card,
						backdrop_colour = G.C.SECONDARY_SET.Tarot,
						align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
						offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0 },
						silent = true
					})
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.06 * G.SETTINGS.GAMESPEED,
						blockable = false,
						blocking = false,
						func = function()
							play_sound('tarot2', 0.76, 0.4); return true
						end
					}))
					play_sound('tarot2', 1, 0.4)
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
			return
		end

		-- random hand
		local picked = pseudorandom_element(eligible_hands, "jtem2_shadow_pick" .. G.GAME.round_resets.ante)
		local picked_level = picked.level - 1
		-- decrease random poker hand
		SMODS.upgrade_poker_hands({
			hands = { picked.jtem2_name },
			level_up = -picked.level + 1,
			from = card
		})
		-- increase most played poker hand
		SMODS.upgrade_poker_hands({
			hands = { most_played },
			level_up = picked_level,
			from = card
		})
	end,

	in_pool = function(self, args)
		local eligible_hands, _ = eligible_check(true)
		return #eligible_hands > 0
	end,

	can_use = function(self, card)
		local eligible_hands, _ = eligible_check(true)
		return #eligible_hands > 0
	end
}
