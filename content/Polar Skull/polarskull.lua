SMODS.Atlas {
	key = "polarskull_rockets",
	path = "Polar Skull/rockets.png",
	px = 71,
	py = 95,
}

SMODS.ConsumableType{
	key = "polarskull_rocket",
	primary_colour = HEX("4f6367"),
	secondary_colour = HEX("83e9f8"),
	default = "c_worm_polarskull_vostok1",
	shop_rate = 2 --Half the default rate of Planet Cards
}

local function register_rocket(args)
	args.key = "polarskull_"..args.key
	args.set = "polarskull_rocket"
	args.atlas = "polarskull_rockets"
	args.cost = args.cost or 4
	args.config = args.config or {extra = {active = false, hand = args.hand, rounds = 2}}
	args.hand = nil
	args.loc_vars = args.loc_vars or function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.hand,
				card.ability.extra.rounds,
				localize(card.ability.extra.active and "k_active_ex" or "k_polarskull_inactive"),
				colours = {
					card.ability.extra.active and G.C.GREEN or G.C.RED
				}
			},
		}
	end
	args.keep_on_use = args.keep_on_use or function(self, card)
		return true
	end
	args.can_use = args.can_use or function(self, card)
		return not card.ability.extra.active
	end
	args.use = args.use or function(self, card, area)
		for _, other_card in ipairs(G.consumeables.cards) do
			if other_card.ability.set == "polarskull_rocket" and other_card.ability.extra.active and not other_card.getting_sliced then
				other_card.ability.extra.active = false
				other_card:start_dissolve()
			end
		end
		card.ability.extra.active = true
		SMODS.calculate_effect({message = localize("k_active_ex")}, card)
	end
	args.calculate = args.calculate or function(self, card, context)
		if not card.ability.extra.active then return end
		if context.evaluate_poker_hand then
			return {replace_scoring_name = card.ability.extra.hand}
		elseif context.end_of_round and context.main_eval then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds <= 0 then
				card.ability.extra.active = false
				card:start_dissolve()
			end
			return {message = localize{type = "variable", key = "k_polarskull_left", vars = {card.ability.extra.rounds}}}
		elseif context.check_eternal and context.other_card == card then
			return {no_destroy = true}
		end
	end

	SMODS.Consumable(args)
end

register_rocket{
	key = "vostok1",
	pos = {x = 1, y = 0},
	hand = "Pair"
}

register_rocket{
	key = "saturnv",
	pos = {x = 3, y = 1},
	hand = "Five of a Kind",
	in_pool = function(self, args)
		return G.GAME.hands[self.config.extra.hand].played > 0
	end
}
