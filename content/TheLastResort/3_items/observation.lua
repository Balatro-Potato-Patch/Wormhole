SMODS.Consumable{
	key = "tlr_observation",
	set = "Tarot",
	atlas = "tlr_tarot",
	pos = {x=0, y=0},
	can_use = function (self, card)
		return G.consumeables.cards[1] and G.consumeables.cards[1].config.center.set == "worm_tlr_constellation" and G.consumeables.cards[1].ability.tier < 4
	end,
	loc_vars = function(self, info_queue, card)
		return {vars = {colours = {SMODS.ConsumableTypes.worm_tlr_constellation.secondary_colour}}}
	end,
	use = function (self, card, area, copier)
		local _card = G.consumeables.cards[1]
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			func = function()
				_card:flip()
				play_sound('card1')
				_card:juice_up(0.3, 0.3)
				return true
			end
		}))
		delay(0.2)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function()
				_card.ability.tier = _card.ability.tier + 1
				_card.config.center:update_sprites(_card) -- we don't use the helper function here so the event runs at the right time
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			func = function()
				_card:flip()
				play_sound('tarot2', 1, 0.6)
				_card:juice_up(0.3, 0.3)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.consumeables:unhighlight_all()
				card:juice_up(0.3, 0.3)
				return true
			end
		}))
		delay(0.5)
	end,
	ppu_team = {"TheLastResort"},
	ppu_coder = {"Foo54"},
	ppu_artist = {"Aura2247"},
}