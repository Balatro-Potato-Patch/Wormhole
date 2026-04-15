SMODS.Gradient({
	key = "jtem2_quantum",
	colours = {
		HEX("000043"),
		HEX("0f1365"),
		HEX("242670"),
		HEX("0f1365"),
	},
	cycle = 1,
})

SMODS.Rarity({
	key = "jtem2_quantum",
	default_weight = 0.03,
	badge_colour = SMODS.Gradients["worm_jtem2_quantum"],
	get_weight = function(self, weight, object_type)
		return weight
	end,
})

SMODS.Atlas({
	key = "jtem2_quantum_rock",
	path = "Jtem 2/jokers/quantum_rock.png",
	px = 71,
	py = 95,
})

local rock = SMODS.Joker({
	key = "jtem2_quantum_rock",

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
	ppu_artist = { "aikoyori" },

	replace_base_card = true,

	atlas = "worm_jtem2_quantum_rock",
	pos = { x = 0, y = 0 },

	rarity = "worm_jtem2_quantum",
	cost = 3,

	config = {
		Xmult = 3,
	},

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.Xmult,
				localize("Jack", "ranks"),
				localize("Spades", "suits_plural"),
				colours = { G.C.SUITS["Spades"] },
			},
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.Xmult,
			}
		end
	end,

	add_to_deck = function()
		G.GAME.worm_quantum_rock_spawned = true
	end,
})

local function is_rock_present()
	return G.worm_quantum_rock
			and not G.worm_quantum_rock.REMOVED
			and not G.worm_quantum_rock.worm_delay_quantum_rock_remove
			and true
		or false
end
local function is_rock(card)
	return card and card.worm_was_quantum_rock or (card.config.center and card.config.center.key == rock.key)
end
local function emplace_and_shuffle_in_area(card, area)
	if not area.cards then
		card:remove()
		return
	end
	local new_index = pseudorandom("worm_quantum_rock" .. os.time(), 1, #area.cards + 1)
	table.insert(area.cards, new_index, card)
	if card.facing == "back" and area.config.type ~= "discard" and area.config.type ~= "deck" then
		card:flip()
	end

	card:set_card_area(area)
	area:set_ranks()
	area:align_cards()
	card:hard_set_T()
end
local function shuffle_in_area(card, area)
	if not area.cards then
		card:remove()
		return
	end
	for index, _card in ipairs(area.cards) do
		if _card == card then
			table.remove(area.cards, index)
			break
		end
	end
	local new_index = pseudorandom("worm_quantum_rock" .. os.time(), 1, #area.cards + 1)
	table.insert(area.cards, new_index, card)
	card:hard_set_T()
end
local function roll_new_rock_target()
	local result
	local annoying_level = G.GAME.worm_quantum_rock_spawned and 0.8 or 0.97
	if WORM_JTEM.quantum_rock.force_target then
		result = WORM_JTEM.quantum_rock.force_target
	elseif not WORM_JTEM.quantum_rock.enabled or pseudorandom("worm_quantum_rock" .. os.time()) < annoying_level then
		result = nil
	else
		local targets = {
			"hand",
			"play",
			"deck",
			"jokers",
			"consumeables",
			"booster_pack",
			"shop_jokers",
			"shop_boosters",
			"shop_vouchers",
			"title",
			"screenswipe",
		}
		result = pseudorandom_element(targets, "worm_quantum_rock" .. os.time())
	end
	G.worm_quantum_rock_target = result
	return result
end
local function spawn_new_rock(protect, whitelist)
	if not WORM_JTEM.quantum_rock.enabled or is_rock_present() then
		return
	end
	local target = G.worm_quantum_rock_target
	if whitelist and not whitelist[target] then
		roll_new_rock_target()
		return
	end
	local function simple_create(area, real_emplace, with_shop_ui)
		if not area or not area.cards then
			return false
		end
		local card = Card(area.T.x + area.T.w / 2 - G.CARD_W / 2, area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS["S_J"], rock)
		if real_emplace == true then
			area:emplace(card)
			shuffle_in_area(card, area)
		elseif real_emplace == 2 then
			area:emplace(card)
		else
			emplace_and_shuffle_in_area(card, area)
		end
		roll_new_rock_target()
		if protect then
			card.worm_protect_quantum_rock = true
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.25,
				timer = "REAL",
				blocking = false,
				blockable = false,
				func = function()
					card.worm_protect_quantum_rock = nil
					return true
				end,
			}))
		end
		if with_shop_ui then
			create_shop_card_ui(card)
		end
		return true
	end
	if target == "hand" and G.hand and G.STATE == G.STATES.SELECTING_HAND then
		simple_create(G.hand, true)
	elseif target == "play" and G.play and G.STATE == G.STATES.HAND_PLAYED then
		simple_create(G.play)
	elseif target == "jokers" and G.jokers and G.OVERLAY_MENU then
		simple_create(G.jokers)
	elseif target == "consumeables" and G.consumeables and G.OVERLAY_MENU then
		simple_create(G.consumeables)
	elseif target == "booster_pack" and G.pack_cards then
		simple_create(G.pack_cards)
	elseif target == "shop_jokers" and G.shop_jokers then
		simple_create(G.shop_jokers, nil, true)
	elseif target == "shop_boosters" and G.shop_booster then
		simple_create(G.shop_booster, nil, true)
	elseif target == "shop_vouchers" and G.shop_vouchers then
		if simple_create(G.shop_vouchers, true, true) and G.shop_vouchers.cards then
			G.shop_vouchers.config.card_limit = #G.shop_vouchers.cards
		end
	elseif target == "title" and G.title_top then
		simple_create(G.title_top, 2)
	end
