-- Joker is very wonky and buggy, need more time in the oven
if true then
	return
end

local rock = SMODS.Joker({
	key = "jtem2_quantum_rock",

	ppu_team = { "jtem2" },
	ppu_coder = { "sleepyg11" },
})

rock.emplace_in_area = function(card, area)
	local new_index = pseudorandom("wormhole_quantum_rock" .. os.time(), 1, #area.cards + 1)
	table.insert(area.cards, new_index, card)
	if card.facing == "back" and area.config.type ~= "discard" and area.config.type ~= "deck" then
		card:flip()
	end

	card:set_card_area(area)
	area:set_ranks()
	area:align_cards()
	card:hard_set_T()
end
rock.shuffle_in_area = function(card, area)
	for index, _card in ipairs(area.cards) do
		if _card == card then
			table.remove(area.cards, index)
			break
		end
	end
	local new_index = pseudorandom("wormhole_quantum_rock" .. os.time(), 1, #area.cards + 1)
	table.insert(area.cards, new_index, card)
	card:hard_set_T()
end
rock.is_present = function()
	return G.wormhole_quantum_rock
		and not G.wormhole_quantum_rock.REMOVED
		and not G.wormhole_quantum_rock.wormhole_delay_quantum_rock_remove
end
rock.force_destroy = function(card, delay, no_replace)
	card.states.visible = false
	if delay then
		card.wormhole_delay_quantum_rock_remove = true
		G.E_MANAGER:add_event(Event({
			blocking = false,
			func = function()
				card.wormhole_keep_quantum_rock_target = true
				card:remove()
				return true
			end,
		}))
	else
		card.wormhole_keep_quantum_rock_target = true
		card:remove()
	end
	if not no_replace then
		rock.spawn_new_one()
	end
	G.wormhole_quantum_rock_target = rock.roll_new_target()
end
rock.is_rock = function(card)
	return card and card.wormhole_was_quantum_rock or (card.config.center and card.config.center.key == rock.key)
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
	if WORM_JTEM.quantum_rock.enabled then
		G.wormhole_quantum_rock_target = G.wormhole_quantum_rock_target or rock.roll_new_target()
		G.wormhole_quantum_rock_target_dt = G.wormhole_quantum_rock_target_dt or G.TIMERS.REAL
		if G.TIMERS.REAL - G.wormhole_quantum_rock_target_dt > 1 then
			-- G.wormhole_quantum_rock_target = rock.roll_new_target()
			G.wormhole_quantum_rock_target_dt = G.TIMERS.REAL
		end
		if G.wormhole_quantum_rock then
			if G.wormhole_quantum_rock.REMOVED and G.wormhole_quantum_rock.area then
				G.wormhole_quantum_rock:remove()
				G.wormhole_quantum_rock = nil
			end
		end
	else
		G.wormhole_quantum_rock_target = nil
	end
end

local old_card_update = Card.update
function Card:update(...)
	local should_remove_rock = false
	if rock.is_rock(self) then
		self.wormhole_was_quantum_rock = true
		if self.area == G.play and G.STATE ~= G.STATES.HAND_PLAYED then
			G.play:remove_card(self)
			G.discard:emplace(self)
		end
		if not self.REMOVED and not self.wormhole_delay_quantum_rock_remove then
			if not rock.is_present() then
				G.wormhole_quantum_rock = self
			end
			if not self.wormhole_protect_quantum_rock then
				if
					G.wormhole_quantum_rock ~= self
					or not self.states.visible
					or (not self.wormhole_protect_quantum_rock_area and (self.area == G.deck))
					or (
						not self.wormhole_protect_quantum_rock_boundaries
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
		rock.force_destroy(self, true)
	end
end

local old_save = Card.save
function Card:save(...)
	if rock.is_rock(self) then
		return nil
	end
	return old_save(self, ...)
end

local old_load = Card.load
function Card:load(...)
	old_load(self, ...)
	if rock.is_rock(self) then
		rock.force_destroy(self, true)
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
					if rock.is_present() then
						function crawl(e)
							local parent = e.UIBox or e.parent
							while parent do
								e = parent
								parent = e.UIBox or e.parent
							end
							return e
						end
						local parent = crawl(G.wormhole_quantum_rock)
						if parent ~= G.OVERLAY_MENU then
							rock.force_destroy(G.wormhole_quantum_rock, true)
						end
					else
						rock.spawn_new_one()
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
	if rock.is_rock(self) then
		if not rock.is_present() then
			G.wormhole_quantum_rock = self
		end
		if G.wormhole_quantum_rock ~= self then
			rock.force_destroy(self, true)
		end
	end
	return r
end

--

rock.roll_new_target = function()
	if not WORM_JTEM.quantum_rock.enabled then
		return nil
	end
	local targets = {
		"hand",
		"play",
		"deck",
		"jokers",
		"consumeables",
		-- "booster_pack",
		-- "collection_jokers",
		-- "shop_jokers",
		-- "shop_boosters",
		-- "shop_vouchers",
		-- "vouchers",
		-- "poker_hand",
		-- "collection_jokers",
	}
	local result = pseudorandom_element(targets, "wormhole_quantum_rock" .. os.time())
	print("new target is", result)
	return result
end
rock.calculate_rock = function(context)
	local target = G.wormhole_quantum_rock_target or rock.roll_new_target()
	local is_present = rock.is_present()
	if target == "hand" then
		if
			context.stay_flipped
			and (G.STATE == G.STATES.DRAW_TO_HAND or (SMODS.OPENED_BOOSTER and SMODS.OPENED_BOOSTER.config.center.draw_hand))
			and not is_present
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					if rock.is_present() then
						return true
					end
					local _area = G.deck
					local card = Card(_area.T.x, _area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS["C_J"], rock)
					card.facing = "back"
					card.sprite_facing = "back"
					card.wormhole_protect_quantum_rock = true
					G.wormhole_quantum_rock_target = rock.roll_new_target()
					G.wormhole_quantum_rock = card
					G.E_MANAGER:add_event(Event({
						func = function()
							G.hand:emplace(card)
							rock.shuffle_in_area(card, G.hand)
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 0.25,
								timer = "REAL",
								blocking = false,
								blockable = false,
								func = function()
									card.wormhole_protect_quantum_rock = nil
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
		if context.wormhole_opening_deck and not is_present then
			local _area = pseudorandom_element(context.areas, "wormhole_quantum_rock" .. os.time())
			local card = Card(_area.T.x, _area.T.y, G.CARD_W * 0.7, G.CARD_H * 0.7, nil, rock)
			card.wormhole_protect_quantum_rock_boundaries = true
			rock.emplace_in_area(card, _area)
			G.wormhole_quantum_rock_target = rock.roll_new_target()
			G.wormhole_quantum_rock = card
		end
	elseif target == "booster_pack" then
		if context.open_booster and not is_present then
			G.E_MANAGER:add_event(Event({
				blocking = false,
				blockable = false,
				func = function()
					if G.pack_cards then
						G.E_MANAGER:add_event(Event({
							blocking = false,
							func = function()
								local _area = G.pack_cards
								local card = Card(_area.T.x, _area.T.y, G.CARD_W, G.CARD_H, nil, rock)
								rock.emplace_in_area(card, _area)
								card:start_materialize()
								G.wormhole_quantum_rock_target = rock.roll_new_target()
								G.wormhole_quantum_rock = card
								return true
							end,
						}))
						return true
					end
				end,
			}))
		end
		--     return true
		-- 	G.E_MANAGER:add_event(Event({
		-- 		func = function()
		-- 		end,
		-- 	}))
		-- end
	end
end
rock.spawn_new_one = function()
	local target = G.wormhole_quantum_rock_target
	local function simple_create(area)
		local card = Card(area.T.x + area.T.w / 2 - G.CARD_W / 2, area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS["C_J"], rock)
		rock.emplace_in_area(card, area)
	end
	if target == "play" and G.play and G.STATE == G.STATES.HAND_PLAYED then
		simple_create(G.play)
	elseif target == "hand" and G.hand and G.STATE == G.STATES.SELECTING_HAND then
		local area = G.hand
		local card = Card(area.T.x + area.T.w / 2 - G.CARD_W / 2, area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS["C_J"], rock)
		area:emplace(card)
		rock.shuffle_in_area(card, area)
		G.wormhole_quantum_rock_target = rock.roll_new_target()
	elseif target == "jokers" and G.jokers then
		simple_create(G.jokers)
	elseif target == "consumeables" and G.consumeables then
		simple_create(G.consumeables)
	elseif target == "voucher" and G.voucher then
		simple_create(G.voucher)
	elseif target == "booster_pack" and G.pack_cards then
		simple_create(G.pack_cards)
	end
end

WORM_JTEM.quantum_rock = {
	enabled = false,
	center = rock,
	calculate = rock.calculate_rock,
}
