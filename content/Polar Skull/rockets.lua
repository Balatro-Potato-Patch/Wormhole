SMODS.Atlas({
	key = "polarskull_rockets",
	path = "Polar Skull/rockets.png",
	px = 71,
	py = 95,
})

local sounds = NFS.getDirectoryItems(SMODS.current_mod.path .. "assets/sounds")
for _, filename in pairs(sounds) do
	if string.sub(filename, string.len(filename) - 3) == ".ogg" then
		if not string.find(filename, "music") then
			SMODS.Sound({
				key = string.sub(filename, 1, string.len(filename) - 4),
				path = filename,
			})
		end
	end
end

SMODS.ConsumableType({
	key = "polarskull_rocket",
	primary_colour = HEX("4f6367"),
	secondary_colour = HEX("83e9f8"),
	text_colour = HEX('4f6367'),
	default = "c_worm_polarskull_atlasv",
	shop_rate = 2, --Half the default rate of Planet Cards
})

local ACTIVE_SOUND_LENGTH = 4.750
local ACTIVE_SOUND_START = 0.500
local active_sound_timer = ACTIVE_SOUND_START

local fake_hand_network = {
	["Special: Everything"] = { cards = 5, subhands = { "Flush Five", "Flush House", "Straight Flush" } },
	["Flush Five"] = { cards = 5, subhands = { "Flush", "Five of a Kind" } },
	["Flush House"] = { cards = 5, subhands = { "Flush", "Full House" } },
	["Five of a Kind"] = { cards = 5, subhands = { "Four of a Kind" } },
	["Straight Flush"] = { cards = 5, subhands = { "Flush", "Straight" } },
	["Four of a Kind"] = { cards = 4, subhands = { "Three of a Kind" } },
	["Full House"] = { cards = 5, subhands = { "Three of a Kind", "Two Pair" } },
	["Flush"] = { cards = 5, subhands = { "High Card" } },
	["Straight"] = { cards = 5, subhands = { "High Card" } },
	["Three of a Kind"] = { cards = 3, subhands = { "Pair" } },
	["Two Pair"] = { cards = 4, subhands = { "Pair" } },
	["Pair"] = { cards = 2, subhands = { "High Card" } },
	["High Card"] = { cards = 1, subhands = {} },
}