end
local function destroy_rock(delay, no_replace, whitelist)
	local card = G.worm_quantum_rock
	if card then
		card.states.visible = false
		if delay then
			card.worm_delay_quantum_rock_remove = true
			G.E_MANAGER:add_event(Event({
				blocking = false,
				func = function()
					card.worm_keep_quantum_rock_target = true
					card:remove()
					return true
				end,
			}))
		else
			card.worm_keep_quantum_rock_target = true
			card:remove()
		end
	end
	if not no_replace then
		spawn_new_rock(whitelist)
	end
	roll_new_rock_target()
end

--

local old_showman = SMODS.showman
function SMODS.showman(card_key, ...)
	if card_key == rock.key then
		return false
	end
	return old_showman(card_key, ...)
end

local old_game_update = Game.update
function Game:update(...)
	old_game_update(self, ...)
	if G.GAME then
		if G.GAME.used_jokers then
			G.GAME.used_jokers[rock.key] = nil
		end
		if G.GAME.worm_quantum_rock_spawned then
			WORM_JTEM.quantum_rock.enabled = true
		end
		if WORM_JTEM.quantum_rock.enabled then
			G.worm_quantum_rock_target_dt = G.worm_quantum_rock_target_dt or G.TIMERS.REAL
			if G.TIMERS.REAL - G.worm_quantum_rock_target_dt > 0.5 then
				roll_new_rock_target()
				G.worm_quantum_rock_target_dt = G.TIMERS.REAL
			end
			if G.worm_quantum_rock then
				if G.worm_quantum_rock.REMOVED and G.worm_quantum_rock.area then
					G.worm_quantum_rock:remove()
					G.worm_quantum_rock = nil
				end
			end
		else
			G.worm_quantum_rock_target = nil
		end
	else
		G.worm_quantum_rock_target = nil
	end
end

local old_card_update = Card.update
function Card:update(...)
	local should_remove_rock = false
	if is_rock(self) then
		self.worm_was_quantum_rock = true
		if self.area == G.play and G.STATE ~= G.STATES.HAND_PLAYED then
			G.play:remove_card(self)
			G.discard:emplace(self)
		end
		if not self.REMOVED and not self.worm_delay_quantum_rock_remove then
			if not is_rock_present() then
				G.worm_quantum_rock = self
			end
			if not self.worm_protect_quantum_rock then
				if
					G.worm_quantum_rock ~= self
					or not self.states.visible
					or (not self.worm_protect_quantum_rock_area and (self.area == G.deck))
					or (
						not self.worm_protect_quantum_rock_boundaries
						and (
							(self.VT.w <= 0 or self.VT.h <= 0)
							or (self.VT.x + self.VT.w < 0)
							or (self.VT.y + self.VT.h < 0)
							or (self.VT.x > G.ROOM.T.x + G.ROOM.T.w + 1)
							or (self.VT.y > G.ROOM.T.y + G.ROOM.T.h + 1)
						)
					)
				then
					should_remove_rock = true
				end
			end
		end
		if self.REMOVED and self.area then
			self:remove()
		end
	end
	old_card_update(self, ...)
	if should_remove_rock then
		destroy_rock(true)
	end
end

local old_save = Card.save
function Card:save(...)
	if is_rock(self) then
		return nil
	end
	return old_save(self, ...)
end

local old_load = Card.load
function Card:load(...)
	old_load(self, ...)
	if is_rock(self) then
		destroy_rock(true)
	end
end

