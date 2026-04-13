SMODS.Atlas({
	key = "jtem2_cosmic_ray",
	path = "Jtem 2/jokers/cosmic_ray.png",
	px = 71,
	py = 95,
})

SMODS.Joker({
	key = "jtem2_cosmic_ray",

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
	ppu_artist = { "missingnumber" },

	rarity = 2,
	cost = 8,

	blueprint_compat = true,
	eternal_compat = true,
	rental_compat = true,

	atlas = "jtem2_cosmic_ray",
	pos = { x = 0, y = 0 },

	attributes = {
		"modify_card",
		"enhancements",
		"space",
	},

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		local last_used_planet_key = G.GAME.worm_last_used_planet
		if last_used_planet_key then
			return {
				vars = {
					localize({ type = "name_text", key = last_used_planet_key, set = "Planet" }),
					colours = { G.C.SECONDARY_SET.Planet },
				},
			}
		else
			return {
				vars = {
					localize("k_none"),
					colours = { G.C.ORANGE },
				},
			}
		end
	end,

	calculate = function(self, card, context)
		if
			context.using_consumeable
			and context.consumeable.ability.set == "Planet"
			and context.consumeable.config.center_key ~= G.GAME.worm_last_used_planet
		then
			local gold_target = pseudorandom_element(G.playing_cards, "worm_cosmic_ray")
			if gold_target then
				gold_target:set_ability("m_gold", nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						gold_target:juice_up()
						return true
					end,
				}))

				return {
					message = localize("k_gold"),
					colour = G.C.MONEY,
				}
			end
		end
	end,
})

local old_set_consumeable_usage = set_consumeable_usage
function set_consumeable_usage(card, ...)
	if card.config.center_key and card.ability.consumeable then
		if card.config.center.set == "Planet" then
			G.E_MANAGER:add_event(Event({
				trigger = "immediate",
				func = function()
					G.E_MANAGER:add_event(Event({
						trigger = "immediate",
						func = function()
							G.GAME.worm_last_used_planet = card.config.center_key
							return true
						end,
					}))
					return true
				end,
			}))
		end
	end
	return old_set_consumeable_usage(card, ...)
end