local function evaluate_fake_hands(scoring_cards, hand_name, fake_hands)
	fake_hands = fake_hands or evaluate_poker_hand(scoring_cards)
	if not fake_hands[hand_name] then
		for _, subhand in ipairs(fake_hand_network[hand_name].subhands) do
			evaluate_fake_hands(scoring_cards, subhand, fake_hands)
		end
	elseif #fake_hands[hand_name] == 0 then
		local fake_cards = {}
		for i = 1, fake_hand_network[hand_name].cards do
			table.insert(fake_cards, scoring_cards[i] or scoring_cards[#scoring_cards])
		end
		table.insert(fake_hands[hand_name], fake_cards)
		for _, subhand in ipairs(fake_hand_network[hand_name].subhands) do
			evaluate_fake_hands(scoring_cards, subhand, fake_hands)
		end
	end
	return fake_hands
end

local cache_bonus_mult = 0
local cache_bonus_chips = 0
local old_update_hand_text = update_hand_text
function update_hand_text(config, vals)
	if type(vals.mult) == "number" or (is_big and is_big(vals.mult)) then
		vals.mult = vals.mult + cache_bonus_mult
	end
	if type(vals.chips) == "number" or (is_big and is_big(vals.chips)) then
		vals.chips = vals.chips + cache_bonus_chips
	end
	return old_update_hand_text(config, vals)
end

function PotatoPatchUtils.Teams.worm_polar_skull.calculate(self, context)
	if context.evaluate_poker_hand then
		cache_bonus_chips = 0
		cache_bonus_mult = 0
		local replace_scoring_name = nil
		local replace_poker_hands = nil
		local last_rocket = nil	
		if context.scoring_name == "NULL" then return end
		for _, card in ipairs(G.consumeables.cards) do
			if (card.ability.set == "polarskull_rocket" or card.config.center.key == "c_worm_polarskull_ssdolphin") and card.ability.extra.active and not card.getting_sliced then
				if card.ability.extra.hand == "Special: Everything" then
					for name, hand in pairs(G.GAME.hands) do
						if name ~= context.scoring_name then
							cache_bonus_chips = cache_bonus_chips + hand.chips
							cache_bonus_mult = cache_bonus_mult + hand.mult
						end
					end
				elseif G.GAME.hands[context.scoring_name] then
					if last_rocket then
						cache_bonus_chips = cache_bonus_chips + G.GAME.hands[last_rocket.ability.extra.hand].chips
						cache_bonus_mult = cache_bonus_mult + G.GAME.hands[last_rocket.ability.extra.hand].mult
					else
						cache_bonus_chips = cache_bonus_chips + G.GAME.hands[context.scoring_name].chips
						cache_bonus_mult = cache_bonus_mult + G.GAME.hands[context.scoring_name].mult
					end
					last_rocket = card
				end
				replace_scoring_name = context.poker_hands[card.ability.extra.hand] and card.ability.extra.hand or replace_scoring_name
				replace_poker_hands = evaluate_fake_hands(context.scoring_hand, card.ability.extra.hand, replace_scoring_hands)
			end
		end
		if replace_scoring_name then
			context.display_name = replace_scoring_name
		end
		return {replace_scoring_name = replace_scoring_name, replace_poker_hands = replace_poker_hands}
	end
end

local function register_rocket(args)
	args.key = "polarskull_" .. args.key
	args.set = args.set or "polarskull_rocket"
	args.atlas = "polarskull_rockets"
	args.cost = args.cost or 4
	args.config.extra.active = false
	args.ppu_artist = args.ppu_artist or {"comykel"}
	args.ppu_coder = args.ppu_coder or { "noodlemire" }
	args.ppu_team = { "polar_skull" }
	args.loc_vars = args.loc_vars or function(self, info_queue, card)
		local ppm = G.GAME.used_vouchers["v_worm_polarskull_prepetual_motion_machine"]
		local key = self.key
		if key == "c_worm_polarskull_ssdolphin" and ppm then
			ppm = false
			key = key.."_ppm"
			table.insert(info_queue, {key = "v_worm_polarskull_prepetual_motion_machine", set = "Voucher"})
		end
		return {
			key = key,
			vars = {
				card.ability.extra.hand,
				ppm and localize("k_polarskull_unlimited") or card.ability.extra.rounds,
				localize(card.ability.extra.active and "k_active_ex" or "k_polarskull_inactive"),
				localize(card.ability.extra.rounds == 1 and not ppm and "k_polarskull_round_singular" or "k_polarskull_round_plural"),
				colours = {
					card.ability.extra.active and G.C.GREEN or G.C.RED,
				},
			},
		}
	end
	args.keep_on_use = args.keep_on_use or function(self, card)
		return true
	end
	args.can_use = args.can_use or function(self, card)
		return not card.ability.extra.active and card.area == G.consumeables
	end
	args.use = args.use or function(self, card, area)
		local other = false
		for _, other_card in ipairs(G.consumeables.cards) do
			if (other_card.ability.set == "polarskull_rocket" or other_card.config.center.key == "c_worm_polarskull_ssdolphin") and other_card.ability.extra.active and not other_card.getting_sliced then
				if not G.GAME.polarskull_rockets_stack then
					other_card.ability.extra.active = false
					other_card.ability.extra.was_activated = true
					other_card:start_dissolve()
				end
				other = true
			end
		end
		card.ability.extra.active = true
		SMODS.calculate_effect({ message = localize("k_active_ex"), sound = "worm_polarskull_rocketlaunch" }, card)
		if not other then
			active_sound_timer = ACTIVE_SOUND_START
		end
	end
	args.calculate = args.calculate or function(self, card, context)
		if not card.ability.extra.active then return end
		if context.modify_hand then
			if cache_bonus_chips > 0 then
				hand_chips = hand_chips + cache_bonus_chips
				cache_bonus_chips = 0
			end
			if cache_bonus_mult > 0 then
				mult = mult + cache_bonus_mult
				cache_bonus_mult = 0
			end
		elseif context.end_of_round and context.main_eval and (not G.GAME.used_vouchers["v_worm_polarskull_prepetual_motion_machine"] or self.key == "c_worm_polarskull_ssdolphin") then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds <= 0 then
				cache_bonus_chips = 0
				cache_bonus_mult = 0
				card.ability.extra.active = false
				card:start_dissolve()
			end
			return {
				message = localize({
					type = "variable",
					key = "k_polarskull_left",
					vars = {card.ability.extra.rounds},
				}),
			}
		elseif context.check_eternal and context.other_card == card then
			return { no_destroy = true }
        elseif context.using_consumeable and context.consumeable.config.center.set == "Planet" and G.GAME.used_vouchers["v_worm_polarskull_gravitational_slingshot"] and not G.GAME.used_vouchers["v_worm_polarskull_prepetual_motion_machine"] and card.ability.extra.hand == context.consumeable.ability.hand_type then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
			return {
				message = localize("k_polarskull_plus_round")
			}
        end
	end
	args.update = args.update or function(self, card, dt) 
		if not card.ability.extra.active then return end
		active_sound_timer = active_sound_timer - dt /4 --for some reason, this is happening at ~4x the speed expected. So dividing by 4 to prevent overlap of sounds
		if active_sound_timer <= 0.01 then --increased the threshold to avoid silences. Unfortunately not perfect because balatro doesn't keep track of audio
			active_sound_timer = ACTIVE_SOUND_LENGTH
			play_sound("worm_polarskull_rocketactive", nil, 0.5)
		end
	end
	args.in_pool = args.in_pool or function(self, args)
		return true, {allow_duplicates = G.GAME.polarskull_rockets_stack}
	end

	SMODS.Consumable(args)
end

register_rocket({
	key = "atlasv",
	pos = { x = 0, y = 0 },
	config = { extra = { hand = "High Card", rounds = 3 } },
})

register_rocket({
	key = "vostok1",
	pos = { x = 1, y = 0 },
	config = { extra = { hand = "Pair", rounds = 3 } },
})

register_rocket({
	key = "longmarch5",
	pos = { x = 2, y = 0 },
	config = { extra = { hand = "Two Pair", rounds = 3 } },
})

register_rocket({
	key = "soyuz1",
	pos = { x = 3, y = 0 },
	config = { extra = { hand = "Three of a Kind", rounds = 3 } },
})

register_rocket({
	key = "titaniv",
	pos = { x = 4, y = 0 },
	config = { extra = { hand = "Straight", rounds = 2 } },
})

register_rocket({
	key = "atlascentaur",
	pos = { x = 5, y = 0 },
	config = { extra = { hand = "Flush", rounds = 2 } },
})

register_rocket({
	key = "spaceshuttle",
	pos = { x = 0, y = 1 },
	config = { extra = { hand = "Full House", rounds = 2 } },
})

register_rocket({
	key = "sls",
	pos = { x = 1, y = 1 },
	config = { extra = { hand = "Four of a Kind", rounds = 1 } },
})

register_rocket({
	key = "titanieee",
	pos = { x = 2, y = 1 },
	config = { extra = { hand = "Straight Flush", rounds = 1 } },
})

register_rocket({
	key = "saturnv",
	pos = { x = 3, y = 1 },
	config = { extra = { hand = "Five of a Kind", rounds = 1 } },
	in_pool = function(self, args)
		return G.GAME.hands[self.config.extra.hand].played > 0, {allow_duplicates = G.GAME.polarskull_rockets_stack}
	end,
})

register_rocket({
	key = "deltaii",
	pos = { x = 4, y = 1 },
	config = { extra = { hand = "Flush House", rounds = 1 } },
	in_pool = function(self, args)
		return G.GAME.hands[self.config.extra.hand].played > 0, {allow_duplicates = G.GAME.polarskull_rockets_stack}
	end,
})

register_rocket({
	key = "ariane5",
	pos = { x = 5, y = 1 },
	config = { extra = { hand = "Flush Five", rounds = 1 } },
	in_pool = function(self, args)
		return G.GAME.hands[self.config.extra.hand].played > 0, {allow_duplicates = G.GAME.polarskull_rockets_stack}
	end,
})

register_rocket({
	key = "ssdolphin",
	set = "Spectral",
	pos = { x = 6, y = 1 },
	config = { extra = { hand = "Special: Everything", rounds = 3 } },
	--ppu_artist = { "noodlemire", "jade" },
	ppu_artist = { "comykel" },
	hidden = true,
	soul_set = "polarskull_rocket",
	draw = function(self, card, layer)
		if (layer == "card" or layer == "both") and card.sprite_facing == "front" then
			card.children.center:draw_shader("booster", nil, card.ARGS.send_to_shader)
		end
	end,
})
