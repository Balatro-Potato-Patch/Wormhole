SMODS.ConsumableType({
	key = "worm_meow_Zodicat",
	primary_colour = HEX("FDDCA0"),
	secondary_colour = HEX("A7D6E0"),
	default = "c_worm_zodicat1",
	collection_rows = { 3,3 },
	shop_rate = 3,
	text_colour = G.C.UI.TEXT_DARK,
})

---Basically a way to handle effect animations for Zodicats
---@param card Card
---@param condition fun(p_card: Card): boolean?
---@param func fun(p_card: Card): nil
function Wormhole.TEAM_MEOW.zodicat_use(card, condition, func)
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.4,
		func = function()
			play_sound("tarot1")
			card:juice_up(0.3, 0.5)
			return true
		end,
	}))
	local cards_to_apply_to = {}
	for _, c in ipairs(G.hand.cards) do
		if condition(c) then
			cards_to_apply_to[#cards_to_apply_to + 1] = c
		end
	end
	for i = 1, #cards_to_apply_to do
		local percent = 1.15 - (i - 0.999) / (#cards_to_apply_to - 0.998) * 0.3
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				cards_to_apply_to[i]:flip()
				play_sound("card1", percent)
				cards_to_apply_to[i]:juice_up(0.3, 0.3)
				return true
			end,
		}))
	end
	delay(0.2)
	for i = 1, #cards_to_apply_to do
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				func(cards_to_apply_to[i])
				return true
			end,
		}))
	end
	for i = 1, #cards_to_apply_to do
		local percent = 0.85 + (i - 0.999) / (#cards_to_apply_to - 0.998) * 0.3
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				cards_to_apply_to[i]:flip()
				play_sound("tarot2", percent, 0.6)
				cards_to_apply_to[i]:juice_up(0.3, 0.3)
				return true
			end,
		}))
	end
	delay(0.5)
end

SMODS.Consumable({
	key = "zodicat1",
    set = "worm_meow_Zodicat",
	config = {
		extra = {
			perma_chips = 25,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.perma_chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		Wormhole.TEAM_MEOW.zodicat_use(card, function(p_card)
			return p_card:get_id() == 14 or p_card:get_id() == 2
		end, function(p_card)
			p_card.ability.perma_bonus = (p_card.ability.perma_bonus or 0) + card.ability.extra.perma_bonus
        end)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0
	end,
})