local old_overlay_menu = G.FUNCS.overlay_menu
function G.FUNCS.overlay_menu(...)
	local is_replace = G.OVERLAY_MENU
	local r = old_overlay_menu(...)
	if not is_replace then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.25,
			timer = "REAL",
			pause_force = true,
			blocking = false,
			blockable = false,
			func = function()
				if G.OVERLAY_MENU then
					if is_rock_present() then
						function crawl(e)
							local parent = e.UIBox or e.parent
							while parent do
								e = parent
								parent = e.UIBox or e.parent
							end
							return e
						end
						local parent = crawl(G.worm_quantum_rock)
						if parent ~= G.OVERLAY_MENU then
							destroy_rock(true)
						end
					else
						spawn_new_rock()
					end
				end
				return true
			end,
		}))
	end
	return r
end

local old_card_init = Card.init
function Card:init(...)
	local r = old_card_init(self, ...)
	if is_rock(self) then
		if not is_rock_present() then
			G.worm_quantum_rock = self
		end
		if G.worm_force_replace_quantum_rock then
			if is_rock_present() and G.worm_quantum_rock ~= self then
				destroy_rock()
			end
			G.worm_quantum_rock = self
		else
			if G.worm_quantum_rock ~= self and not (self.area and self.area.config.collection) then
				destroy_rock(true)
			end
		end
	end
	return r
end

local wipe_on_ref = G.FUNCS.wipe_on
function G.FUNCS.wipe_on(...)
	local r = wipe_on_ref(...)
	if G.screenwipecard then
		if G.worm_quantum_rock_target == "screenswipe" then
			G.screenwipecard.children.front.states.visible = false
			G.screenwipecard.children.center.atlas = SMODS.get_atlas(rock.atlas)
			G.screenwipecard.children.center:set_sprite_pos(rock.pos)
		end
	end
	return r
end

local old_end_consumeable = G.FUNCS.end_consumeable
function G.FUNCS.end_consumeable(...)
	spawn_new_rock(true, {
		shop_jokers = true,
		shop_boosters = true,
		shop_vouchers = true,
	})
	return old_end_consumeable(...)
end

--

local function calculate_rock(context)
	if not WORM_JTEM.quantum_rock.enabled then
		return
	end
	local target = G.worm_quantum_rock_target or roll_new_rock_target()
	local is_present = is_rock_present()
	if target == "hand" then
		if
			context.stay_flipped
			and (G.STATE == G.STATES.DRAW_TO_HAND or (SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.draw_hand))
			and not is_present
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					if is_rock_present() then
						return true
					end
					local _area = G.deck
					local card = Card(_area.T.x, _area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS["S_J"], rock)
					G.worm_quantum_rock = card
					card.facing = "back"
					card.sprite_facing = "back"
					card.worm_protect_quantum_rock = true
					roll_new_rock_target()
					G.E_MANAGER:add_event(Event({
						func = function()
							G.hand:emplace(card)
							shuffle_in_area(card, G.hand)
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 0.25,
								timer = "REAL",
								blocking = false,
								blockable = false,
								func = function()
									card.worm_protect_quantum_rock = nil
									return true
								end,
							}))
							return true
						end,
					}))
					return true
				end,
			}))
			return true
		end
	elseif target == "deck" then
		if context.worm_opening_deck then
			G.worm_force_replace_quantum_rock = true
			local _area = pseudorandom_element(context.areas, "worm_quantum_rock" .. os.time())
			local card = Card(_area.T.x, _area.T.y, G.CARD_W * 0.7, G.CARD_H * 0.7, nil, rock)
			G.worm_force_replace_quantum_rock = nil
			G.worm_quantum_rock = card
			card.worm_protect_quantum_rock_boundaries = true
			emplace_and_shuffle_in_area(card, _area)
			roll_new_rock_target()
		end
	elseif target == "booster_pack" then
		if context.open_booster and not is_present then
			G.E_MANAGER:add_event(Event({
				blocking = false,
				blockable = false,
				func = function()
					if not G.GAME.PACK_INTERRUPT then
						return true
					end
					if G.pack_cards then
						G.E_MANAGER:add_event(Event({
							blocking = false,
							func = function()
								local _area = G.pack_cards
								local card = Card(_area.T.x, _area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS["S_J"], rock)
								G.worm_quantum_rock = card
								emplace_and_shuffle_in_area(card, _area)
								card:start_materialize()
								roll_new_rock_target()
								return true
							end,
						}))
						return true
					end
				end,
			}))
		end
	elseif target == "shop_jokers" or target == "shop_vouchers" or target == "shop_boosters" then
		if context.starting_shop and not is_present then
			spawn_new_rock()
		end
	end
end

WORM_JTEM.quantum_rock = {
	enabled = true,
	center = rock,
	calculate = calculate_rock,
}
