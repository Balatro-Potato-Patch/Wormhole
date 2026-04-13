SMODS.ConsumableType({
	key = "worm_meow_Zodicat",
	primary_colour = HEX("FDDCA0"),
	secondary_colour = HEX("A7D6E0"),
	default = "c_worm_zodicat1",
	collection_rows = { 3, 3 },
	shop_rate = 1.5,
	text_colour = G.C.UI.TEXT_DARK,
})

SMODS.Atlas({
	key = "cat_zodiacs",
	px = 71,
	py = 95,
	path = "TeamMeow/cat_zodiacs.png",
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
	key = "crimson",
	set = "worm_meow_Zodicat",
	attributes = { "modify_card", "chips", "ace", "two", "space" },
	config = {
		extra = {
			perma_bonus = 25,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.perma_bonus,
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
	atlas = "cat_zodiacs",
	pos = { x = 0, y = 0 },
	ppu_team = { "meow" },
	ppu_coder = { "thunderedge" },
	ppu_artist = { "gappie" },
})

SMODS.Consumable({
	key = "lemon",
	set = "worm_meow_Zodicat",
	attributes = { "modify_card", "mult", "three", "four", "space" },
	config = {
		extra = {
			perma_mult = 5,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.perma_mult,
			},
		}
	end,
	use = function(self, card, area, copier)
		Wormhole.TEAM_MEOW.zodicat_use(card, function(p_card)
			return p_card:get_id() == 3 or p_card:get_id() == 4
		end, function(p_card)
			p_card.ability.perma_mult = (p_card.ability.perma_mult or 0) + card.ability.extra.perma_mult
		end)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0
	end,
	atlas = "cat_zodiacs",
	pos = { x = 1, y = 0 },
	ppu_team = { "meow" },
	ppu_coder = { "thunderedge" },
	ppu_artist = { "gappie" },
})

SMODS.Consumable({
	key = "viridian",
	set = "worm_meow_Zodicat",
	attributes = { "modify_card", "economy", "chance", "five", "six", "space" },
	config = {
		extra = {
			perma_p_dollars = 1,
			odds = 2,
		},
	},
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "zodicat3")
		return {
			vars = {
				n,
				d,
				card.ability.extra.perma_p_dollars,
			},
		}
	end,
	use = function(self, card, area, copier)
		Wormhole.TEAM_MEOW.zodicat_use(card, function(p_card)
			return p_card:get_id() == 5 or p_card:get_id() == 6
		end, function(p_card)
			if SMODS.pseudorandom_probability(card, "zodicat3", 1, card.ability.extra.odds) then
				p_card.ability.perma_p_dollars = (p_card.ability.perma_p_dollars or 0)
					+ card.ability.extra.perma_p_dollars
			end
		end)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0
	end,
	atlas = "cat_zodiacs",
	pos = { x = 2, y = 0 },
	ppu_team = { "meow" },
	ppu_coder = { "thunderedge" },
	ppu_artist = { "gappie" },
})

SMODS.Consumable({
	key = "clear_sky",
	set = "worm_meow_Zodicat",
	attributes = { "modify_card", "chips", "seven", "eight", "space" },
	config = {
		extra = {
			perma_h_chips = 25,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.perma_h_chips,
			},
		}
	end,
	use = function(self, card, area, copier)
		Wormhole.TEAM_MEOW.zodicat_use(card, function(p_card)
			return p_card:get_id() == 7 or p_card:get_id() == 8
		end, function(p_card)
			p_card.ability.perma_h_chips = (p_card.ability.perma_h_chips or 0) + card.ability.extra.perma_h_chips
		end)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0
	end,
	atlas = "cat_zodiacs",
	pos = { x = 0, y = 1 },
	ppu_team = { "meow" },
	ppu_coder = { "thunderedge" },
	ppu_artist = { "gappie" },
})

SMODS.Consumable({
	key = "deep_sea",
	set = "worm_meow_Zodicat",
	attributes = { "modify_card", "mult", "nine", "ten", "space" },
	config = {
		extra = {
			perma_h_mult = 5,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.perma_h_mult,
			},
		}
	end,
	use = function(self, card, area, copier)
		Wormhole.TEAM_MEOW.zodicat_use(card, function(p_card)
			return p_card:get_id() == 9 or p_card:get_id() == 10
		end, function(p_card)
			p_card.ability.perma_h_mult = (p_card.ability.perma_h_mult or 0) + card.ability.extra.perma_h_mult
		end)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0
	end,
	atlas = "cat_zodiacs",
	pos = { x = 1, y = 1 },
	ppu_team = { "meow" },
	ppu_coder = { "thunderedge" },
	ppu_artist = { "gappie" },
})

SMODS.Consumable({
	key = "blossom",
	set = "worm_meow_Zodicat",
	attributes = { "modify_card", "xmult", "face", "space" },
	config = {
		extra = {
			perma_x_mult = 0.1,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.perma_x_mult,
			},
		}
	end,
	use = function(self, card, area, copier)
		Wormhole.TEAM_MEOW.zodicat_use(card, function(p_card)
			return p_card:is_face()
		end, function(p_card)
			p_card.ability.perma_x_mult = (p_card.ability.perma_x_mult or 0) + card.ability.extra.perma_x_mult
		end)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0
	end,
	atlas = "cat_zodiacs",
	pos = { x = 2, y = 1 },
	ppu_team = { "meow" },
	ppu_coder = { "thunderedge" },
	ppu_artist = { "gappie" },
})
