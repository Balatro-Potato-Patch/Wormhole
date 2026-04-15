SMODS.Atlas({
	key = "jtem2_kilonovae",
	path = "Jtem 2/spectrals/kilonovae.png",
	px = 71,
	py = 95,
})

SMODS.Consumable({
	key = "jtem2_kilonovae",
	atlas = "jtem2_kilonovae",
	set = "Spectral",
	config = {
		max_highlighted = 2,
	},
	ppu_team = { "jtem2" },
	ppu_coder = { "aikoyori" },
	ppu_artist = { "aikoyori" },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS.worm_jtem2_black_hole
		info_queue[#info_queue + 1] = G.P_SEALS.worm_jtem2_supermassive_black_hole
		return {
			vars = {
				card.ability.max_highlighted,
			},
		}
	end,
	use = function(self, card, area, copier)
		for _, _card in ipairs(G.hand.highlighted) do
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound("tarot1")
					_card:juice_up(0.3, 0.5)
					return true
				end,
			}))

			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					if _card.seal == "worm_jtem2_black_hole" then
						_card:set_seal("worm_jtem2_supermassive_black_hole", nil, true)
					elseif _card.seal ~= "worm_jtem2_supermassive_black_hole" then
						_card:set_seal("worm_jtem2_black_hole", nil, true)
					end
					return true
				end,
			}))
		end
		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end,
		}))
	end,
})
