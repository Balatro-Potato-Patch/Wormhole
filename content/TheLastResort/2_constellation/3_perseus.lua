SMODS.Consumable{
	key = "tlr_const_perseus",
	set = 'worm_tlr_constellation',
	atlas = "tlr_const",
	pos = {x=0, y=1},
	ppu_coder = {"Foo54"},
    ppu_artist = {"Aura2247"},
	config = {
		odds = {4, 3, 2, 1}
	},
	loc_vars = function(self, info_queue, card)
		local num, dem = SMODS.get_probability_vars(card, 1, card.ability.odds[card.ability.tier], "perseus_disable_t" .. card.ability.tier)
		return {vars = {num, dem}}
	end,
	can_use = function (self, card) return G.GAME.blind and G.GAME.blind.in_blind and G.GAME.blind.boss end,
	use = function (self, card, area, copier)
		if SMODS.pseudorandom_probability(card, "perseus_disable_t" .. card.ability.tier, 1, card.ability.odds[card.ability.tier]) then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.blind:disable()
							play_sound('timpani')
							delay(0.4)
							return true
						end
					}))
					SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
					return true
				end
			}))
		else
			G.E_MANAGER:add_event(Event({
				func = function()
					attention_text({
						text = localize('k_nope_ex'),
						scale = 1.3,
						hold = 1.4,
						major = card,
						backdrop_colour = G.C.SECONDARY_SET.Tarot,
						align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
								'tm' or 'cm',
						offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
						silent = true
					})
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.06 * G.SETTINGS.GAMESPEED,
						blockable = false,
						blocking = false,
						func = function()
							play_sound('tarot2', 0.76, 0.4)
							return true
						end
					}))
					play_sound('tarot2', 1, 0.4)
					card:juice_up(0.3, 0.5)
					return true
					
				end
			}))
		end
	end,
}