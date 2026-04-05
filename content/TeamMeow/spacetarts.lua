local spacetart_gradient = SMODS.Gradient({
	key = "spacetart_gradient",
	colours = {
		darken(HEX("5b4bf0"), 0.3),
		darken(HEX("2e4bff"), 0.2),
	},
	cycle = 3,
})

SMODS.ConsumableType({
	key = "worm_meow_Spacetart",
	primary_colour = HEX("424e54"),
	secondary_colour = spacetart_gradient,
	select_card = "consumeables",
	default = "c_worm_stellar_strawberry",
	collection_rows = { 3, 3 },
	shop_rate = 3,
	text_colour = HEX("fddca0"),
})

SMODS.Atlas({
	key = "meow_spacetart",
	px = 71,
	py = 95,
	path = "TeamMeow/spacetarts.png",
})

SMODS.Atlas({
	key = "meow_sparkle",
	px = 71,
	py = 95,
	path = "TeamMeow/sparkle.png",
	frames = 7,
	atlas_table = "ANIMATION_ATLAS",
})

SMODS.Atlas({
	key = "meow_sparkleBg",
	px = 71,
	py = 95,
	path = "TeamMeow/sparkleBg.png",
	frames = 7,
	atlas_table = "ANIMATION_ATLAS",
})

local ref = Card.init
function Card:init(...)
	local ret = ref(self, ...)
	self.tarts = {}
	return ret
end

local card_save = Card.save
function Card:save(...)
	local st = card_save(self, ...)
	st.tarts = self.tarts
	return st
end

local card_load = Card.load
function Card:load(cardTable, other_card, ...)
	local st = card_load(self, cardTable, other_card, ...)
	self.tarts = cardTable.tarts
	return st
end

