SMODS.Atlas {
	key = "polarskull_rockets",
	path = "Polar Skull/rockets.png",
	px = 71,
	py = 95,
}

local sounds = NFS.getDirectoryItems(SMODS.current_mod.path.."assets/sounds")
for _, filename in pairs(sounds) do
	if string.sub(filename, string.len(filename) - 3) == '.ogg' then
		SMODS.Sound({
			key = string.sub(filename, 1, string.len(filename) - 4),
			path = filename
		})
	end
end

SMODS.ConsumableType{
	key = "polarskull_rocket",
	primary_colour = HEX("4f6367"),
	secondary_colour = HEX("83e9f8"),
	default = "c_worm_polarskull_vostok1",
	shop_rate = 2 --Half the default rate of Planet Cards
}

local ACTIVE_SOUND_LENGTH = 4.750
local ACTIVE_SOUND_START = 0.500
local active_sound_timer = ACTIVE_SOUND_START

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
		local other = false
		for _, other_card in ipairs(G.consumeables.cards) do
			if other_card.ability.set == "polarskull_rocket" and other_card.ability.extra.active and not other_card.getting_sliced then
				other_card.ability.extra.active = false
				other_card:start_dissolve()
				other = true
			end
		end
		card.ability.extra.active = true
		SMODS.calculate_effect({message = localize("k_active_ex"), sound = "worm_polarskull_rocketlaunch"}, card)
		if not other then
			active_sound_timer = ACTIVE_SOUND_START
		end
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
	args.update = args.update or function(self, card, dt)
		if not card.ability.extra.active then return end
		active_sound_timer = active_sound_timer - dt
		if active_sound_timer <= 0 then
			active_sound_timer = ACTIVE_SOUND_LENGTH
			play_sound("worm_polarskull_rocketactive", nil, 0.5)
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