Wormhole.TEAM_MEOW.tartInfo = {}
function SpaceTart(args)
	local ex_table = {}
	ex_table.tart = args.key
	ex_table.tart_cfg = args.config
	SMODS.Consumable({
		key = args.key,
		set = "worm_meow_Spacetart",
		atlas = "meow_spacetart",
		soul_pos = args.foil_pos,
		pos = args.tart_pos,
		config = {
			extra = ex_table,
		},
		loc_vars = args.loc_vars,
		can_use = function(self, card)
			return false
		end,
		generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
			if not card then
				card = self:create_fake_card()
			end
			card.ability.extra.tart_cfg = specific_vars.tart_cfg or card.ability.extra.tart_cfg
			local target = {
				type = "descriptions",
				key = self.key,
				set = self.set,
				nodes = desc_nodes,
				AUT = full_UI_table,
				vars = specific_vars or {},
			}
			local res = {}
			if self.loc_vars and type(self.loc_vars) == "function" then
				res = self:loc_vars(info_queue, card, card.ability.extra.tart_cfg, specific_vars.boost_count) or {}
				target.vars = res.vars or target.vars
				target.key = res.key or target.key
				if specific_vars.boost_count ~= nil then
					target.key = self.key
						.. "_"
						.. ((specific_vars.boost_count > 0) and "boosted" .. specific_vars.boost_count or "regular")
				end
				target.set = res.set or target.set
				target.scale = res.scale
				target.text_colour = res.text_colour
				if desc_nodes == full_UI_table.main then
					full_UI_table.box_starts = res.box_starts
					full_UI_table.box_ends = res.box_ends
				end
			end

			if desc_nodes == full_UI_table.main and not full_UI_table.name then
				full_UI_table.name = localize({
					type = "name",
					set = target.set,
					key = res.name_key or target.key,
					nodes = full_UI_table.name,
					vars = res.name_vars or target.vars or {},
				})
			elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name then
				desc_nodes.name = localize({ type = "name_text", key = res.name_key or target.key, set = target.set })
				if
					(full_UI_table.from_detailed_tooltip and full_UI_table.info[1] == desc_nodes)
					and not full_UI_table.no_styled_name
				then
					desc_nodes.name_styled = {}

					localize({
						type = "name",
						key = res.name_key or target.key,
						set = target.set,
						nodes = desc_nodes.name_styled,
						fixed_scale = 0.63,
						no_pop_in = true,
						no_shadow = true,
						y_offset = 0,
						no_spacing = true,
						no_bump = true,
						vars = target.vars,
					})
					desc_nodes.name_styled = SMODS.info_queue_desc_from_rows(desc_nodes.name_styled, true)
					desc_nodes.name_styled.config.align = "cm"
				end
			end

			if specific_vars and specific_vars.debuffed and not res.replace_debuff then
				target = {
					type = "other",
					key = "debuffed_" .. (specific_vars.playing_card and "playing_card" or "default"),
					nodes = desc_nodes,
					AUT = full_UI_table,
				}
			end
			if res.main_start then
				desc_nodes[#desc_nodes + 1] = res.main_start
			end

			localize(target)

			if type(specific_vars.stacks) == "number" then
				localize({
					type = "other",
					key = "worm_meow_spacetart_stacks",
					vars = { specific_vars.stacks },
					nodes = desc_nodes,
					AUT = full_UI_table,
				})
			end

			if res.main_end then
				desc_nodes[#desc_nodes + 1] = res.main_end
			end
			desc_nodes.background_colour = res.background_colour
		end,
	})
	Wormhole.TEAM_MEOW.tartInfo[args.key] = {
		--boosts = args.boosted_jokers,
		boosted_conds = args.boosted_conds,
		pos = args.foil_pos,
		funcs = args.calculates,
	}
end

local gcu = generate_card_ui
function generate_card_ui(
	_c,
	full_UI_table,
	specific_vars,
	card_type,
	badges,
	hide_desc,
	main_start,
	main_end,
	card,
	...
)
	local ret = gcu(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card, ...)
	if card and card.tarts then
		local map = {}
		for _, v in ipairs(card.tarts) do
			map[v.center_key] = map[v.center_key] and (map[v.center_key] + 1) or 1
		end
		local seen = {}
		for _, v in ipairs(card.tarts) do
			if not seen[v.key] then
				seen[v.key] = true
				local tab = Wormhole.TEAM_MEOW.tartInfo[v.key]

				local boost_count = 0
				if type(tab.boosted_conds) == "function" then
					local v = tab.boosted_conds(card)

					if type(v) == "boolean" and v then
						boost_count = boost_count + 1
					elseif type(v) == "number" then
						boost_count = boost_count + v
					end
				else
					for _, boost_test in pairs(tab.boosted_conds) do
						local v = boost_test(card)

						if type(v) == "boolean" and v then
							boost_count = boost_count + 1
						elseif type(v) == "number" then
							boost_count = boost_count + v
						end
					end
				end

				local amt = nil
				for k, num in pairs(map) do
					if k == v.center_key then
						amt = num
					end
				end
				--[[
				for _, k in ipairs(tab.boosts) do
					if k == card.config.center_key then
						is_boosted = true
						break
					end
				end]]
				generate_card_ui(
					G.P_CENTERS[v.center_key],
					ret,
					{ stacks = amt, boost_count = boost_count, tart_cfg = v.config }
				)
			end
		end
	end
	return ret
end

local card_joker_calc = Card.calculate_joker
function Card:calculate_joker(context, ...)
	local calc_res, has_post = card_joker_calc(self, context, ...)
	local ret = { calc_res }
	if self.tarts and not self.debuff and not context.blueprint and not context.retrigger_joker then
		for _, tart in ipairs(self.tarts) do
			local entry = Wormhole.TEAM_MEOW.tartInfo[tart.key]
			local calc_res = nil

			local boost_count = 0
			if type(entry.boosted_conds) == "function" then
				local v = entry.boosted_conds(self)

				if type(v) == "boolean" and v then
					boost_count = boost_count + 1
				elseif type(v) == "number" then
					boost_count = boost_count + v
				end
			else
				for _, boost_test in pairs(entry.boosted_conds) do
					local v = boost_test(self)

					if type(v) == "boolean" and v then
						boost_count = boost_count + 1
					elseif type(v) == "number" then
						boost_count = boost_count + v
					end
				end
			end

			--[[for _, key in ipairs(entry.boosts) do
				if key == self.config.center_key then
					is_boosted = true
					break
				end
			end]]

			local ability_number = math.min(#entry.funcs, boost_count + 1)
			calc_res = entry.funcs[ability_number](self, tart.config, context, boost_count) or {}

			ret[#ret + 1] = calc_res
		end
	end
	return SMODS.merge_effects(ret), has_post
end

SpaceTart({
	key = "stellar_strawberry",
	tart_pos = { x = 1, y = 2 },
	foil_pos = { x = 1, y = 0 },
	config = {
		reg = 1.5,
		boosted1 = 2.5,
		boosted2 = 4,
	},
	calculates = {
		-- Default ability
		function(card, tart_config, context, boost_count)
			if context.joker_main then
				return {
					xmult = tart_config.reg,
				}
			end
		end,

		-- Level 1 boosted ability
		function(card, tart_config, context, boost_count)
			if context.joker_main then
				return {
					xmult = tart_config.boosted1,
				}
			end
		end,

		-- Level 2 boosted ability
		function(card, tart_config, context)
			if context.joker_main then
				return {
					xmult = tart_config.boosted2,
				}
			end
		end,
	},
	loc_vars = function(self, info_queue, card, tart_config, boost_count)
		return {
			vars = {
				boost_count and (tart_config["boosted" .. boost_count] or tart_config.boosted) or tart_config.reg,
			},
		}
	end,
	--[[boosted_jokers = {
		"j_joker",
	},]]
	boosted_conds = {
		-- First condition
		function(card)
			return card.config and card.config.center_key == "j_joker"
		end,

		-- Second condition
		function(card)
			return G.GAME.blind.boss
		end,
	},
})

-- create_tart("stellar_strawberry", { x = 1, y = 2 }, { x = 1, y = 0 }, function(card, context)
-- 	return { message = "test" }
-- end, function(card, context)
-- 	if context.joker_main then
-- 		return {
-- 			message = "betterTest",
-- 		}
-- 	end
-- end, "j_joker")
-- create_tart("celestial_cinnamon", { x = 2, y = 2 }, { x = 2, y = 0 }, function(card, context)
-- 	return { message = "test" }
-- end, function(card, context)
-- 	if context.joker_main then
-- 		return {
-- 			message = "betterTest",
-- 		}
-- 	end
-- end, "j_joker")
-- create_tart("lunar_lemon", { x = 3, y = 2 }, { x = 3, y = 0 }, function(card, context)
-- 	return { message = "test" }
-- end, function(card, context)
-- 	if context.joker_main then
-- 		return {
-- 			message = "betterTest",
-- 		}
-- 	end
-- end, "j_joker")
-- create_tart("meteor_mint", { x = 1, y = 3 }, { x = 1, y = 1 }, function(card, context)
-- 	return { message = "test" }
-- end, function(card, context)
-- 	if context.joker_main then
-- 		return {
-- 			message = "betterTest",
-- 		}
-- 	end
-- end, "j_joker")
-- create_tart("blueshift_blueberry", { x = 2, y = 3 }, { x = 2, y = 1 }, function(card, context)
-- 	return { message = "test" }
-- end, function(card, context)
-- 	if context.joker_main then
-- 		return {
-- 			message = "betterTest",
-- 		}
-- 	end
-- end, "j_joker")
-- create_tart("big_bang_blackberry", { x = 3, y = 3 }, { x = 3, y = 1 }, function(card, context)
-- 	return { message = "test" }
-- end, function(card, context)
-- 	if context.joker_main then
-- 		return {
-- 			message = "betterTest",
-- 		}
-- 	end
-- end, "j_joker")

SMODS.DrawStep({
	key = "tarts",
	order = 100,
	func = function(card)
		local yshift = 0
		local yinc = 0.2 / 3
		if card.tarts then
			for _, v in ipairs(card.tarts) do
				local tartObj = Wormhole.TEAM_MEOW.tartInfo[v.key]
				tartObj.sprite = tartObj.sprite
					or Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["worm_meow_spacetart"], tartObj.pos)
				local tartSprite = tartObj.sprite
				tartSprite.role.draw_major = card
				tartSprite:draw_shader("dissolve", 0, nil, nil, card.children.center, 0, 0, 0, yshift, nil, 0.6)
				tartSprite:draw_shader("dissolve", nil, nil, nil, card.children.center, 0, 0, 0, yshift)
				yshift = yshift + yinc
			end
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

SMODS.DrawStep({
	key = "sparkle",
	order = 150,
	func = function(card)
		local bool = false
		if G.jokers and G.jokers.cards then
			for k, v in pairs(G.jokers.cards) do
				if meow_cards_are_colliding(card, v) and meow_can_apply_foil(v) then
					bool = true
				end
			end
		end
		local playerHas = false
		if G.consumeables and G.consumeables.cards then
			for k, v in pairs(G.consumeables.cards) do
				if v == card then
					playerHas = true
				end
			end
		end
		if card.ability.set == "worm_meow_Spacetart" and bool and playerHas then
			Wormhole.TEAM_MEOW.sharedSparkleBg = Wormhole.TEAM_MEOW.sharedSparkleBg
				or AnimatedSprite(0, 0, G.CARD_W, G.CARD_H, G.ANIMATION_ATLAS["worm_meow_sparkleBg"], { x = 0, y = 0 })
			Wormhole.TEAM_MEOW.sharedSparkleBg.role.draw_major = card
			Wormhole.TEAM_MEOW.sharedSparkleBg:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				card.children.center,
				0.025,
				0,
				0,
				0
			)
			Wormhole.TEAM_MEOW.sharedSparkle = Wormhole.TEAM_MEOW.sharedSparkle
				or AnimatedSprite(0, 0, G.CARD_W, G.CARD_H, G.ANIMATION_ATLAS["worm_meow_sparkle"], { x = 0, y = 0 })
			Wormhole.TEAM_MEOW.sharedSparkle.role.draw_major = card
			Wormhole.TEAM_MEOW.sharedSparkle:draw_shader("dissolve", nil, nil, nil, card.children.center, 0, 0, 0, 0)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

local old = Card.draw
function Card:draw(...)
	local ret = old(self, ...)
	local bool = false
	if G.jokers and G.jokers.cards then
		for k, v in ipairs(G.jokers.cards) do
			if meow_cards_are_colliding(self, v) and self ~= v then
				bool = true
			end
		end
	end
	local color = bool and HEX("63c74d") or HEX("ff0044")
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(color[1], color[2], color[3], 0.25)
	if Wormhole.TEAM_MEOW.DEBUG then
		love.graphics.rectangle(
			"fill",
			self.T.x * G.TILESIZE * G.TILESCALE,
			self.T.y * G.TILESIZE * G.TILESCALE,
			self.T.w * G.TILESIZE * G.TILESCALE,
			self.T.h * G.TILESIZE * G.TILESCALE
		)
	end
	love.graphics.setColor(r, g, b, a)
end

-- Dragging tarts on jokers

local old = Card.stop_drag
function Card:stop_drag(...)
	local ret = old(self, ...)
	local bool = false
	local colliders = {}
	if G.jokers and G.jokers.cards then
		for k, v in pairs(G.jokers.cards) do
			if meow_cards_are_colliding(self, v) and meow_can_apply_foil(v) then
				bool = true
				table.insert(colliders, { card = v, dist = meow_get_distance_between_two_cards(v, self) })
			end
		end
	end
	local playerHas = false
	if G.consumeables and G.consumeables.cards then
		for k, v in pairs(G.consumeables.cards) do
			if v == self then
				playerHas = true
			end
		end
	end
	if self.ability and self.ability.set == "worm_meow_Spacetart" and bool and playerHas then
		local tart = {
			key = self.ability.extra.tart,
			config = self.ability.extra.tart_cfg or {},
			center_key = self.config.center_key,
		}
		table.sort(colliders, function(a, b)
			return a.dist < b.dist
		end)
		table.insert(colliders[1].card.tarts, tart)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			func = function()
				self:start_dissolve(nil, nil, 0.9)
				play_sound("worm_meowChomp", 1 + 0.5 * (math.random() - 0.5), 0.6)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.6,
			func = function()
				play_sound("tarot1")
				colliders[1].card:juice_up(0.5, 0.5)
				card_eval_status_text(
					colliders[1].card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_worm_meow_ate") }
				)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot2", nil, 0.8)
				colliders[1].card:juice_up(0.2, 0.5)
				love.mouse.setCursor()
				return true
			end,
		}))
	end
	return ret
end

local old = Game.update
function Game:update(dt, ...)
	local ret = old(self, dt, ...)
	local alreadyset = false
	if G.consumeables and G.consumeables.cards and not G.SETTINGS.paused then
		for k, v in pairs(G.consumeables.cards) do
			if v.ability and v.ability.set == "worm_meow_Spacetart" then
				local bool = false
				if G.jokers and G.jokers.cards then
					for k, vv in pairs(G.jokers.cards) do
						if meow_cards_are_colliding(v, vv) and meow_can_apply_foil(vv) then
							bool = true
						end
					end
				end
				if bool then
					love.mouse.setCursor(Wormhole.TEAM_MEOW.cursor)
					alreadyset = true
				elseif not alreadyset then
					love.mouse.setCursor()
				end
			end
		end
	end
end

-- Exchanging tarts

local old = Card.stop_drag
function Card:stop_drag(...)
	local ret = old(self, ...)
	local bool = false
	local colliders = {}
	if G.jokers and G.jokers.cards then
		for k, v in pairs(G.jokers.cards) do
			if meow_cards_are_colliding(self, v) and meow_can_apply_foil(v) and v ~= self then
				bool = true
				table.insert(colliders, { card = v, dist = meow_get_distance_between_two_cards(v, self) })
			end
		end
	end
	table.sort(colliders, function(a, b)
		return a.dist < b.dist
	end)
	if self.ability and self.ability.set == "Joker" and bool and self.tarts and #self.tarts > 0 then
		local tart
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			func = function()
				tart = table.remove(self.tarts, #self.tarts)
				table.insert(colliders[1].card.tarts, tart)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.6,
			func = function()
				play_sound("tarot1")
				colliders[1].card:juice_up(0.5, 0.5)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot2", nil, 0.8)
				colliders[1].card:juice_up(0.2, 0.5)
				love.mouse.setCursor()
				return true
			end,
		}))
	end
	return ret
end

local old = Game.update
function Game:update(dt, ...)
	local ret = old(self, dt, ...)
	local alreadyset = false
	if G.jokers and G.jokers.cards and not G.SETTINGS.paused then
		for k, v in pairs(G.jokers.cards) do
			if v.ability and v.ability.set == "Joker" and v.tarts and #v.tarts > 0 then
				local bool = false
				for kk, vv in pairs(G.jokers.cards) do
					if vv ~= v and meow_cards_are_colliding(v, vv) and meow_can_apply_foil(vv) then
						bool = true
					end
				end
				if bool then
					love.mouse.setCursor(Wormhole.TEAM_MEOW.cursor)
					alreadyset = true
				elseif not alreadyset then
					love.mouse.setCursor()
				end
			end
		end
	end
end
local old = Game.update
function Game:update(dt, ...)
	local ret = old(self, dt, ...)
	if G.consumeables and G.consumeables.cards then
		for k, v in ipairs(G.consumeables.cards) do
			if v.ability and v.ability.set == "worm_meow_Spacetart" and not G.GAME.shown_tart_poppup then
				G.GAME.shown_tart_poppup = true
				Wormhole.TEAM_MEOW.open_spacetart_info_menu()
			end
		end
	end
end
